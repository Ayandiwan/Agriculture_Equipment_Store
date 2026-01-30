<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin_check.Master" AutoEventWireup="true" CodeBehind="Admin_Dashboard.aspx.cs" Inherits="Agriculture_Equipment_Store.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid mt-4">
        <h2 class="mb-4 text-success">🌾 Admin Dashboard - Agriculture Equipment Store</h2>

        <!-- Dashboard Cards -->
        <div class="row justify-content-center g-4">
            <div class="col-md-4 col-lg-3 custom-card-width">
                <div class="card shadow-sm border-success h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-basket-fill display-4 text-success"></i>
                        <h5 class="card-title mt-2">Products</h5>
                        <p class="card-text">Manage all agricultural equipment products.</p>
                        <a href="AddProduct.aspx" class="btn btn-success btn-sm">View Products</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 col-lg-3 custom-card-width">
                <div class="card shadow-sm border-warning h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-people-fill display-4 text-warning"></i>
                        <h5 class="card-title mt-2">Customers</h5>
                        <p class="card-text">View and manage customer information.</p>
                        <a href="ManageUsers.aspx" class="btn btn-warning btn-sm">View Customers</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 col-lg-3 custom-card-width">
                <div class="card shadow-sm border-primary h-100">
                    <div class="card-body text-center">
                        <i class="bi bi-cart-fill display-4 text-primary"></i>
                        <h5 class="card-title mt-2">Orders</h5>
                        <p class="card-text">Track and manage customer orders.</p>
                        <a href="AdminOrders.aspx" class="btn btn-primary btn-sm">View Orders</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="row g-4 mt-4">
            <div class="col-md-4">
                <div class="alert alert-success text-center shadow-sm">
                    <h4><asp:Label ID="lblProducts" runat="server" Text="0"></asp:Label></h4>
                    <p>Products Available</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="alert alert-warning text-center shadow-sm">
                    <h4><asp:Label ID="lblCustomers" runat="server" Text="0"></asp:Label></h4>
                    <p>Registered Customers</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="alert alert-primary text-center shadow-sm">
                    <h4><asp:Label ID="lblOrders" runat="server" Text="0"></asp:Label></h4>
                    <p>Pending Orders</p>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        .custom-card-width {
            flex: 0 0 30%;
            max-width: 30%;
        }
        @media (max-width: 768px) {
            .custom-card-width {
                flex: 0 0 100%;
                max-width: 100%;
            }
        }
    </style>

</asp:Content>
