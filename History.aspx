<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="Agriculture_Equipment_Store.WebForm5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>My Purchase History</h2>

    <asp:Repeater ID="rptOrders" runat="server">
        <ItemTemplate>
            <div class="order-card">
                <div class="order-header">
                    <span><strong>Order ID:</strong> <%# Eval("OrderID") %></span>
                    <span><strong>Order Date:</strong> <%# Eval("OrderDate", "{0:dd-MM-yyyy}") %></span>
                    <span><strong>Status:</strong> <%# Eval("Status") %></span>
                </div>
                <div class="order-items">
                    <asp:Repeater ID="rptOrderItems" runat="server" DataSource='<%# Eval("Items") %>'>
                        <ItemTemplate>
                            <div class="product-item">
                                <img src='<%# Eval("ImagePath") %>' alt='<%# Eval("ProductName") %>' />
                                <div class="product-info">
                                    <h4><%# Eval("ProductName") %></h4>
                                    <p>Quantity: <%# Eval("Quantity") %></p>
                                    <p>Price: <%# Eval("Price", "{0:C}") %></p>
                                    <p>Total: <%# Eval("TotalPrice", "{0:C}") %></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <style>
        .order-card {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            background: #f9f9f9;
            box-shadow: 0px 2px 5px rgba(0,0,0,0.1);
        }
        .order-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-weight: bold;
        }
        .order-items {
            display: flex;
            flex-direction: column;
        }
        .product-item {
            display: flex;
            margin-bottom: 10px;
            border-top: 1px dashed #ddd;
            padding-top: 10px;
        }
        .product-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 5px;
        }
        .product-info h4 {
            margin: 0;
            font-size: 16px;
        }
        .product-info p {
            margin: 3px 0;
        }
        h2 {
            margin-bottom: 30px;
        }
    </style>

</asp:Content>




