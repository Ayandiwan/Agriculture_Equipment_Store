<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Agriculture_Equipment_Store.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        h2 {
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 25px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 1.8rem;
        }

            h2::after {
                content: '';
                display: block;
                width: 70px;
                height: 3px;
                background: #28a745;
                margin: 10px auto 0;
                border-radius: 2px;
            }

        .search-box {
            display: flex;
            align-items: center;
            background: #fff;
            border-radius: 40px;
            padding: 4px 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .search-icon {
            color: #888;
            margin-right: 8px;
            font-size: 1rem;
        }

        .search-input {
            border: none !important;
            flex: 1;
            font-size: 0.95rem;
            padding: 5px;
            outline: none;
        }

        .btn-search {
            background: linear-gradient(135deg,#3498db,#217dbb);
            color: white;
            border: none;
            border-radius: 25px;
            padding: 5px 14px;
            font-weight: 600;
            font-size: 0.9rem;
        }

            .btn-search:hover {
                background: linear-gradient(135deg,#217dbb,#1b6ca8);
            }

        .btn-clear {
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            font-size: 0.9rem;
            font-weight: bold;
        }

            .btn-clear:hover {
                background: #b52a36;
            }

        .card {
            border: none;
            border-radius: 14px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            }



            .card-img-wrapper {
    width: 100%;
    height: 200px;               
    background: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 10px;               
    overflow: hidden;            
}

.card-img-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: contain;         
    object-position: center;     
}


        .card:hover .card-img-wrapper img {
            transform: scale(1.03);
        }

        .card-body {
            padding: 14px;
            text-align: center;
        }

        .card-title {
            font-size: 1.05rem;
            font-weight: 700;
            color: #34495e;
            margin-bottom: 6px;
        }

        .card-text {
            font-size: 0.9rem;
            color: #6c757d;
            min-height: 40px;
            margin-bottom: 6px;
        }

        .price-badge {
            display: inline-block;
            background: linear-gradient(135deg,#28a745,#218838);
            color: white;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 8px;
            font-size: 0.9rem;
            margin-bottom: 6px;
        }

        .stock-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: #555;
        }

        .form-control {
            height: 32px;
            text-align: center;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 0.85rem;
        }

            .form-control:focus {
                border-color: #28a745;
                box-shadow: 0 0 5px rgba(40,167,69,0.3);
            }

        .btn-primary {
            background: linear-gradient(135deg,#3498db,#217dbb);
            border: none;
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }

            .btn-primary:hover {
                background: linear-gradient(135deg,#217dbb,#1b6ca8);
            }

        .btn-outline-secondary {
            font-size: 0.85rem;
            padding: 6px 10px;
            border-radius: 8px;
        }
    </style>

    <h2 class="text-center">🌾 Available Products 🌾</h2>

    <!-- Search Bar -->
    <div class="row mb-4">
        <div class="col-md-8 offset-md-2">
            <div class="search-box">
                <span class="search-icon"><i class="fas fa-search"></i></span>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control search-input" placeholder="Search for products..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-search" OnClick="btnSearch_Click" />
                <asp:Button ID="btnClear" runat="server" Text="✖" CssClass="btn btn-clear" OnClick="btnClear_Click" />
            </div>
        </div>
    </div>

    <!-- Products Grid -->
    <div class="row">
        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                    <div class="card h-100">
                        <div class="card-img-wrapper">
                            <img src='<%# Eval("ImagePath") %>' alt="Product Image" />
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><%# Eval("Name") %></h5>
                            <p><b>Category:</b> <%# Eval("Category") %></p>
                            <div class="price-badge">₹ <%# Eval("Price") %></div>
                            <p class="stock-label">Stock: <%# Eval("Stock") %></p>

                            <div class="d-flex justify-content-center align-items-center mt-2">
                                <asp:TextBox ID="txtQty" runat="server" Text="1" Width="45px" CssClass="form-control me-2"></asp:TextBox>
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add"
                                    CommandArgument='<%# Eval("ProductID") %>' OnClick="btnAddToCart_Click"
                                    CssClass="btn btn-primary" />
                                <asp:HyperLink ID="hlDetails" runat="server" CssClass="btn btn-outline-secondary ms-1"
                                    NavigateUrl='<%# "ProductDetails.aspx?pid=" + Eval("ProductID") %>' Text="Details">
                                </asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div class="row">
        <div class="col-12 text-center mt-3">
            <asp:Label ID="lblNoProducts" runat="server" CssClass="text-danger fw-bold" Visible="false"
                Text="No products found matching your search."></asp:Label>
        </div>
    </div>

</asp:Content>
