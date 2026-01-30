<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Agriculture_Equipment_Store.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Register - Agriculture Store</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            margin: 0;
            height: 100vh;
            font-family: "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #e8f5e9, #f1f8f6);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .register-card {
            width: 420px;
            background: #fff;
            border-radius: 15px;
            padding: 30px 25px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
            animation: fadeIn 0.6s ease;
        }

        .register-card h3 {
            text-align: center;
            font-weight: bold;
            font-size: 22px;
            color: #2e7d32;
            margin-bottom: 10px;
        }

        .form-label {
            font-weight: 600;
            font-size: 13px;
            color: #2e7d32;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #c8e6c9;
            padding: 7px;
            font-size: 13px;
        }

        .btn-register {
            background: linear-gradient(90deg, #66bb6a, #2e7d32);
            border: none;
            border-radius: 8px;
            font-weight: bold;
            font-size: 14px;
            color: white;
            transition: 0.3s;
            padding: 8px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(46, 125, 50, 0.35);
        }

        .extra-links {
            text-align: center;
            margin-top: 10px;
        }

        .extra-links a {
            font-size: 13px;
            color: #2e7d32;
            font-weight: 600;
            text-decoration: none;
        }

        .extra-links a:hover {
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-card">
            <h3>🌱 Register</h3>

            <div class="mb-2">
                <asp:Label ID="lbluname" runat="server" Text="Name" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtuname" runat="server" CssClass="form-control" placeholder="Enter your name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rf1" runat="server" ErrorMessage="Enter User Name" ControlToValidate="txtuname" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="mb-2">
                <asp:Label ID="lblpass" runat="server" Text="Password" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtupass" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rf2" runat="server" ErrorMessage="Enter Password" ControlToValidate="txtupass" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="mb-2">
                <asp:Label ID="lblemail" runat="server" Text="Email" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfEmail" runat="server" ErrorMessage="Enter Email" ControlToValidate="txtemail" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="mb-2">
                <asp:Label ID="lblpho" runat="server" Text="Phone No" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtphono" runat="server" CssClass="form-control" placeholder="Enter Phone No"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfPhone" runat="server" ErrorMessage="Enter Phone Number" ControlToValidate="txtphono" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtphono" ErrorMessage="Enter Valid Number" ValidationExpression="^\d{10}$" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <div class="mb-2">
                <asp:Label ID="lblAddrese" runat="server" Text="Address" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtaddrese" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Enter Address"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfAddress" runat="server" ErrorMessage="Enter Address" ControlToValidate="txtaddrese" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="d-grid mb-2">
                <asp:Button ID="btnSubmit" runat="server" Text="Register" CssClass="btn btn-register btn-block" OnClick="btnSubmit_Click" />
            </div>

            <div class="extra-links">
                <a href="login.aspx">Already have an account? Login here 🚜</a>
            </div>
        </div>
    </form>
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
