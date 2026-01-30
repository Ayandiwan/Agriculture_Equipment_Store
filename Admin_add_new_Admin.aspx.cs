using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace Agriculture_Equipment_Store
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void btnAddAdmin_Click(object sender, EventArgs e)
        {
            // Password confirmation check
            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "❌ Passwords do not match!";
                lblMessage.CssClass = "text-danger";
                return;
            }

            string conStr = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "INSERT INTO Userlogin (Name, Email, Password, Role, PhoneNumber, Addrese) " +
                               "VALUES (@Name, @Email, @Password, @Role, @PhoneNumber, @Addrese)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", txtName.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@Role", "Admin");
                cmd.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text);
                cmd.Parameters.AddWithValue("@Addrese", txtAddress.Text);

                try
                {
                    con.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        lblMessage.Text = "✅ New Admin added successfully!";
                        lblMessage.CssClass = "text-success";

                        // ✅ JavaScript alert message
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                            "alert('✅ New Admin has been successfully added!');", true);

                        // Clear fields after successful insert
                        txtName.Text = txtEmail.Text = txtPassword.Text = txtConfirmPassword.Text = txtPhone.Text = txtAddress.Text = "";
                    }
                    else
                    {
                        lblMessage.Text = "⚠️ Failed to add admin!";
                        lblMessage.CssClass = "text-danger";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "text-danger";
                }
            }
        }
    }
}
