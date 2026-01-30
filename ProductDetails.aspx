<%@ Page Title="Product Details" 
    Language="C#" 
    AutoEventWireup="true"
    CodeBehind="ProductDetails.aspx.cs" 
    Inherits="Agriculture_Equipment_Store.ProductDetails"
    MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .product-container { margin-top: 50px; }
        .product-image { max-width: 100%; border-radius: 10px; }

        .price-badge {
            display:inline-block;
            background:#28a745;
            color:white;
            font-weight:600;
            padding:6px 14px;
            border-radius:12px;
            font-size:1.2rem;
            margin-bottom:10px;
        }

        .btn-primary { 
            background:#3498db;
            border:none; 
            border-radius:10px;
            padding:8px 16px; 
            font-size:1rem;
            font-weight:600;
        }
        .btn-primary:hover { background:#217dbb; }

        .btn-secondary {
            background:#6c757d;
            border:none; 
            border-radius:10px;
            padding:8px 14px;
            font-size:1rem;
            font-weight:600;
            color:white;
        }
        .btn-secondary:hover { background:#5a6268; }

        .form-control {
            width:70px;
            text-align:center;
            border-radius:8px;
            height:36px;
        }

        .error { color:red; font-weight:bold; margin-top:10px; font-size:17px; }
    </style>

    <div class="container product-container">

        <asp:Panel ID="pnlProduct" runat="server" Visible="false">
            <div class="row">

                <div class="col-md-6">
                    <asp:Image ID="imgProduct" runat="server" CssClass="product-image" />
                </div>

                <div class="col-md-6">
                    <h2 id="lblName" runat="server"></h2>
                    <p id="lblDescription" runat="server"></p>

                    <p><b>Category:</b> <span id="lblCategory" runat="server"></span></p>

                    <p class="price-badge">
                        ₹ <span id="lblPrice" runat="server"></span>
                    </p>

                    <p><b>Stock:</b> <span id="lblStock" runat="server"></span></p>

                    <!-- Quantity + - Buttons -->
                    <div class="d-flex align-items-center mt-3">

                        <asp:Button ID="btnDecrease" runat="server"
                            Text="-" CssClass="btn btn-secondary me-2"
                            OnClick="btnDecrease_Click" />

                        <asp:TextBox ID="txtQtyDetails" runat="server" Text="1"
                            CssClass="form-control me-2"></asp:TextBox>

                        <asp:Button ID="btnIncrease" runat="server"
                            Text="+" CssClass="btn btn-secondary me-2"
                            OnClick="btnIncrease_Click" />

                        <asp:Button ID="btnAddToCartDetails"
                            runat="server"
                            CssClass="btn btn-primary"
                            Text="Add to Cart"
                            OnClick="btnAddToCartDetails_Click" />

                    </div>

                    <!-- Back Button -->
                    <div class="mt-4">
                        <a href="Products.aspx" class="btn btn-secondary">← Back to Products</a>
                    </div>

                </div>

            </div>
        </asp:Panel>

        <asp:Label ID="lblError" runat="server" CssClass="error" Visible="false"></asp:Label>

    </div>

</asp:Content>
