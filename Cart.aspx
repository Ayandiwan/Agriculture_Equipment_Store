<%@ Page Title="Cart" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Agriculture_Equipment_Store.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            background: #f0f2f5;
        }

        .container-fluid {
            min-height: 100vh;
            background: #fff;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            padding: 40px 60px;
        }

        h2 {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
        }

        /* GridView Styling */
        .table {
            width: 100%;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-collapse: collapse;
        }

        .table th {
            background: #28a745;
            color: #fff;
            text-align: center;
            font-weight: 600;
            padding: 12px;
        }

        .table td {
            vertical-align: middle;
            text-align: center;
            background: #fff;
            padding: 10px;
        }

        .table tr:hover {
            background: #f8f9fa;
        }

        /* Quantity Controls */
        .qty-control {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
        }

        .qty-btn {
            background: #3498db;
            color: white;
            border: none;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .qty-btn:hover {
            transform: scale(1.1);
            background: #217dbb;
        }

        .form-control.qty-input {
            width: 60px;
            text-align: center;
        }

        /* Total Section */
        .cart-summary {
            margin-top: 20px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            text-align: right;
        }

        .cart-summary h4 {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, #3498db, #217dbb);
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            color: #fff;
        }

        .btn-primary:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 6px 15px rgba(33,123,187,0.4);
        }

        .btn-success {
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
        }

        /* Action Buttons */
        .action-btn {
            border-radius: 8px;
            padding: 6px 12px;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
            font-size: 0.85rem;
        }

        .edit-btn {
            background: #ffc107;
            color: #000;
            border: none;
        }

        .edit-btn:hover {
            background: #e0a800;
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(224, 168, 0, 0.4);
        }

        .delete-btn {
            background: #dc3545;
            color: white;
            border: none;
        }

        .delete-btn:hover {
            background: #c82333;
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.4);
        }

        /* Responsive Fix */
        @media (max-width: 768px) {
            .container-fluid {
                padding: 20px;
            }

            .table th, .table td {
                font-size: 14px;
                padding: 8px;
            }
        }
    </style>

    <div class="container-fluid">
        <h2>🛒 Your Shopping Cart</h2>

        <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
            OnRowEditing="gvCart_RowEditing" OnRowUpdating="gvCart_RowUpdating"
            OnRowCancelingEdit="gvCart_RowCancelingEdit" OnRowDeleting="gvCart_RowDeleting"
            DataKeyNames="CartID">
            <Columns>
                <%-- Image --%>
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <img src='<%# Eval("ImagePath") %>' width="80" height="60" style="object-fit: contain;" />
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- Product --%>
                <asp:BoundField DataField="ProductName" HeaderText="Product" ReadOnly="True" />

                <%-- Category --%>
                <asp:BoundField DataField="Category" HeaderText="Category" ReadOnly="True" />

                <%-- Price --%>
                <asp:BoundField DataField="Price" HeaderText="Price (₹)" ReadOnly="True"
                    DataFormatString="{0:N2}" ItemStyle-CssClass="price-cell" />

                <%-- Quantity --%>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <div class="qty-control">
                            <button type="button" class="qty-btn" onclick="changeQty(this, -1)">-</button>
                            <asp:TextBox ID="txtQtyDisplay" runat="server" Text='<%# Eval("Quantity") %>' CssClass="form-control qty-input" />
                            <button type="button" class="qty-btn" onclick="changeQty(this, 1)">+</button>
                        </div>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Bind("Quantity") %>' CssClass="form-control" />
                    </EditItemTemplate>
                </asp:TemplateField>

                <%-- Total --%>
                <asp:TemplateField HeaderText="Total (₹)">
                    <ItemTemplate>
                        <span class="total-cell"><%# GetTotal(Eval("Price"), Eval("Quantity")) %></span>
                    </ItemTemplate>
                </asp:TemplateField>

                <%-- Actions --%>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="✏ Edit"
                            CommandName="Edit"
                            CssClass="action-btn edit-btn" />
                        <asp:Button ID="btnDelete" runat="server" Text="🗑 Delete"
                            CommandName="Delete" CommandArgument='<%# Eval("CartID") %>'
                            CssClass="action-btn delete-btn"
                            OnClientClick="return confirm('Are you sure you want to remove this item?');" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button ID="btnUpdate" runat="server" Text="💾 Save"
                            CommandName="Update" CssClass="action-btn btn-primary" />
                        <asp:Button ID="btnCancel" runat="server" Text="✖ Cancel"
                            CommandName="Cancel" CssClass="action-btn delete-btn" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div class="cart-summary text-end">
            <h4>Total Amount: ₹
                <asp:Label ID="lblTotal" runat="server" Text="0.00"></asp:Label></h4>
            <a href="Products.aspx" class="btn btn-success mt-2">← Continue Shopping</a>
            <asp:Button ID="btnCheckout" runat="server" Text="Checkout" CssClass="btn btn-primary mt-2" OnClick="btnCheckout_Click" />
        </div>
    </div>

    <script>
        // changeQty updates quantity and total instantly
        function changeQty(btn, change) {
            var wrapper = btn.parentNode;
            var input = wrapper.querySelector('.qty-input');
            if (!input) return;
            var current = parseInt(input.value) || 1;
            var newVal = current + change;
            if (newVal < 1) newVal = 1;
            input.value = newVal;
            updateTotal();
        }

        // updateTotal recalculates totals client-side
        function updateTotal() {
            var gv = document.getElementById('<%= gvCart.ClientID %>');
            if (!gv) return;
            var rows = gv.querySelectorAll('tbody tr');
            var grandTotal = 0;
            rows.forEach(function (row) {
                var priceCell = row.querySelector('.price-cell');
                var qtyInput = row.querySelector('.qty-input');
                var totalCell = row.querySelector('.total-cell');
                if (!priceCell || !qtyInput || !totalCell) return;

                var priceText = priceCell.innerText || priceCell.textContent || '';
                var price = parseFloat(priceText.replace(/[₹,]/g, '').trim()) || 0;
                var qty = parseInt(qtyInput.value) || 1;
                var total = price * qty;
                totalCell.innerText = total.toFixed(2);
                grandTotal += total;
            });

            var lbl = document.getElementById('<%= lblTotal.ClientID %>');
            if (lbl) lbl.innerText = grandTotal.toFixed(2);
        }

        window.addEventListener('load', function () {
            updateTotal();
        });
    </script>
</asp:Content>
