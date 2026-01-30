using System;
using System.Data.SqlClient;
using System.Configuration;

namespace Agriculture_Equipment_Store
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear old session data when visiting login page
            if (!IsPostBack)
            {
                Session.Clear();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(@"
                        SELECT Userid 
                        FROM Userlogin 
                        WHERE Email = @Email AND Password = @Password AND Role = @Role", con);

                    cmd.Parameters.AddWithValue("@Email", txtemail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@Role", ddltype.SelectedItem.Value);


                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        // ✅ Valid user found
                        int userId = Convert.ToInt32(result);

                        // ✅ Store user data in Session

                        Session["UserId"] = userId;
                        Session["user"] = txtemail.Text.Trim();     // 🔥 Add this line

                        Session["UserEmail"] = txtemail.Text.Trim();
                        Session["Role"] = ddltype.SelectedItem.Value;

                        // ✅ Redirect based on role
                        if (Session["Role"].ToString() == "Admin")
                        {
                            Session["AdminUser"] = ddltype.SelectedItem.Value;
                            Response.Redirect("Admin_Dashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("Home.aspx"); 
                        }
                    }

                    else
                    {
                        Response.Write("<script>alert('Invalid Email, Password, or Role!');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }
    }
}
