using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Agriculture_Equipment_Store
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        string conString = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardCounts();
            }
        }

        void LoadDashboardCounts()
        {
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();

                // 1️⃣ Count Products
                SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Products", con);
                int productCount = (int)cmd1.ExecuteScalar();
                lblProducts.Text = productCount.ToString();

                // 2️⃣ Count Registered Customers (All except Admin)
                SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM Userlogin WHERE Role!='Admin'", con);
                int customerCount = (int)cmd2.ExecuteScalar();
                lblCustomers.Text = customerCount.ToString();

                // 3️⃣ Count Pending Orders
                SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM Orders WHERE Status='Pending'", con);
                int pendingOrders = (int)cmd3.ExecuteScalar();
                lblOrders.Text = pendingOrders.ToString();
            }
        }
    }
}
