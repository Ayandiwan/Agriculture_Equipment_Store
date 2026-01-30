
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Org.BouncyCastle.Asn1.X509;

namespace Agriculture_Equipment_Store
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    LoadPurchaseHistory(userId);
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }



        }
        private void LoadPurchaseHistory(int userId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
            var orders = new List<Order>();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string query = @"
                    SELECT 
                        o.OrderID, o.OrderDate, o.Status,
                        p.Name, p.ImagePath,
                        od.Quantity, od.Price
                    FROM Orders o
                    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
                    INNER JOIN Products p ON od.ProductID = p.ProductID
                    WHERE o.UserID = @UserID
                    ORDER BY o.OrderDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        Dictionary<int, Order> orderDict = new Dictionary<int, Order>();

                        while (reader.Read())
                        {
                            int orderId = Convert.ToInt32(reader["OrderID"]);

                            if (!orderDict.ContainsKey(orderId))
                            {
                                orderDict[orderId] = new Order
                                {
                                    OrderID = orderId,
                                    OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                                    Status = reader["Status"].ToString(),
                                    Items = new List<OrderItem>()
                                };
                            }

                            OrderItem item = new OrderItem
                            {
                                ProductName = reader["Name"].ToString(),
                                ImagePath = reader["ImagePath"].ToString(),
                                Quantity = Convert.ToInt32(reader["Quantity"]),
                                Price = Convert.ToDecimal(reader["Price"]),
                                TotalPrice = Convert.ToInt32(reader["Quantity"]) * Convert.ToDecimal(reader["Price"])
                            };

                            orderDict[orderId].Items.Add(item);
                        }

                        orders.AddRange(orderDict.Values);
                    }
                }
            }

            rptOrders.DataSource = orders;
            rptOrders.DataBind();
        }


        public class Order
        {
            public int OrderID { get; set; }
            public DateTime OrderDate { get; set; }
            public string Status { get; set; }
            public List<OrderItem> Items { get; set; }
        }

        public class OrderItem
        {
            public string ProductName { get; set; }
            public string ImagePath { get; set; }
            public int Quantity { get; set; }
            public decimal Price { get; set; }
            public decimal TotalPrice { get; set; }
        }

        protected void rptOrders_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == System.Web.UI.WebControls.ListItemType.Item || e.Item.ItemType == System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                Order order = (Order)e.Item.DataItem;
                Repeater rptItems = (Repeater)e.Item.FindControl("rptOrderItems");
                rptItems.DataSource = order.Items;
                rptItems.DataBind();
            }
        }


    }
}