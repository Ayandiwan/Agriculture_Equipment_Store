<%@ Page Title="Update Product" Language="C#" MasterPageFile="~/Admin_check.Master" AutoEventWireup="true" CodeBehind="Admin_UpdateProduct.aspx.cs" Inherits="Agriculture_Equipment_Store.Admin_UpdateProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row g-4">

            <!-- Left: Form -->
            <div class="col-lg-7">
                <div class="card shadow-lg border-0 rounded-4 p-4">
                    <h3 class="text-primary fw-bold mb-4"><i class="bi bi-pencil-square"></i> Update Product</h3>

                    <!-- Select Product -->
                    <div class="mb-3">
                        <label class="form-label">Select Product</label>
                        <asp:DropDownList ID="ddlProducts" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <!-- Product Name -->
                    <div class="mb-3">
                        <label class="form-label">Product Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter product name" />
                    </div>

                    <!-- Category -->
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" placeholder="Enter category" />
                    </div>

                    <!-- Price + Stock -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Price (₹)</label>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="0.00" />
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Stock</label>
                            <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" placeholder="Quantity" />
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter product description" />
                    </div>

                    <!-- Image Upload -->
                    <div class="mb-3">
                        <label class="form-label">Upload Image</label>
                        <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" onchange="previewImage(event)" />
                    </div>

                    <!-- Update Button -->
                    <asp:Button ID="btnUpdateProduct" runat="server" Text="💾 Update Product" CssClass="btn btn-success w-100 fw-bold" OnClick="btnUpdateProduct_Click" />

                    <!-- Feedback -->
                    <asp:Label ID="lblMessage" runat="server" CssClass="mt-3 d-block text-center fw-bold"></asp:Label>
                </div>
            </div>

            <!-- Right: Live Preview -->
            <div class="col-lg-5">
                <div class="card shadow-lg border-0 rounded-4 p-4 text-center">
                    <h5 class="fw-bold text-secondary mb-3">📸 Live Preview</h5>
                    <img id="imgPreview" runat="server" src="https://via.placeholder.com/250x200?text=Product+Image"
                        class="img-fluid rounded mb-3" style="max-height: 220px; object-fit: cover;" />
                    <h6 id="previewName" class="fw-bold">Product Name</h6>
                    <p id="previewCategory" class="text-muted mb-1">Category</p>
                    <p id="previewPrice" class="text-success fw-bold">₹0.00</p>
                    <p id="previewStock" class="text-info fw-bold">Stock: 0</p>
                </div>
            </div>

        </div>
    </div>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />

    <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function () {
                document.getElementById("<%= imgPreview.ClientID %>").src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }

        document.addEventListener("input", function () {
            document.getElementById("previewName").innerText = document.getElementById("<%= txtName.ClientID %>").value || "Product Name";
            document.getElementById("previewCategory").innerText = document.getElementById("<%= txtCategory.ClientID %>").value || "Category";
            let price = document.getElementById("<%= txtPrice.ClientID %>").value;
            document.getElementById("previewPrice").innerText = price ? "₹" + price : "₹0.00";
            let stock = document.getElementById("<%= txtStock.ClientID %>").value;
            document.getElementById("previewStock").innerText = stock ? "Stock: " + stock : "Stock: 0";
        });
    </script>

</asp:Content>
