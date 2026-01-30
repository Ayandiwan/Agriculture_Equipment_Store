<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Agriculture_Equipment_Store.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Login</title>

    <!-- Bootstrap CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: url('image/sunny-meadow-landscape.jpg') no-repeat center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            animation: fadeIn 1.2s ease-in-out;
        }

        .welcome-container {
            width: 100%;
            background: rgba(40, 167, 69, 0.9);
            color: white;
            font-size: 22px;
            font-weight: bold;
            padding: 8px 0;
            overflow: hidden;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .welcome-text {
            display: inline-block;
            white-space: nowrap;
            position: relative;
            animation: moveText 12s linear infinite;
        }

        @keyframes moveText {
            0% { left: 100%; }
            100% { left: -100%; }
        }

        .login-card {
            border-radius: 30px;
            background-color: rgba(255, 255, 255, 0.94);
            box-shadow: 0 8px 25px rgba(0, 128, 0, 0.35);
            border: 2px solid #28a745;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-top: 70px;
        }

        .login-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 12px 30px rgba(0, 128, 0, 0.45);
        }

        .login-card h3 {
            color: #28a745;
            font-weight: bold;
            text-shadow: 1px 1px 3px rgba(0, 128, 0, 0.3);
        }

        .form-control, .form-select {
            border-radius: 20px;
            border: 2px solid #c3e6cb;
            transition: all 0.3s ease;
            font-weight: 500;
            color: #155724;
        }

        .form-control:focus, .form-select:focus {
            border-color: #28a745;
            box-shadow: 0 0 10px rgba(40, 167, 69, 0.4);
            transform: scale(1.02);
        }

        .form-select:hover {
            border-color: #28a745;
            cursor: pointer;
        }

        .form-label {
            font-weight: 600;
            color: #155724;
        }

        .btn-success {
            background: linear-gradient(145deg, #28a745, #218838);
            border: none;
            font-weight: 600;
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #218838, #1e7e34);
            transform: scale(1.05);
            box-shadow: 0 6px 18px rgba(33, 136, 56, 0.5);
        }

        .btn-success:active {
            transform: scale(0.97);
        }

        .extra-links {
            text-align: center;
            margin-top: 12px;
        }

        .extra-links a {
            color: #28a745;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .extra-links a:hover {
            color: #1e7e34;
            text-decoration: underline;
        }

        .text-danger {
            display: block;
            margin-top: 4px;
            font-size: 0.9rem;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Welcome Banner -->
        <div class="welcome-container">
            <div class="welcome-text">🌾 Welcome to Agriculture Equipment Store 🌾</div>
        </div>

        <!-- Login Card -->
        <div class="container d-flex justify-content-center align-items-center vh-100">
            <div class="card p-4 login-card" style="width: 23rem; animation: fadeIn 1.2s ease;">
                <div class="text-center mb-3">
                    <h3>Login</h3>
                </div>

                <!-- Validation Summary (optional) -->

                <!-- Email -->
                <div class="mb-3">
                    <asp:Label ID="lblUser" runat="server" Text="Email" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Enter Your Email" />
                    <asp:RequiredFieldValidator ID="rf1" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtemail" ForeColor="Red" SetFocusOnError="True" Display="Dynamic" />
                     <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtemail" ErrorMessage="Enter a valid email" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"  ForeColor="Red"  Display="Dynamic" />
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <asp:Label ID="lblPass" runat="server" Text="Password" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password" />
                    <asp:RequiredFieldValidator ID="rf2" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtPassword" ForeColor="Red" SetFocusOnError="True" Display="Dynamic" />
                </div>

                <!-- Dropdown -->
                <div class="mb-3">
                    <asp:Label ID="lbldropdown" runat="server" Text="Type" CssClass="form-label"></asp:Label>
                    <asp:DropDownList ID="ddltype" runat="server" CssClass="form-select">
                        <asp:ListItem Text="-- Select Type --" Value=""></asp:ListItem>
                        <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                        <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rf3" runat="server" ErrorMessage="Select Role" ControlToValidate="ddltype" InitialValue="" ForeColor="Red" SetFocusOnError="True" Display="Dynamic" />
                </div>

                <!-- Login Button -->
                <div class="d-grid mb-3">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success btn-block" OnClick="btnLogin_Click" />
                </div>

                <!-- Forgot Password + Register -->
                <div class="extra-links">
                    <a href="ForgotPassword.aspx">Forgot Password?</a>
                    <br />
                    <a href="Register.aspx">🌱 New User? Register Here</a>
                </div>

                <!-- Message Label -->
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold"></asp:Label>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
