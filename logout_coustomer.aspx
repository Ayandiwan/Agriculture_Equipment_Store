<%@ Page Title="Logout" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="logout_coustomer.aspx.cs" Inherits="Agriculture_Equipment_Store.logout_coustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Center the content horizontally and add top margin -->
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
        <div class="text-center">
            <div class="alert alert-success">
                <h4>You have been logged out successfully.</h4>
                <p>Redirecting to login page...</p>
            </div>
        </div>
    </div>
</asp:Content>
