using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Agriculture_Equipment_Store
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnsubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string curpas = txtCurrentPass.Text.Trim();
            string newpas = txtNewPass.Text.Trim();
            string reppas = txtConfirmPass.Text.Trim(); // ✅ Corrected ID

            // ✅ Validate new passwords match
            if (newpas != reppas)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('New Password and Confirm Password do not match!');", true);
                return;
            }

            try
            {
                string conStr = System.Configuration.ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();

                    // ✅ Check if email and current password exist
                    string checkQuery = "SELECT COUNT(*) FROM [Userlogin] WHERE Email=@Email AND Password=@Password";
                    SqlCommand cmd = new SqlCommand(checkQuery, con);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", curpas);

                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    if (count > 0)
                    {
                        // ✅ Update password
                        string updateQuery = "UPDATE [Userlogin] SET Password=@NewPassword WHERE Email=@Email";
                        SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                        updateCmd.Parameters.AddWithValue("@NewPassword", newpas);
                        updateCmd.Parameters.AddWithValue("@Email", email);

                        int rows = updateCmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                "alert('Password updated successfully! Redirecting to Login Page...'); window.location='login.aspx';", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                "alert('Error: Unable to update password. Please try again later.');", true);
                        }
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('Invalid Email or Current Password!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Error: " + ex.Message.Replace("'", " ") + "');", true);
            }

            // ✅ Clear fields
            txtEmail.Text = "";
            txtCurrentPass.Text = "";
            txtNewPass.Text = "";
            txtConfirmPass.Text = "";
        }
    }
}
