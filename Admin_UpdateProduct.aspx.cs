using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace Agriculture_Equipment_Store
{
    public partial class Admin_UpdateProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProducts();
            }
        }

        private string GetConnectionString()
        {
            var cs = ConfigurationManager.ConnectionStrings["dbcon"]?.ConnectionString;
            if (string.IsNullOrEmpty(cs))
            {
                lblMessage.Text = "⚠️ Connection string 'dbcon' not found!";
                lblMessage.CssClass = "text-danger mt-3 d-block text-center fw-bold";
            }
            return cs;
        }

        private void BindProducts()
        {
            string cs = GetConnectionString();
            if (string.IsNullOrEmpty(cs)) return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ProductID, Name FROM Products WHERE IsActive=1 ORDER BY Name";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                var reader = cmd.ExecuteReader();
                ddlProducts.DataSource = reader;
                ddlProducts.DataTextField = "Name";
                ddlProducts.DataValueField = "ProductID";
                ddlProducts.DataBind();
                ddlProducts.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Product --", "0"));
                con.Close();
            }
        }

        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            string cs = GetConnectionString();
            if (string.IsNullOrEmpty(cs)) return;

            if (ddlProducts.SelectedValue != "0")
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT Name, Category, Price, Stock, Description, ImagePath FROM Products WHERE ProductID=@id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", ddlProducts.SelectedValue);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        txtName.Text = dr["Name"].ToString();
                        txtCategory.Text = dr["Category"].ToString();
                        txtPrice.Text = dr["Price"].ToString();
                        txtStock.Text = dr["Stock"].ToString();
                        txtDescription.Text = dr["Description"].ToString();
                        string imgPath = dr["ImagePath"].ToString();
                        imgPreview.Src = !string.IsNullOrEmpty(imgPath) ? ResolveUrl(imgPath) : "https://via.placeholder.com/250x200?text=Product+Image";
                    }
                    con.Close();
                }
            }
            else
            {
                txtName.Text = txtCategory.Text = txtPrice.Text = txtStock.Text = txtDescription.Text = "";
                imgPreview.Src = "https://via.placeholder.com/250x200?text=Product+Image";
            }
        }

        protected void btnUpdateProduct_Click(object sender, EventArgs e)
        {
            string cs = GetConnectionString();
            if (string.IsNullOrEmpty(cs)) return;

            if (ddlProducts.SelectedValue == "0")
            {
                lblMessage.Text = "⚠️ Please select a product!";
                lblMessage.CssClass = "text-danger mt-3 d-block text-center fw-bold";
                return;
            }

            if (!decimal.TryParse(txtPrice.Text.Trim(), out decimal price) || price < 0)
            {
                lblMessage.Text = "⚠️ Enter a valid price!";
                lblMessage.CssClass = "text-danger mt-3 d-block text-center fw-bold";
                return;
            }

            if (!int.TryParse(txtStock.Text.Trim(), out int stock) || stock < 0)
            {
                lblMessage.Text = "⚠️ Enter a valid stock!";
                lblMessage.CssClass = "text-danger mt-3 d-block text-center fw-bold";
                return;
            }

            string imagePath = "";
            if (fileUploadImage.HasFile)
            {
                string folderPath = Server.MapPath("~/image/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string filename = Path.GetFileName(fileUploadImage.FileName);
                string fullPath = Path.Combine(folderPath, filename);
                fileUploadImage.SaveAs(fullPath);

                imagePath = "/image/" + filename; // browser-accessible path
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE Products SET Name=@name, Category=@category, Price=@price, Stock=@stock, Description=@desc" +
                               (imagePath != "" ? ", ImagePath=@image" : "") +
                               " WHERE ProductID=@id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@category", txtCategory.Text.Trim());
                cmd.Parameters.AddWithValue("@price", price);
                cmd.Parameters.AddWithValue("@stock", stock);
                cmd.Parameters.AddWithValue("@desc", txtDescription.Text.Trim());
                cmd.Parameters.AddWithValue("@id", ddlProducts.SelectedValue);
                if (imagePath != "") cmd.Parameters.AddWithValue("@image", imagePath);

                con.Open();
                int rows = cmd.ExecuteNonQuery();
                con.Close();

                if (rows > 0)
                {
                    lblMessage.Text = "✅ Product updated successfully!";
                    lblMessage.CssClass = "text-success mt-3 d-block text-center fw-bold";
                }
                else
                {
                    lblMessage.Text = "⚠️ Failed to update product!";
                    lblMessage.CssClass = "text-danger mt-3 d-block text-center fw-bold";
                }
            }

            // Refresh preview
            ddlProducts_SelectedIndexChanged(null, null);
        }
    }
}
