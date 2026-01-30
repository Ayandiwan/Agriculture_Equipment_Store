<%@ Page Title="Add Product" Language="C#" MasterPageFile="~/Admin_check.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="Agriculture_Equipment_Store.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row g-4">

            <!-- Left Side: Form -->
            <div class="col-lg-7">
                <div class="card shadow-sm border-0 rounded-4 p-4">
                    <h3 class="text-success fw-bold mb-4"><i class="bi bi-bag-plus"></i> Add New Product</h3>

                    <!-- Product Name -->
                    <div class="mb-3">
                        <label class="form-label">Product Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter product name" />
                    </div>

                    <!-- Category -->
                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control" placeholder="E.g. Seeds, Tools, Fertilizers" />
                    </div>

                    <!-- Price + Stock -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Price (₹)</label>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="0.00" />
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Stock</label>
                            <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" placeholder="Available quantity" />
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                            TextMode="MultiLine" Rows="3" placeholder="Write a short product description" />
                    </div>

                    <!-- Upload Image -->
                    <div class="mb-3">
                        <label class="form-label">Upload Image</label>
                        <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" onchange="previewImage(event)" />
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 mt-3">
                        <asp:Button ID="btnAdd" runat="server" Text="🚀 Add Product" CssClass="btn btn-success flex-fill fw-bold" OnClick="btnAdd_Click" />
                        <asp:Button ID="btnupd" runat="server" Text="✏️ Update" CssClass="btn btn-primary flex-fill fw-bold" OnClick="btnUpd_Click" />
                        <asp:Button ID="btndel" runat="server" Text="🗑️ Delete" CssClass="btn btn-danger flex-fill fw-bold" OnClick="btndel_Click" />
                    </div>

                    <asp:Label ID="lblMessage" runat="server" CssClass="mt-3 d-block text-center fw-bold"></asp:Label>

                </div>
            </div>

            <!-- Right Side: Live Preview -->
            <div class="col-lg-5">
                <div class="card shadow-sm border-0 rounded-4 p-3 text-center">
                    <h5 class="fw-bold text-secondary mb-3">📸 Live Preview</h5>
                    <img id="imgPreview" src="https://via.placeholder.com/250x200?text=Product+Image"
                        class="img-fluid rounded mb-3" style="max-height: 220px; object-fit: cover;" />
                    <h6 id="previewName" class="fw-bold">Product Name</h6>
                    <p id="previewCategory" class="text-muted mb-1">Category</p>
                    <p id="previewPrice" class="text-success fw-bold">₹0.00</p>
                </div>
            </div>

        </div>
    </div>

    <!-- ✅ Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />

    <script>
        // Live image preview
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function () {
                document.getElementById("imgPreview").src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }

        // Live text preview
        document.addEventListener("input", function () {
            document.getElementById("previewName").innerText = document.getElementById("<%= txtName.ClientID %>").value || "Product Name";
            document.getElementById("previewCategory").innerText = document.getElementById("<%= txtCategory.ClientID %>").value || "Category";
            let price = document.getElementById("<%= txtPrice.ClientID %>").value;
            document.getElementById("previewPrice").innerText = price ? "₹" + price : "₹0.00";
        });
    </script>

</asp:Content>
