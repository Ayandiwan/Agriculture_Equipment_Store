using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace Agriculture_Equipment_Store
{
    public partial class Pro_Buy_otp : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        int orderId;

        // SMTP Configuration
        string smtpEmail = "agricultureequipement@gmail.com";
        string smtpPassword = "payg hzhl vgin zjta";
        string smtpHost = "smtp.gmail.com";
        int smtpPort = 587;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["orderId"] != null)
                {
                    orderId = Convert.ToInt32(Request.QueryString["orderId"]);
                    Session["OrderID"] = orderId;

                    string userEmail = GetUserEmail(orderId);
                    if (string.IsNullOrEmpty(userEmail))
                    {
                        Response.Write("<script>alert('User email not found.'); window.location='Cart.aspx';</script>");
                        return;
                    }

                    Session["UserEmail"] = userEmail;
                    SendOTP(userEmail);
                }
                else
                {
                    Response.Redirect("Cart.aspx");
                }
            }
        }

        private string GetUserEmail(int orderId)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
                    SELECT u.Email
                    FROM Orders o
                    INNER JOIN Userlogin u ON o.UserID = u.Userid
                    WHERE o.OrderID=@oid", con);
                cmd.Parameters.AddWithValue("@oid", orderId);
                object email = cmd.ExecuteScalar();
                return email == DBNull.Value || email == null ? "" : email.ToString();
            }
        }

        private void SendOTP(string email)
        {
            Random rnd = new Random();
            int otp = rnd.Next(100000, 999999);
            Session["OTP"] = otp;

            try
            {
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress(smtpEmail, "Agriculture Equipment Store");
                msg.To.Add(email);
                msg.Subject = "🔒 OTP Verification for Your Order";

                string currentDateTime = DateTime.Now.ToString("dddd, dd MMMM yyyy hh:mm tt");

                msg.Body =
$@"Dear Valued Customer,

Thank you for placing an order with Agriculture Equipment Store.

To ensure the security of your transaction, please verify your order using the OTP below:

    👉 Your One Time Password (OTP): {otp}

Date & Time of Request: {currentDateTime}

This OTP is valid for the next 10 minutes. Please do not share this OTP with anyone.

Once verified, your order will be confirmed and processed promptly.

We appreciate your trust in us.

Warm regards,
🌾 Agriculture Equipment Store";

                msg.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient(smtpHost, smtpPort);
                smtp.Credentials = new NetworkCredential(smtpEmail, smtpPassword);
                smtp.EnableSsl = true;
                smtp.Send(msg);

                lblMessage.Text = "✅ OTP sent to your email.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error sending OTP: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            if (Session["OTP"] != null && txtOTP.Text.Trim() == Session["OTP"].ToString())
            {
                orderId = Convert.ToInt32(Session["OrderID"]);

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("UPDATE Orders SET Status='Confirmed' WHERE OrderID=@oid", con);
                    cmd.Parameters.AddWithValue("@oid", orderId);
                    cmd.ExecuteNonQuery();
                }

                // ✅ Clear OTP and redirect to Bill Page
                Session.Remove("OTP");
                lblMessage.Text = "✅ OTP Verified! Generating your bill...";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                // Redirect to Bill.aspx for bill display/download
                Response.Write("<script>setTimeout(function(){ window.location='Bill.aspx?orderId=" + orderId + "'; }, 1500);</script>");
            }
            else
            {
                lblMessage.Text = "❌ Invalid OTP. Please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session.Remove("OTP");
            Session.Remove("OrderID");
            Session.Remove("UserEmail");
            Response.Write("<script>alert('Order verification cancelled.'); window.location='Cart.aspx';</script>");
        }

        protected void ResendOTP(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                SendOTP(Session["UserEmail"].ToString());
                lblMessage.Text = "🔁 OTP resent successfully.";
                lblMessage.ForeColor = System.Drawing.Color.Orange;
            }
        }
    }
}
