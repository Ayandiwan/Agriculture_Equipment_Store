
<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/Admin_check.Master"
    AutoEventWireup="true" CodeBehind="Admin_delete_product.aspx.cs"
    Inherits="Agriculture_Equipment_Store.Admin_delete_product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h2 class="text-center mb-4 text-success">🛒 Manage / Edit / Deactivate Products</h2>

        <asp:GridView ID="GridView1" runat="server"
            CssClass="table table-bordered table-hover"
            AutoGenerateColumns="False" DataKeyNames="ProductID"
            OnRowEditing="GridView1_RowEditing"
            OnRowUpdating="GridView1_RowUpdating"
            OnRowCancelingEdit="GridView1_RowCancelingEdit"
            OnRowCommand="GridView1_RowCommand">

            <Columns>
                <%-- Product Info --%>
                <asp:BoundField DataField="ProductID" HeaderText="ID" ReadOnly="True" ItemStyle-Width="50px" />
                <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Width="150px" />
                <asp:BoundField DataField="Description" HeaderText="Description" ItemStyle-Width="250px" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" ItemStyle-Width="100px" />
                <asp:BoundField DataField="Stock" HeaderText="Stock" ItemStyle-Width="70px" />
                <asp:BoundField DataField="Category" HeaderText="Category" ItemStyle-Width="120px" />

                <%-- Active Status --%>
                <asp:CheckBoxField DataField="IsActive" HeaderText="Active" ReadOnly="True" ItemStyle-Width="80px" />

                <%-- Edit Button --%>
                <asp:CommandField ShowEditButton="True" HeaderText="Edit" ItemStyle-Width="80px" />

                <%-- Activate / Deactivate Button --%>
                <asp:TemplateField HeaderText="Action" ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkToggle" runat="server"
                            CommandName="ToggleStatus"
                            CommandArgument='<%# Eval("ProductID") %>'
                            Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>'
                            CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "btn btn-sm btn-danger" : "btn btn-sm btn-success" %>'>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <style>
        .table-hover tbody tr:hover {
            background-color: #f1f7f9;
        }
        .btn-sm {
            font-size: 0.85rem;
            padding: 0.25rem 0.5rem;
            margin: 2px 0;
        }
        .align-middle td {
            vertical-align: middle;
        }
    </style>
</asp:Content>



