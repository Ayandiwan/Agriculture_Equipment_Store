<%@ Page Title="Add New Admin" Language="C#" MasterPageFile="~/Admin_check.Master" AutoEventWireup="true" CodeBehind="Admin_add_new_Admin.aspx.cs" Inherits="Agriculture_Equipment_Store.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <h2 class="text-center mb-4">Add New Admin</h2>

        <div class="card shadow p-4" style="max-width:600px; margin:auto;">
            <div class="form-group mb-3">
                <label>Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter name"></asp:TextBox>
            </div>

            <div class="form-group mb-3">
                <label>Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter email"></asp:TextBox>
            </div>

            <div class="form-group mb-3">
                <label>Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password"></asp:TextBox>
            </div>

            <div class="form-group mb-3">
                <label>Confirm Password:</label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm password"></asp:TextBox>
            </div>

            <div class="form-group mb-3">
                <label>Phone Number:</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter phone number"></asp:TextBox>
            </div>

            <div class="form-group mb-3">
                <label>Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter address"></asp:TextBox>
            </div>

            <div class="text-center">
                <asp:Button ID="btnAddAdmin" runat="server" Text="Add Admin" CssClass="btn btn-success" OnClick="btnAddAdmin_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="text-center d-block mt-3 fw-bold"></asp:Label>
        </div>
    </div>

</asp:Content>
