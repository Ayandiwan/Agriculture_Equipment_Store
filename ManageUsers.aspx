<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Admin_check.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="Agriculture_Equipment_Store.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        h2 {
            color: #198754;
            font-weight: 700;
        }

        .table {
            border-radius: 12px;
            overflow: hidden;
        }

        .table th {
            background-color: #198754;
            color: white;
            text-align: center;
        }

        .table td {
            text-align: center;
            vertical-align: middle;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
            border-radius: 8px;
            padding: 5px 10px;
            font-weight: 500;
        }

        .btn-delete:hover {
            background-color: #b02a37;
        }

        .search-box {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }

        .search-box input {
            width: 300px;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        #lblMessage {
            font-weight: bold;
            text-align: center;
            display: block;
            margin-top: 10px;
        }
    </style>

    <div class="container mt-5">
        <div class="card p-4">
            <h2 class="text-center mb-4">👥 Manage Users</h2>

            <div class="search-box">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="🔍 Search by name or email"></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" OnClick="btnSearch_Click" />
            </div>

            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                DataKeyNames="Userid" OnRowDeleting="gvUsers_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="Userid" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Role" HeaderText="Role" />
                    <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" />
                    <asp:BoundField DataField="Addrese" HeaderText="Address" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" Text="🗑 Delete" CommandName="Delete"
                                OnClientClick="return confirm('Are you sure you want to delete this user?');"
                                CssClass="btn btn-delete btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
        </div>
    </div>

</asp:Content>
