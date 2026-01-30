<%@ Page Title="My Profile" Language="C#" AutoEventWireup="true"
    CodeBehind="Profile.aspx.cs" Inherits="Agriculture_Equipment_Store.Profile"
    MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="section-title">👤 My Profile</h2>

    <asp:Panel ID="pnlProfile" runat="server" CssClass="card p-4 shadow-sm" Visible="true" style="max-width:500px; margin:auto;">
        <asp:Label ID="lblMessage" runat="server" CssClass="text-success mb-3" Visible="false"></asp:Label>

        <div class="mb-3">
            <asp:Label ID="lblNameLabel" runat="server" Text="Full Name:" AssociatedControlID="txtName"></asp:Label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:Label ID="lblEmailLabel" runat="server" Text="Email:" AssociatedControlID="txtEmail"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:Label ID="lblPasswordLabel" runat="server" Text="Password:" AssociatedControlID="txtPassword"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:Label ID="lblPhoneLabel" runat="server" Text="Phone Number:" AssociatedControlID="txtPhone"></asp:Label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="mb-3">
            <asp:Label ID="lblAddressLabel" runat="server" Text="Address:" AssociatedControlID="txtAddress"></asp:Label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
    </asp:Panel>
</asp:Content>
