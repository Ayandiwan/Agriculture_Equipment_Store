<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bill.aspx.cs" Inherits="Agriculture_Equipment_Store.Bill" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Bill</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .bill-container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
        }
        h2 {
            text-align: center;
            font-weight: bold;
            color: #007b5e;
        }
        .details {
            margin-top: 20px;
            line-height: 1.8;
        }
        .details label {
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th {
            background-color: #007b5e;
            color: #fff;
            text-align: center;
            padding: 10px;
        }
        td {
            padding: 10px;
            text-align: center;
        }
        .total {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 15px;
        }
        .print-btn {
            margin-top: 25px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="bill-container">
            <h2>🧾 Agriculture Equipment Store - Customer Bill</h2>
            <hr />

            <div class="details">
                <label>Bill ID:</label> <asp:Label ID="lblBillId" runat="server" /><br />
                <label>Customer Name:</label> <asp:Label ID="lblCustomerName" runat="server" /><br />
                <label>Address:</label> <asp:Label ID="lblAddress" runat="server" /><br />
                <label>Date:</label> <asp:Label ID="lblDate" runat="server" /><br />
            </div>

            <hr />

            <asp:Literal ID="litBillItems" runat="server"></asp:Literal>

            <div class="total">
                <asp:Label ID="lblTotal" runat="server" Text="Total: ₹0"></asp:Label>
            </div>

            <div class="text-center">
                <asp:Button ID="btnPrint" runat="server" Text="Download PDF Bill"
                    CssClass="btn btn-success print-btn" OnClick="btnPrint_Click" />
                <asp:Button ID="btnBack" runat="server" Text="Back to Products"
                    CssClass="btn btn-secondary print-btn" PostBackUrl="~/Products.aspx" />
            </div>
        </div>
    </form>
</body>
</html>
