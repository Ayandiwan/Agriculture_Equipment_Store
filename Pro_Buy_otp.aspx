<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pro_Buy_otp.aspx.cs" Inherits="Agriculture_Equipment_Store.Pro_Buy_otp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>OTP Verification - Agriculture Equipment Store</title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0f7df, #c8f5d0, #a9f0c0);
            background-size: 400% 400%;
            animation: gradientFlow 12s infinite ease-in-out;
            font-family: 'Poppins', sans-serif;
            overflow: hidden;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        @keyframes gradientFlow {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .floating {
            position: absolute;
            opacity: 0.2;
            animation: floaty 10s ease-in-out infinite;
        }

        @keyframes floaty {
            0% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-30px) rotate(20deg); }
            100% { transform: translateY(0px) rotate(0deg); }
        }

        .otp-card {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(18px);
            border-radius: 25px;
            box-shadow: 0 8px 35px rgba(40, 167, 69, 0.35);
            text-align: center;
            padding: 3rem 2.5rem;
            width: 90%;
            max-width: 450px;
            animation: fadeIn 1.2s ease-in-out;
            position: relative;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .otp-icon {
            font-size: 4rem;
            color: #00a65a;
            text-shadow: 0 0 15px rgba(0, 166, 90, 0.6);
            margin-bottom: 1rem;
        }

        h3 {
            font-weight: 700;
            font-size: 1.8rem;
        }

        p {
            color: #145a32;
            font-size: 1rem;
            margin-bottom: 1.5rem;
        }

        .otp-inputs {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 1.5rem;
        }

        .otp-box {
            width: 50px;
            height: 55px;
            font-size: 1.5rem;
            font-weight: bold;
            text-align: center;
            border: 2px solid rgba(40, 167, 69, 0.4);
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.5);
            transition: all 0.3s ease;
        }

        .otp-box:focus {
            border-color: #00c851;
            box-shadow: 0 0 8px rgba(0, 200, 81, 0.5);
            outline: none;
        }

        .progress-ring {
            display: none;
            margin: 1rem auto;
            width: 60px;
            height: 60px;
            border: 6px solid rgba(0, 200, 81, 0.2);
            border-top-color: #00c851;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            100% { transform: rotate(360deg); }
        }

        .btn {
            border-radius: 15px;
            font-weight: 600;
            padding: 0.8rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .btn-verify {
            background: linear-gradient(90deg, #00c851, #007e33);
            color: #fff;
            border: none;
        }

        .btn-verify:hover {
            transform: scale(1.05);
            box-shadow: 0 0 12px rgba(0, 200, 81, 0.5);
        }

        .btn-cancel {
            background: linear-gradient(90deg, #ff4444, #cc0000);
            color: #fff;
            border: none;
        }

        .btn-cancel:hover {
            transform: scale(1.05);
            box-shadow: 0 0 12px rgba(255, 68, 68, 0.5);
        }

        .otp-message {
            font-weight: bold;
            font-size: 0.95rem;
            margin-top: 15px;
        }

        .resend-link {
            display: inline-block;
            margin-top: 18px;
            color: #1b5e20;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .resend-link:hover {
            color: #00c851;
            text-decoration: underline;
        }

        .countdown {
            font-weight: 600;
            color: #28a745;
        }

        .success-popup {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0.8);
            background: rgba(255, 255, 255, 0.95);
            border-radius: 25px;
            box-shadow: 0 0 25px rgba(46, 204, 113, 0.4);
            padding: 2rem;
            animation: popIn 0.6s ease forwards;
        }

        @keyframes popIn {
            to { transform: translate(-50%, -50%) scale(1); }
        }

        .success-icon {
            font-size: 3rem;
            color: #00c851;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="floating" style="top:10%; left:5%;">🍃</div>
    <div class="floating" style="bottom:15%; right:10%; animation-delay:2s;">🌿</div>
    <div class="floating" style="top:70%; left:80%; animation-delay:4s;">🍀</div>

    <form id="form1" runat="server">
        <div class="otp-card">
            <div class="otp-icon">🔒</div>
            <h3>Verify Your OTP</h3>
            <p>Please enter the 6-digit code sent to your email.</p>

            <div class="otp-inputs">
                <input type="text" maxlength="1" class="otp-box" oninput="moveNext(this,1)" />
                <input type="text" maxlength="1" class="otp-box" oninput="moveNext(this,2)" />
                <input type="text" maxlength="1" class="otp-box" oninput="moveNext(this,3)" />
                <input type="text" maxlength="1" class="otp-box" oninput="moveNext(this,4)" />
                <input type="text" maxlength="1" class="otp-box" oninput="moveNext(this,5)" />
                <input type="text" maxlength="1" class="otp-box" oninput="moveNext(this,6)" />
            </div>

            <!-- Hidden OTP textbox for backend -->
            <asp:TextBox ID="txtOTP" runat="server" CssClass="d-none"></asp:TextBox>

            <div class="d-grid gap-2">
                <asp:Button ID="btnVerify" runat="server" Text="✔ Verify OTP"
                    CssClass="btn btn-verify"
                    OnClientClick="combineOTP(); return startVerification();"
                    OnClick="btnVerify_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="✖ Cancel" CssClass="btn btn-cancel" OnClick="btnCancel_Click" />
            </div>

            <div id="progress" class="progress-ring"></div>

            <asp:Label ID="lblMessage" runat="server" CssClass="otp-message text-danger"></asp:Label>

            <div class="mt-2">
                <asp:LinkButton ID="lnkResend" runat="server" CssClass="resend-link" OnClick="ResendOTP">
                    ↻ Resend OTP
                </asp:LinkButton>
                <span id="countdown" class="countdown"></span>
            </div>

            <div id="successPopup" class="success-popup">
                <div class="success-icon">✅</div>
                <h4>OTP Verified!</h4>
                <p>Your purchase is confirmed. Thank you 🌱</p>
            </div>
        </div>
    </form>

    <script>
        const otpBoxes = document.querySelectorAll('.otp-box');
        function moveNext(current, index) {
            if (current.value.length === 1 && index < otpBoxes.length) {
                otpBoxes[index].focus();
            }
        }

        function combineOTP() {
            let otp = "";
            otpBoxes.forEach(box => otp += box.value);
            document.getElementById("<%= txtOTP.ClientID %>").value = otp;
        }

        function startVerification() {
            document.getElementById("progress").style.display = "block";
            setTimeout(() => {
                document.getElementById("progress").style.display = "none";
                document.getElementById("successPopup").style.display = "block";
            }, 2500);
            return true;
        }

        let resendTimer;
        function startCountdown() {
            const countdown = document.getElementById('countdown');
            let timeLeft = 30;
            countdown.textContent = ` (Wait ${timeLeft}s)`;
            resendTimer = setInterval(() => {
                timeLeft--;
                countdown.textContent = ` (Wait ${timeLeft}s)`;
                if (timeLeft <= 0) {
                    clearInterval(resendTimer);
                    countdown.textContent = "";
                }
            }, 1000);
        }
    </script>
</body>
</html>
