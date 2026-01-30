<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="otp.aspx.cs" Inherits="Agriculture_Equipment_Store.otp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Email OTP Verification</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0f7ea, #ffffff);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }
        .otp-wrapper {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .otp-card {
            background: #ffffff;
            border-radius: 25px;
            box-shadow: 0 15px 30px rgba(0,128,0,0.25);
            padding: 2.5rem;
            max-width: 420px;
            width: 100%;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .otp-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,128,0,0.35);
        }
        .otp-header-icon {
            font-size: 3rem;
            color: #28a745;
            margin-bottom: 1rem;
            animation: bounce 1.2s infinite alternate;
        }
        @keyframes bounce {
            0% { transform: translateY(0); }
            100% { transform: translateY(-10px); }
        }
        .otp-card h3 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #28a745;
            margin-bottom: 1.8rem;
        }
        .form-control {
            border-radius: 20px;
            border: 2px solid #c3e6cb;
            padding: 0.7rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 10px rgba(40,167,69,0.4);
        }
        .btn-success, .btn-danger {
            border-radius: 12px;
            font-weight: 600;
            padding: 0.65rem 1rem;
            transition: all 0.3s ease;
        }
        .btn-success:hover {
            background: linear-gradient(135deg, #218838, #1e7e34);
            transform: scale(1.05);
            box-shadow: 0 6px 18px rgba(33,136,56,0.5);
        }
        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            transform: scale(1.05);
            box-shadow: 0 6px 18px rgba(198,35,45,0.5);
        }
        .otp-message {
            margin-top: 10px;
            font-weight: bold;
            font-size: 1rem;
        }
        .resend-link {
            margin-top: 12px;
            display: inline-block;
            color: #28a745;
            text-decoration: none;
            font-weight: 600;
            cursor:pointer;
        }
        .resend-link:hover {
            color: #1e7e34;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="otp-wrapper">
            <div class="card otp-card">
                <div class="otp-header-icon">🌾</div>
                <h3>Email OTP Verification</h3>

                <div class="mb-3">
                    <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control" placeholder="Enter OTP" />
                </div>

                <div class="d-grid gap-2 mb-3">
                    <asp:Button ID="btnVerify" runat="server" Text="Verify OTP" CssClass="btn btn-success btn-block" OnClick="btnVerify_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger btn-block" OnClick="cancel_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="otp-message" />

                <div>
                    <asp:LinkButton ID="lnkResendOTP" runat="server" CssClass="resend-link" OnClick="lnkResendOTP_Click">Resend OTP</asp:LinkButton>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
