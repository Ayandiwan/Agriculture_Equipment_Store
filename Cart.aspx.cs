using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Agriculture_Equipment_Store
{
    public partial class Cart : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Verify login
            if (Session["UserId"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            userId = Convert.ToInt32(Session["UserId"]);

            if (!IsPostBack)
            {
                BindCart();

                // 🟩 Update cart badge count on master page
                (this.Master as Site1)?.UpdateCartCount();
            }
        }

        private void BindCart()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT c.CartID, p.Name AS ProductName, p.Category, p.Price, p.ImagePath, p.Stock, c.Quantity 
                    FROM Cart c 
                    INNER JOIN Products p ON c.ProductID = p.ProductID 
                    WHERE c.UserID = @uid", con);
                cmd.Parameters.AddWithValue("@uid", userId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCart.DataSource = dt;
                gvCart.DataBind();
                CalculateGrandTotal(dt);

                // 🟩 Save item count to session for badge
                Session["CartItems"] = dt;
                (this.Master as Site1)?.UpdateCartCount();
            }
        }

        private void CalculateGrandTotal(DataTable dt)
        {
            decimal total = 0;
            foreach (DataRow row in dt.Rows)
            {
                decimal price = row["Price"] == DBNull.Value ? 0 : Convert.ToDecimal(row["Price"]);
                int qty = row["Quantity"] == DBNull.Value ? 0 : Convert.ToInt32(row["Quantity"]);
                total += price * qty;
            }
            lblTotal.Text = total.ToString("N2");
        }

        protected string GetTotal(object priceObj, object qtyObj)
        {
            decimal price = priceObj == DBNull.Value ? 0 : Convert.ToDecimal(priceObj);
            int qty = qtyObj == DBNull.Value ? 0 : Convert.ToInt32(qtyObj);
            return (price * qty).ToString("N2");
        }

        protected void gvCart_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCart.EditIndex = e.NewEditIndex;
            BindCart();
        }

        protected void gvCart_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCart.EditIndex = -1;
            BindCart();
        }

        protected void gvCart_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvCart.Rows[e.RowIndex];
            int cartId = Convert.ToInt32(gvCart.DataKeys[e.RowIndex].Value);
            TextBox txtQty = (TextBox)row.FindControl("txtQuantity");
            int qty = 1;
            if (!int.TryParse(txtQty.Text, out qty) || qty < 1) qty = 1;

            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();

                // Check stock before update
                SqlCommand stockCheck = new SqlCommand(@"
                    SELECT p.Stock 
                    FROM Cart c 
                    INNER JOIN Products p ON c.ProductID = p.ProductID 
                    WHERE c.CartID=@cid", con);
                stockCheck.Parameters.AddWithValue("@cid", cartId);
                object result = stockCheck.ExecuteScalar();
                int stock = result == DBNull.Value ? 0 : Convert.ToInt32(result);
                if (qty > stock)
                {
                    Response.Write($"<script>alert('Only {stock} items in stock!');</script>");
                    return;
                }

                SqlCommand cmd = new SqlCommand("UPDATE Cart SET Quantity=@qty WHERE CartID=@cid", con);
                cmd.Parameters.AddWithValue("@qty", qty);
                cmd.Parameters.AddWithValue("@cid", cartId);
                cmd.ExecuteNonQuery();
            }

            gvCart.EditIndex = -1;
            BindCart();

            // 🟩 Update cart badge after update
            (this.Master as Site1)?.UpdateCartCount();
        }

        protected void gvCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cartId = Convert.ToInt32(gvCart.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Cart WHERE CartID=@cid", con);
                cmd.Parameters.AddWithValue("@cid", cartId);
                cmd.ExecuteNonQuery();
            }
            BindCart();

            // 🟩 Update badge after deletion
            (this.Master as Site1)?.UpdateCartCount();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();

                // 1️⃣ Check cart items
                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Cart WHERE UserID=@uid", con);
                check.Parameters.AddWithValue("@uid", userId);
                int count = (int)check.ExecuteScalar();
                if (count == 0)
                {
                    Response.Write("<script>alert('Cart is empty!');</script>");
                    return;
                }

                // 2️⃣ Get cart items with price and stock
                SqlCommand cartCmd = new SqlCommand(@"
                    SELECT c.ProductID, c.Quantity, p.Price, p.Stock, p.Name 
                    FROM Cart c 
                    INNER JOIN Products p ON c.ProductID = p.ProductID 
                    WHERE c.UserID=@uid", con);
                cartCmd.Parameters.AddWithValue("@uid", userId);
                DataTable dtCart = new DataTable();
                dtCart.Load(cartCmd.ExecuteReader());

                // 3️⃣ Calculate total
                decimal totalAmount = 0;
                foreach (DataRow row in dtCart.Rows)
                {
                    int qty = Convert.ToInt32(row["Quantity"]);
                    int stock = Convert.ToInt32(row["Stock"]);
                    decimal price = Convert.ToDecimal(row["Price"]);
                    string productName = row["Name"].ToString();

                    if (qty > stock)
                    {
                        Response.Write($"<script>alert('Only {stock} items left for {productName}!');</script>");
                        return;
                    }

                    totalAmount += qty * price;
                }

                // 4️⃣ Insert into Orders
                SqlCommand insertOrder = new SqlCommand(@"
                    INSERT INTO Orders(UserID, OrderDate, TotalAmount, Status) 
                    OUTPUT INSERTED.OrderID 
                    VALUES (@uid, GETDATE(), @total, 'Pending')", con);
                insertOrder.Parameters.AddWithValue("@uid", userId);
                insertOrder.Parameters.AddWithValue("@total", totalAmount);
                int newOrderId = (int)insertOrder.ExecuteScalar();

                // 5️⃣ Insert into OrderDetails & Update Stock
                foreach (DataRow row in dtCart.Rows)
                {
                    int pid = Convert.ToInt32(row["ProductID"]);
                    int qty = Convert.ToInt32(row["Quantity"]);
                    decimal price = Convert.ToDecimal(row["Price"]);

                    SqlCommand insertDetail = new SqlCommand(@"
                        INSERT INTO OrderDetails(OrderID, ProductID, Quantity, Price)
                        VALUES(@oid, @pid, @qty, @price)", con);
                    insertDetail.Parameters.AddWithValue("@oid", newOrderId);
                    insertDetail.Parameters.AddWithValue("@pid", pid);
                    insertDetail.Parameters.AddWithValue("@qty", qty);
                    insertDetail.Parameters.AddWithValue("@price", price);
                    insertDetail.ExecuteNonQuery();

                    SqlCommand updateStock = new SqlCommand("UPDATE Products SET Stock = Stock - @qty WHERE ProductID=@pid", con);
                    updateStock.Parameters.AddWithValue("@qty", qty);
                    updateStock.Parameters.AddWithValue("@pid", pid);
                    updateStock.ExecuteNonQuery();
                }

                // 6️⃣ Clear Cart
                SqlCommand clearCart = new SqlCommand("DELETE FROM Cart WHERE UserID=@uid", con);
                clearCart.Parameters.AddWithValue("@uid", userId);
                clearCart.ExecuteNonQuery();

                // 🟩 Update badge after checkout (now cart is empty)
                (this.Master as Site1)?.UpdateCartCount();

                // 7️⃣ Confirmation
                Response.Write("<script>alert('Order placed successfully!');</script>");
                Response.Redirect("Pro_Buy_otp.aspx?orderId=" + newOrderId);
            }
        }
    }
}
