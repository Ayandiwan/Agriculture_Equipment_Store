using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Agriculture_Equipment_Store
{
    public partial class Products : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Ensure user is logged in
            if (Session["UserId"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            userId = Convert.ToInt32(Session["UserId"]);

            if (!IsPostBack)
                BindProducts();
        }

        private void BindProducts(string search = "")
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                string query = "SELECT * FROM Products WHERE IsActive = 1";

                if (!string.IsNullOrEmpty(search))
                    query += " AND (Name LIKE @search OR Category LIKE @search)";

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(search))
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);

                rptProducts.DataSource = dt;
                rptProducts.DataBind();

                lblNoProducts.Visible = dt.Rows.Count == 0;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindProducts(txtSearch.Text.Trim());
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            BindProducts();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtQty = (TextBox)item.FindControl("txtQty");

            int qty = 1;
            if (!int.TryParse(txtQty.Text, out qty) || qty < 1) qty = 1;

            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();

                // ✅ Check stock first
                SqlCommand stockCmd = new SqlCommand("SELECT Stock FROM Products WHERE ProductID=@pid AND IsActive=1", con);
                stockCmd.Parameters.AddWithValue("@pid", productId);
                object stockObj = stockCmd.ExecuteScalar();

                if (stockObj == null)
                {
                    Response.Write("<script>alert('Product not found!');</script>");
                    return;
                }

                int stock = Convert.ToInt32(stockObj);
                if (qty > stock)
                {
                    Response.Write($"<script>alert('Only {stock} items available!');</script>");
                    return;
                }

                // ✅ Check if product already in cart
                SqlCommand checkCmd = new SqlCommand("SELECT Quantity FROM Cart WHERE UserID=@uid AND ProductID=@pid", con);
                checkCmd.Parameters.AddWithValue("@uid", userId);
                checkCmd.Parameters.AddWithValue("@pid", productId);
                object existingQty = checkCmd.ExecuteScalar();

                if (existingQty != null)
                {
                    SqlCommand updateCmd = new SqlCommand(
                        "UPDATE Cart SET Quantity = Quantity + @qty WHERE UserID=@uid AND ProductID=@pid", con);
                    updateCmd.Parameters.AddWithValue("@qty", qty);
                    updateCmd.Parameters.AddWithValue("@uid", userId);
                    updateCmd.Parameters.AddWithValue("@pid", productId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand insertCmd = new SqlCommand(
                        "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@uid,@pid,@qty)", con);
                    insertCmd.Parameters.AddWithValue("@uid", userId);
                    insertCmd.Parameters.AddWithValue("@pid", productId);
                    insertCmd.Parameters.AddWithValue("@qty", qty);
                    insertCmd.ExecuteNonQuery();
                }
            }

            Response.Write("<script>alert('Item added to cart successfully!');</script>");
            Response.Redirect("Cart.aspx");
        }
    }
}
