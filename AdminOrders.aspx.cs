using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace Agriculture_Equipment_Store
{
    public partial class AdminOrders : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindOrders();
        }

        // -----------------------------
        // BIND ORDERS (WITH DATE RANGE)
        // -----------------------------
        private void BindOrders(DateTime? fromDate = null, DateTime? toDate = null)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                con.Open();

                string query = @"
                    SELECT o.OrderID, u.Name AS CustomerName, o.OrderDate, o.TotalAmount, o.Status
                    FROM Orders o
                    INNER JOIN Userlogin u ON o.UserID = u.Userid
                    WHERE 1=1";

                // Apply date range filters
                if (fromDate.HasValue)
                    query += " AND CAST(o.OrderDate AS DATE) >= @fromDate";

                if (toDate.HasValue)
                    query += " AND CAST(o.OrderDate AS DATE) <= @toDate";

                query += " ORDER BY o.OrderDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                if (fromDate.HasValue)
                    cmd.Parameters.AddWithValue("@fromDate", fromDate.Value.Date);

                if (toDate.HasValue)
                    cmd.Parameters.AddWithValue("@toDate", toDate.Value.Date);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        // -----------------------------
        // GRIDVIEW: VIEW DETAILS / COMPLETE
        // -----------------------------
        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "View")
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(@"
                        SELECT p.ImagePath, p.Name, p.Category, od.Quantity, od.Price,
                               (od.Quantity * od.Price) AS Total
                        FROM OrderDetails od
                        INNER JOIN Products p ON od.ProductID = p.ProductID
                        WHERE od.OrderID=@oid", con);

                    cmd.Parameters.AddWithValue("@oid", orderId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvOrderDetails.DataSource = dt;
                    gvOrderDetails.DataBind();
                    pnlOrderDetails.Visible = true;
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "scroll",
                    $"document.getElementById('{pnlOrderDetails.ClientID}').scrollIntoView({{behavior:'smooth'}});", true);
            }
            else if (e.CommandName == "Complete")
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand("UPDATE Orders SET Status='Completed' WHERE OrderID=@oid", con);
                    cmd.Parameters.AddWithValue("@oid", orderId);
                    cmd.ExecuteNonQuery();
                }

                BindOrders(); // refresh
            }
        }

        // -----------------------------
        // SEARCH BUTTON (DATE RANGE)
        // -----------------------------
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            DateTime fromDate, toDate;

            bool isFromValid = DateTime.TryParse(Date1.Value, out fromDate);
            bool isToValid = DateTime.TryParse(txtDate.Value, out toDate);

            if (!isFromValid || !isToValid)
            {
                Response.Write("<script>alert('Please select both From and To dates!');</script>");
                return;
            }

            if (fromDate > toDate)
            {
                Response.Write("<script>alert('From Date cannot be greater than To Date');</script>");
                return;
            }

            BindOrders(fromDate, toDate);
            pnlOrderDetails.Visible = false;
        }

        // -----------------------------
        // RESET BUTTON
        // -----------------------------
        protected void btnReset_Click(object sender, EventArgs e)
        {
            Date1.Value = string.Empty;
            txtDate.Value = string.Empty;

            BindOrders();
            pnlOrderDetails.Visible = false;
        }

        // -----------------------------
        // STATUS BADGE STYLE
        // -----------------------------
        public string GetStatusClass(string status)
        {
            switch (status)
            {
                case "Pending": return "badge bg-warning text-dark";
                case "Completed": return "badge bg-success";
                case "Cancelled": return "badge bg-danger";
                default: return "badge bg-secondary";
            }
        }
    }
}
