using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;
using System.Configuration;

namespace Agriculture_Equipment_Store
{
    public partial class otp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["Email"] == null)
            {
                lblMessage.Text = "⚠️ No registration data found. Please register first.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                btnVerify.Enabled = false;
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            if (Session["OTP"] != null && txtOTP.Text.Trim() == Session["OTP"].ToString())
            {
                lblMessage.Text = "✅ OTP Verified Successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                try
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString))
                    {
                        /*
                        string query = @"INSERT INTO Userlogin
                                        (Name, Email, Password, Role, PhoneNumber, Addrese)
                                         VALUES(@Name, @Email, @Password, @Role, @PhoneNumber, @Addrese)";
                        */
                        string query = @"INSERT INTO Userlogin
                (Name, Email, Password, Role, PhoneNumber, Addrese)
                 VALUES(@Name, @Email, @Password, @Role, @PhoneNumber, @Addrese)";


                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Name", Session["UserName"]);
                            cmd.Parameters.AddWithValue("@Email", Session["Email"]);
                            cmd.Parameters.AddWithValue("@Password", Session["Password"]);
                            //  cmd.Parameters.AddWithValue("@Role", Session["Role"]);
                            cmd.Parameters.AddWithValue("@Role", Session["Role"]);

                            cmd.Parameters.AddWithValue("@PhoneNumber", Session["PhoneNumber"]);
                            cmd.Parameters.AddWithValue("@Addrese", Session["Address"]);

                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    Session.Clear();

                    // ✅ Registration done → Alert + Redirect to login
                    string script = @"
                        <script>
                            alert('🎉 Registration Successful! You can now login.');
                            window.location='login.aspx';
                        </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "SuccessRedirect", script);
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "❌ Database Error: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "❌ Invalid OTP. Please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Session.Clear();

            string script = @"
                <script>
                    alert('❌ You did not enter OTP, registration is cancelled.');
                    window.location='login.aspx';
                </script>";

            ClientScript.RegisterStartupScript(this.GetType(), "CancelAlert", script);
        }

        protected void lnkResendOTP_Click(object sender, EventArgs e)
        {
            if (Session["Email"] == null)
            {
                lblMessage.Text = "⚠️ Email not found in session. Please register again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Generate new 4-digit OTP
            Random rnd = new Random();
            int otp = rnd.Next(1000, 10000);

            // Save OTP to session
            Session["OTP"] = otp.ToString();

            try
            {
                string toEmail = Session["Email"].ToString();
                string subject = "Your OTP Code from Agriculture Equipment Store";
                string body = $"<h2>OTP Verification</h2><p>Your OTP code is: <strong>{otp}</strong></p><br/><p>Regards,<br/>Agriculture Equipment Store Team</p>";

                MailMessage message = new MailMessage();
                message.To.Add(toEmail);
                message.From = new MailAddress("agricultureequipement@gmail.com");
                message.Subject = subject;
                message.Body = body;
                message.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential("agricultureequipement@gmail.com", "payg hzhl vgin zjta");
                smtp.EnableSsl = true;
                smtp.Send(message);

                lblMessage.Text = "✅ New OTP has been sent to your email.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Failed to resend OTP: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}
