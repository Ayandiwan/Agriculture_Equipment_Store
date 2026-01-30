using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace Agriculture_Equipment_Store
{
    public partial class Profile : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null || Session["UserId"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            userId = Convert.ToInt32(Session["UserId"]);

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Userlogin WHERE Userid = @uid", con);
                cmd.Parameters.AddWithValue("@uid", userId);

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtName.Text = dr["Name"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtPhone.Text = dr["PhoneNumber"].ToString();
                    txtAddress.Text = dr["Addrese"].ToString();

                    // Store current password hash for later
                    ViewState["CurrentPassword"] = dr["Password"].ToString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();

            // Get current password from ViewState
            string currentPassword = ViewState["CurrentPassword"].ToString();

            // If new password is entered, hash it; otherwise, use existing hash
            string newPassword = string.IsNullOrWhiteSpace(txtPassword.Text)
                ? currentPassword
                : ComputeSha256Hash(txtPassword.Text.Trim());

            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"UPDATE Userlogin SET 
                    Name = @name, Password = @pass, PhoneNumber = @phone, Addrese = @addr
                    WHERE Userid = @uid", con);

                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@pass", newPassword);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.Parameters.AddWithValue("@addr", address);
                cmd.Parameters.AddWithValue("@uid", userId);

                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    lblMessage.Text = "Profile updated successfully ✅";
                    lblMessage.Visible = true;
                }
            }
        }

        // Hashing function (SHA256)
        public static string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
