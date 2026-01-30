<%@ Page Title="" Language="C#" MasterPageFile="~/Admin_check.Master" AutoEventWireup="true" CodeBehind="Admin_create_Report.aspx.cs" Inherits="Agriculture_Equipment_Store.WebForm6" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <div class="container my-4">
        <h2 class="mb-4 text-primary">Admin Sales Report</h2>

        <!-- Report Selection + PDF Button -->
        <div class="row mb-4">
            <div class="col-md-4">
                <label class="form-label fw-bold">Select Report Type:</label>
                <asp:DropDownList ID="ddlReportType" runat="server" CssClass="form-select"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
                    <asp:ListItem Text="Weekly" Value="Weekly" />
                    <asp:ListItem Text="Monthly" Value="Monthly" />
                    <asp:ListItem Text="Yearly" Value="Yearly" />
                </asp:DropDownList>
            </div>

            <div class="col-md-4 mt-4">
                <asp:Button ID="btnDownloadPDF" runat="server" CssClass="btn btn-danger"
                    Text="Download PDF Report" OnClick="btnDownloadPDF_Click" />
            </div>
        </div>

        <!-- SALES TABLE -->
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-primary text-white fw-bold">Sales Data</div>
            <div class="card-body table-responsive">
                <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="true"
                    CssClass="table table-bordered table-striped" />
            </div>
        </div>

        <!-- SALES CHART -->
        <div class="card shadow-sm">
            <div class="card-header bg-success text-white fw-bold">Sales Chart</div>
            <div class="card-body">
                <canvas id="chartReport" width="100%" height="40"></canvas>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        function renderChart(labels, data) {
            const ctx = document.getElementById('chartReport').getContext('2d');

            if (window.myChart) {
                window.myChart.destroy();
            }

            window.myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: "Total Sales",
                        data: data,
                        backgroundColor: "rgba(54, 162, 235, 0.7)",
                        borderColor: "rgba(54, 162, 235, 1)",
                        borderWidth: 1
                    }]
                }
            });
        }
    </script>

</asp:Content>




