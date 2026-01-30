<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Agriculture_Equipment_Store.ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Forgot Password - Agriculture Store</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: linear-gradient(135deg, #cdebb5, #a8e063, #56ab2f);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
        }

        .forgot-box {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            animation: slideUp 0.6s ease;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .forgot-box h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 25px;
            color: #256d1b;
        }

        .input-group-text {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: none;
            border-right: 1px solid #d0d0d0;
        }

        .form-control {
            border: none;
            box-shadow: none;
            border-radius: 0 10px 10px 0;
            background-color: #f8fdf8;
        }

        .form-control:focus {
            background-color: #fff;
            border: 1px solid #56ab2f;
            box-shadow: 0 0 5px rgba(86, 171, 47, 0.4);
        }

        .input-group {
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 15px;
            border: 1px solid #c7e5b4;
        }

        .btn-success {
            width: 100%;
            padding: 10px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: linear-gradient(90deg, #56ab2f, #a8e063);
            border: none;
        }

        .btn-success:hover {
            transform: scale(1.03);
            box-shadow: 0 5px 15px rgba(86, 171, 47, 0.4);
        }

        .login-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #2e7d32;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        .error-text {
            font-size: 0.85rem;
            color: #d32f2f;
            margin-left: 8px;
        }

        .icon-title {
            text-align: center;
            font-size: 45px;
            color: #2e7d32;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="forgot-box">
            <div class="icon-title">
                <i class="fa-solid fa-leaf"></i>
            </div>
            <h2>Forgot Password</h2>

            <!-- Email -->
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-envelope"></i></span>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Enter your email" CssClass="error-text" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Invalid email format"
                    CssClass="error-text"
                    Display="Dynamic"
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" />
            </div>

            <!-- Current Password -->
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                    <asp:TextBox ID="txtCurrentPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Current password"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvCurPass" runat="server" ControlToValidate="txtCurrentPass"
                    ErrorMessage="Enter current password" CssClass="error-text" Display="Dynamic" />
            </div>

            <!-- New Password -->
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-key"></i></span>
                    <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="New password"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ControlToValidate="txtNewPass"
                    ErrorMessage="Enter new password" CssClass="error-text" Display="Dynamic" />
            </div>

            <!-- Confirm Password -->
            <div class="mb-3">
                <div class="input-group">
                    <span class="input-group-text"><i class="fa-solid fa-check"></i></span>
                    <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm new password"></asp:TextBox>
                </div>
                <asp:CompareValidator ID="cvPassword" runat="server"
                    ControlToCompare="txtNewPass" ControlToValidate="txtConfirmPass"
                    ErrorMessage="Passwords do not match" CssClass="error-text" Display="Dynamic" />
            </div>

            <!-- Submit -->
            <asp:Button ID="btnSubmit" runat="server" Text="Reset Password" CssClass="btn btn-success" OnClick="btnsubmit_Click" />

            <a href="login.aspx" class="login-link">← Back to Login</a>
        </div>
    </form>
</body>
</html>
