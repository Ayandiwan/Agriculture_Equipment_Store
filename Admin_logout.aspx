<%@ Page Title="Admin Logout" Language="C#" MasterPageFile="~/Admin_check.Master" AutoEventWireup="true" CodeBehind="Admin_logout.aspx.cs" Inherits="Agriculture_Equipment_Store.Admin_logout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container d-flex justify-content-center align-items-center" style="min-height:70vh;">
        <div class="card shadow-lg text-center p-4" style="max-width: 500px; border-radius: 15px;">
            <div class="card-body">
                <div class="mb-3">
                    <i class="bi bi-box-arrow-right text-success" style="font-size: 3rem;"></i>
                </div>
                <h3 class="card-title mb-2">Logged Out Successfully!</h3>
                <p class="card-text text-muted mb-4">You have safely logged out of the admin panel.</p>
                <div class="spinner-border text-success mb-3" role="status">
                    <span class="visually-hidden">Redirecting...</span>
                </div>
                <p class="text-muted">Redirecting to the login page in <span id="countdown">5</span> seconds...</p>
                <a href="Admin_login.aspx" class="btn btn-success mt-2">Go to Login Now</a>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Countdown redirect
        var seconds = 5;
        var countdown = document.getElementById("countdown");
        var interval = setInterval(function () {
            seconds--;
            countdown.textContent = seconds;
            if (seconds <= 0) {
                clearInterval(interval);
                window.location.href = "login.aspx";
            }
        }, 1000);
    </script>
</asp:Content>
