using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Agriculture_Equipment_Store
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load users normally
                LoadUsers();

                // For testing: set label text to "check"
                lblMessage.Text = "check";
            }
        }

        private void LoadUsers(string search = "")
        {
            string query = "SELECT * FROM Userlogin";
            if (!string.IsNullOrEmpty(search))
                query += " WHERE Name LIKE @search OR Email LIKE @search";

            SqlCommand cmd = new SqlCommand(query, con);
            if (!string.IsNullOrEmpty(search))
                cmd.Parameters.AddWithValue("@search", "%" + search + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadUsers(txtSearch.Text.Trim());
        }

        protected void gvUsers_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("DELETE FROM Userlogin WHERE Userid=@id", con);
            cmd.Parameters.AddWithValue("@id", userId);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            LoadUsers();
            lblMessage.Text = "🗑 User deleted successfully!";
        }
    }
}
