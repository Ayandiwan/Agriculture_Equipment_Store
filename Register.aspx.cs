using System;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
using System.Net;

namespace Agriculture_Equipment_Store
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Store temporarily in session
            Session["UserName"] = txtuname.Text.Trim();
            Session["Password"] = txtupass.Text.Trim();
            Session["Email"] = txtemail.Text.Trim();
            Session["Role"] = "Customer";  // ✅ Default value
            Session["PhoneNumber"] = txtphono.Text.Trim();
            Session["Address"] = txtaddrese.Text.Trim();

            // Generate OTP
            string otp = new Random().Next(1000, 9999).ToString();
            Session["OTP"] = otp;

            // Send OTP
            if (SendOTPEmail(txtemail.Text.Trim(), otp))
            {
                Response.Redirect("otp.aspx");
            }
            else
            {
                Response.Write("<script>alert('❌ Failed to send OTP. Try again.');</script>");
            }
        }

        private bool SendOTPEmail(string toEmail, string otp)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("agricultureequipement@gmail.com");
                mail.To.Add(toEmail);
                mail.Subject = "Your OTP Code - Agriculture Store";
                mail.Body = $"Dear User,\n\nYour OTP is: {otp}\n\nThank you!";

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential("agricultureequipement@gmail.com", "payg hzhl vgin zjta");
                smtp.EnableSsl = true;
                smtp.Send(mail);

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
