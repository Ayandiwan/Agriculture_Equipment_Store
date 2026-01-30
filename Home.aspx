<%@ Page Title="Home - Agriculture Equipment Store"
    Language="C#"
    MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="Home.aspx.cs"
    Inherits="Agriculture_Equipment_Store.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    /* Full Page Background Image */
    body {
        background: url('image/high-angle-farmland-view.jpg') center/cover fixed no-repeat;
        backdrop-filter: brightness(0.9);
    }

    /* White card wrapper */
    .content-wrapper {
        background: rgba(255, 255, 255, 0.85);
        padding: 30px;
        border-radius: 15px;
        margin-top: 20px;
        margin-bottom: 20px;
    }

    /* Hero Section */
    .hero {
        background: url('images/farm-bg.jpg') center/cover no-repeat;
        height: 450px;
        display: flex;
        justify-content: center;
        align-items: center;
        color: white;
        text-shadow: 2px 2px 8px #000;
        border-radius: 15px;
    }

    .hero h1 {
        font-size: 48px;
        font-weight: 700;
    }

    .hero p {
        font-size: 20px;
    }

    .section-title {
        font-size: 32px;
        font-weight: 700;
        color: #ffffff;
        margin-bottom: 25px;
        text-align: center;
    }
/* Very Tiny Hover Effects */
.hero h1,
.hero p {
    transition: 0.2s ease-in-out;
}

.hero h1:hover {
    transform: scale(1.015); /* tiny zoom */
    text-shadow: 1px 1px 5px rgba(0,0,0,0.35); /* very soft glow */
}

.hero p:hover {
    transform: scale(1.01); /* tiny zoom */
    text-shadow: 1px 1px 4px rgba(0,0,0,0.30); /* tiny soft glow */
}



    /* ★ TRANSPARENT WHITE CATEGORY CARDS (Glass Effect) ★ */
    .category-card {
        background: rgba(255, 255, 255, 0.35); /* Transparent white */
        backdrop-filter: blur(10px);           /* Glass blur effect */
        -webkit-backdrop-filter: blur(10px);   /* Safari support */

        padding: 25px;
        border-radius: 15px;
        text-align: center;
        transition: 0.3s;
        cursor: pointer;
        border: 1px solid rgba(255, 255, 255, 0.4); /* Light white border */
        box-shadow: 0 4px 20px rgba(0,0,0,0.15);
    }

    .category-card:hover {
        background: rgba(255, 255, 255, 0.50);
        transform: translateY(-6px);
        box-shadow: 0 5px 20px rgba(0,0,0,0.25);
    }

    .category-card i {
        font-size: 48px;
        margin-bottom: 10px;
    }

</style>

<!-- 🌾 Hero Section -->
<div class="container mt-4">
    <div class="hero">
        <div class="text-center">
            <h1>Welcome to Agriculture Equipment Store</h1>
            <p>Your One-Stop Destination for All Agriculture Equipment</p>
            <a href="Products.aspx" class="btn btn-success btn-lg mt-3">Shop Now</a>
        </div>
    </div>
</div>

<!-- 🌾 Categories Section -->
<div class="container mt-5">
    <h2 class="section-title">Agriculture Categories</h2>

    <div class="row justify-content-center">

        <div class="col-md-4 mb-4">
            <div class="category-card">
                <i class="fas fa-tint" style="color:#0277bd;"></i>
                <h5 class="mt-3">Irrigation Tools</h5>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="category-card">
                <i class="fas fa-tools" style="color:#6a1b9a;"></i>
                <h5 class="mt-3">Garden Tools</h5>
            </div>
        </div>

        <div class="col-md-4 mb-4">
            <div class="category-card">
                <i class="fas fa-seedling" style="color:#2e7d32;"></i>
                <h5 class="mt-3">Farming Tools</h5>
            </div>
        </div>

    </div>
</div>

</asp:Content>
