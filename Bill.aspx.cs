using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web.UI;

namespace Agriculture_Equipment_Store
{
    public partial class Bill : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["orderId"] != null)
                {
                    int orderId = Convert.ToInt32(Request.QueryString["orderId"]);
                    LoadBill(orderId);
                }
                else
                {
                    Response.Redirect("Products.aspx");
                }
            }
        }

        private void LoadBill(int orderId)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = @"
                    SELECT o.OrderID, o.OrderDate, u.Name, u.Addrese, 
                           p.Name AS ProductName, od.Quantity, od.Price, 
                           (od.Quantity * od.Price) AS TotalPrice
                    FROM Orders o
                    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
                    INNER JOIN Products p ON od.ProductID = p.ProductID
                    INNER JOIN Userlogin u ON o.UserID = u.Userid
                    WHERE o.OrderID = @oid";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@oid", orderId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    lblBillId.Text = "BILL-" + orderId;
                    lblCustomerName.Text = dt.Rows[0]["Name"].ToString();
                    lblAddress.Text = dt.Rows[0]["Addrese"].ToString();
                    lblDate.Text = Convert.ToDateTime(dt.Rows[0]["OrderDate"]).ToString("dd-MM-yyyy hh:mm tt");

                    // Build product table manually
                    string htmlTable = "<table><tr><th>Product Name</th><th>Quantity</th><th>Price (₹)</th><th>Total (₹)</th></tr>";
                    decimal total = 0;

                    foreach (DataRow row in dt.Rows)
                    {
                        htmlTable += "<tr>";
                        htmlTable += "<td>" + row["ProductName"].ToString() + "</td>";
                        htmlTable += "<td>" + row["Quantity"].ToString() + "</td>";
                        htmlTable += "<td>" + Convert.ToDecimal(row["Price"]).ToString("N2") + "</td>";
                        htmlTable += "<td>" + Convert.ToDecimal(row["TotalPrice"]).ToString("N2") + "</td>";
                        htmlTable += "</tr>";

                        total += Convert.ToDecimal(row["TotalPrice"]);
                    }

                    htmlTable += "</table>";
                    litBillItems.Text = htmlTable;

                    lblTotal.Text = "Total Amount: ₹" + total.ToString("N2");
                }
                else
                {
                    litBillItems.Text = "<p style='color:red;'>No items found for this order.</p>";
                }
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=CustomerBill.pdf");
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);

            Document pdfDoc = new Document(PageSize.A4, 25f, 25f, 25f, 25f);
            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();

            // Header
            Paragraph title = new Paragraph("Agriculture Equipment Store - Customer Bill\n\n",
                new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.GREEN));
            title.Alignment = Element.ALIGN_CENTER;
            pdfDoc.Add(title);

            pdfDoc.Add(new Paragraph("Bill ID: " + lblBillId.Text));
            pdfDoc.Add(new Paragraph("Customer Name: " + lblCustomerName.Text));
            pdfDoc.Add(new Paragraph("Address: " + lblAddress.Text));
            pdfDoc.Add(new Paragraph("Date: " + lblDate.Text));
            pdfDoc.Add(new Paragraph("\n"));

            // Table
            PdfPTable table = new PdfPTable(4);
            table.WidthPercentage = 100;
            table.AddCell("Product Name");
            table.AddCell("Quantity");
            table.AddCell("Price (₹)");
            table.AddCell("Total (₹)");

            // Fetch from literal (data already loaded)
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = @"
                    SELECT p.Name AS ProductName, od.Quantity, od.Price, (od.Quantity * od.Price) AS TotalPrice
                    FROM OrderDetails od
                    INNER JOIN Products p ON od.ProductID = p.ProductID
                    WHERE od.OrderID = @oid";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@oid", Request.QueryString["orderId"]);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    table.AddCell(rdr["ProductName"].ToString());
                    table.AddCell(rdr["Quantity"].ToString());
                    table.AddCell(Convert.ToDecimal(rdr["Price"]).ToString("N2"));
                    table.AddCell(Convert.ToDecimal(rdr["TotalPrice"]).ToString("N2"));
                }
            }

            pdfDoc.Add(table);
            pdfDoc.Add(new Paragraph("\n" + lblTotal.Text, new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD)));

            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            // Required for exporting controls to PDF
        }
    }
}
