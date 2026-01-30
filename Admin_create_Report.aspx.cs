using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

namespace Agriculture_Equipment_Store
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        // ✅ FIX: Define connection string
        string connectionString = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadReport("Weekly");
            }
        }

        protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadReport(ddlReportType.SelectedValue);
        }

        private DataTable GetReportData(string reportType)
        {
            DataTable dt = new DataTable();
            string query = "";

            if (reportType == "Weekly")
            {
                query = @"
                    SELECT CONVERT(VARCHAR(10), OrderDate, 120) AS Label,
                           SUM(TotalAmount) AS TotalSales
                    FROM Orders
                    WHERE OrderDate >= DATEADD(DAY, -7, GETDATE())
                    GROUP BY CONVERT(VARCHAR(10), OrderDate, 120)
                    ORDER BY Label ASC";
            }
            else if (reportType == "Monthly")
            {
                query = @"
                    SELECT FORMAT(OrderDate, 'MMM yyyy') AS Label,
                           SUM(TotalAmount) AS TotalSales
                    FROM Orders
                    GROUP BY FORMAT(OrderDate, 'MMM yyyy')
                    ORDER BY MIN(OrderDate)";
            }
            else if (reportType == "Yearly")
            {
                query = @"
                    SELECT YEAR(OrderDate) AS Label,
                           SUM(TotalAmount) AS TotalSales
                    FROM Orders
                    GROUP BY YEAR(OrderDate)
                    ORDER BY YEAR(OrderDate)";
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.Fill(dt);
            }
            return dt;
        }

        private void LoadReport(string reportType)
        {
            DataTable dt = GetReportData(reportType);

            gvReport.DataSource = dt;
            gvReport.DataBind();

            var labels = new System.Collections.Generic.List<string>();
            var sales = new System.Collections.Generic.List<decimal>();

            foreach (DataRow row in dt.Rows)
            {
                labels.Add(row["Label"].ToString());
                sales.Add(Convert.ToDecimal(row["TotalSales"]));
            }

            var js = new JavaScriptSerializer();

            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "chart",
                $"renderChart({js.Serialize(labels)}, {js.Serialize(sales)});",
                true);
        }

        protected void btnDownloadPDF_Click(object sender, EventArgs e)
        {
            string reportType = ddlReportType.SelectedValue;
            DataTable dt = GetReportData(reportType);

            Document pdfDoc = new Document(PageSize.A4, 25, 25, 30, 30);
            MemoryStream stream = new MemoryStream();

            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, stream);
            writer.PageEvent = new FooterEvent();

            pdfDoc.Open();

            // ============ HEADER ============
            PdfPTable header = new PdfPTable(2);
            header.WidthPercentage = 100;
            header.SetWidths(new float[] { 20f, 80f });

            string logoPath = Server.MapPath("~/images/logo.png");

            if (File.Exists(logoPath))
            {
                iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(logoPath);
                img.ScaleAbsolute(60, 60);

                PdfPCell logo = new PdfPCell(img);
                logo.Border = Rectangle.NO_BORDER;
                logo.HorizontalAlignment = Element.ALIGN_LEFT;

                header.AddCell(logo);
            }
            else
            {
                header.AddCell(new PdfPCell() { Border = Rectangle.NO_BORDER });
            }

            PdfPCell company = new PdfPCell(new Phrase(
                "AGRICULTURE EQUIPMENT STORE\nPhone: +91 9737792966\nEmail:agricultureequipement@gmail.com",
                FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12)
            ));
            company.Border = Rectangle.NO_BORDER;
            company.PaddingTop = 10;
            header.AddCell(company);

            pdfDoc.Add(header);
            pdfDoc.Add(new Paragraph("\n"));

            // TITLE
            Paragraph title = new Paragraph("SALES REPORT - " + reportType.ToUpper(),
                FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 20, BaseColor.GREEN));
            title.Alignment = Element.ALIGN_CENTER;
            title.SpacingAfter = 20;
            pdfDoc.Add(title);

            // DATE
            Paragraph dateInfo = new Paragraph(
                "Generated On: " + DateTime.Now.ToString("dd MMM yyyy hh:mm tt"),
                FontFactory.GetFont(FontFactory.HELVETICA, 11, BaseColor.DARK_GRAY));
            dateInfo.Alignment = Element.ALIGN_RIGHT;
            dateInfo.SpacingAfter = 10;
            pdfDoc.Add(dateInfo);

            // ============ TABLE ============
            PdfPTable table = new PdfPTable(dt.Columns.Count);
            table.WidthPercentage = 100;

            foreach (DataColumn col in dt.Columns)
            {
                PdfPCell headerCell = new PdfPCell(new Phrase(col.ColumnName,
                    FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE)))
                {
                    BackgroundColor = new BaseColor(46, 125, 50),
                    Padding = 6,
                    HorizontalAlignment = Element.ALIGN_CENTER
                };
                table.AddCell(headerCell);
            }

            bool alternate = false;
            foreach (DataRow row in dt.Rows)
            {
                foreach (var item in row.ItemArray)
                {
                    PdfPCell cell = new PdfPCell(new Phrase(item.ToString(),
                        FontFactory.GetFont(FontFactory.HELVETICA, 11)))
                    {
                        BackgroundColor = alternate ? new BaseColor(240, 255, 240) : BaseColor.WHITE,
                        Padding = 5,
                        HorizontalAlignment = Element.ALIGN_CENTER
                    };
                    table.AddCell(cell);
                }
                alternate = !alternate;
            }

            pdfDoc.Add(table);

            // TOTAL SALES
            decimal total = 0;
            foreach (DataRow row in dt.Rows)
                total += Convert.ToDecimal(row["TotalSales"]);

            Paragraph totalText = new Paragraph("\nTotal Sales: ₹" + total.ToString("N2"),
                FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 15, BaseColor.RED));
            totalText.Alignment = Element.ALIGN_RIGHT;
            pdfDoc.Add(totalText);

            pdfDoc.Add(new Paragraph("\nPrepared By: Admin"));
            pdfDoc.Add(new Paragraph("Verified By: Manager"));
            pdfDoc.Add(new Paragraph("\n\n____________________________\nManager Signature"));

            pdfDoc.Close();

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", $"attachment;filename=SalesReport_{reportType}.pdf");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
    }

    // FOOTER
    public class FooterEvent : PdfPageEventHelper
    {
        public override void OnEndPage(PdfWriter writer, Document document)
        {
            PdfPTable footer = new PdfPTable(1);
            footer.TotalWidth = 500;

            PdfPCell cell = new PdfPCell(new Phrase(
                "Page " + writer.PageNumber,
                FontFactory.GetFont(FontFactory.HELVETICA, 10, BaseColor.GRAY)))
            {
                Border = Rectangle.NO_BORDER,
                HorizontalAlignment = Element.ALIGN_CENTER,
                PaddingTop = 5
            };

            footer.AddCell(cell);
            footer.WriteSelectedRows(0, -1, (document.PageSize.Width - 500) / 2, 30, writer.DirectContent);
        }
    }
}
