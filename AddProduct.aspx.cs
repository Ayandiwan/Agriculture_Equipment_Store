using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Agriculture_Equipment_Store
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                // Save image to "Images" folder
                string imagePath = "";
                if (fileUploadImage.HasFile)
                {
                    string fileName = System.IO.Path.GetFileName(fileUploadImage.FileName);
                    imagePath = "Image/" + fileName;
                    fileUploadImage.SaveAs(Server.MapPath("~/" + imagePath));
                }

                // Insert into database
                string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "INSERT INTO Products (Name, Description, Price, Stock, ImagePath, Category) " +
                                   "VALUES (@Name, @Description, @Price, @Stock, @ImagePath, @Category)";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text);
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
                    cmd.Parameters.AddWithValue("@Stock", Convert.ToInt32(txtStock.Text));
                    cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                    cmd.Parameters.AddWithValue("@Category", txtCategory.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMessage.CssClass = "text-success";
                lblMessage.Text = "✅ Product added successfully!";

                // Clear fields
                txtName.Text = "";
                txtDescription.Text = "";
                txtPrice.Text = "";
                txtStock.Text = "";
                txtCategory.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "text-danger";
                lblMessage.Text = "❌ Error: " + ex.Message;
            }
        }

        protected void btnUpd_Click(object sender, EventArgs e)
        {
            // Your update logic here
            //lblMessage.Text = "Update functionality is not implemented yet.";
            Response.Redirect("Admin_UpdateProduct.aspx");
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin_delete_product.aspx");
        }
    }
}
