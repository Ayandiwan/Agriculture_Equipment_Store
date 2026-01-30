using System;
using System.Data.SqlClient;
using System.Configuration;

namespace Agriculture_Equipment_Store
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            userId = Convert.ToInt32(Session["userid"]);

            if (!IsPostBack)
            {
                if (Request.QueryString["pid"] != null)
                {
                    int productId;
                    if (int.TryParse(Request.QueryString["pid"], out productId))
                    {
                        LoadProduct(productId);
                    }
                    else
                    {
                        ShowError("Invalid product ID.");
                    }
                }
                else
                {
                    ShowError("No product selected.");
                }
            }
        }

        private void LoadProduct(int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(
                        "SELECT * FROM Products WHERE ProductID=@pid AND IsActive=1",
                        con
                    );
                    cmd.Parameters.AddWithValue("@pid", productId);

                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        pnlProduct.Visible = true;

                        imgProduct.ImageUrl = dr["ImagePath"].ToString();
                        lblName.InnerText = dr["Name"].ToString();
                        lblDescription.InnerText = dr["Description"].ToString();
                        lblCategory.InnerText = dr["Category"].ToString();
                        lblPrice.InnerText = dr["Price"].ToString();
                        lblStock.InnerText = dr["Stock"].ToString();
                    }
                    else
                    {
                        ShowError("Product not found or unavailable.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        // ---------------- Quantity Buttons ----------------

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            int qty = Convert.ToInt32(txtQtyDetails.Text);
            if (qty > 1)
                qty--;

            txtQtyDetails.Text = qty.ToString();
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            int qty = Convert.ToInt32(txtQtyDetails.Text);
            qty++;
            txtQtyDetails.Text = qty.ToString();
        }


        // ---------------- Add to Cart ----------------

        protected void btnAddToCartDetails_Click(object sender, EventArgs e)
        {
            try
            {
                int productId;
                if (!int.TryParse(Request.QueryString["pid"], out productId))
                {
                    ShowError("Invalid product.");
                    return;
                }

                int qty = 1;
                if (!int.TryParse(txtQtyDetails.Text.Trim(), out qty) || qty < 1)
                    qty = 1;

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();

                    SqlCommand stockCmd = new SqlCommand(
                        "SELECT Stock FROM Products WHERE ProductID=@pid AND IsActive=1",
                        con
                    );
                    stockCmd.Parameters.AddWithValue("@pid", productId);

                    object stockObj = stockCmd.ExecuteScalar();
                    if (stockObj == null)
                    {
                        ShowError("Product not available.");
                        return;
                    }

                    int stock = Convert.ToInt32(stockObj);

                    if (qty > stock)
                    {
                        ShowError($"Only {stock} items available.");
                        return;
                    }

                    SqlCommand checkCmd = new SqlCommand(
                        "SELECT Quantity FROM Cart WHERE UserID=@uid AND ProductID=@pid",
                        con
                    );
                    checkCmd.Parameters.AddWithValue("@uid", userId);
                    checkCmd.Parameters.AddWithValue("@pid", productId);

                    object existingQty = checkCmd.ExecuteScalar();

                    if (existingQty != null)
                    {
                        SqlCommand updateCmd = new SqlCommand(
                            "UPDATE Cart SET Quantity = Quantity + @qty WHERE UserID=@uid AND ProductID=@pid",
                            con
                        );
                        updateCmd.Parameters.AddWithValue("@qty", qty);
                        updateCmd.Parameters.AddWithValue("@uid", userId);
                        updateCmd.Parameters.AddWithValue("@pid", productId);

                        updateCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        SqlCommand insertCmd = new SqlCommand(
                            "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@uid,@pid,@qty)",
                            con
                        );
                        insertCmd.Parameters.AddWithValue("@uid", userId);
                        insertCmd.Parameters.AddWithValue("@pid", productId);
                        insertCmd.Parameters.AddWithValue("@qty", qty);

                        insertCmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("Cart.aspx");
            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
            }
        }

        private void ShowError(string message)
        {
            pnlProduct.Visible = false;
            lblError.Visible = true;
            lblError.Text = message;
        }
    }
}
