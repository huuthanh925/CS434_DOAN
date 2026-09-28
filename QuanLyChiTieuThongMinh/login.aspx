<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="QuanLyChiTieuThongMinh.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng nhập</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
        html,body,form{width:100%;height:100%;}
        body{background:#f7f9fc;}

        .container{
            width:100%;
            height:100vh;
            display:flex;
        }

        .left{
            width:50%;
            position:relative;
            background:linear-gradient(135deg,#5e7cff,#65d2f8);
            padding:55px 65px;
            color:white;
            overflow:hidden;
        }

        .logo{
            display:flex;
            align-items:center;
            gap:16px;
            position:relative;
            z-index:2;
        }

        .logo-icon{
            width:70px;
            height:70px;
            border-radius:20px;
            background:rgba(255,255,255,0.15);
            backdrop-filter:blur(15px);
            display:flex;
            align-items:center;
            justify-content:center;
            box-shadow:0 10px 30px rgba(0,0,0,.2), inset 0 1px 2px rgba(255,255,255,.3);
            overflow:hidden;
        }

        .logo-icon img{
            width:75%;
            height:75%;
            object-fit:contain;
            mix-blend-mode:darken;
            filter:contrast(1.3) brightness(.95) drop-shadow(0 4px 8px rgba(0,0,0,.3));
        }

        .logo-text{
            font-size:26px;
            font-weight:700;
            letter-spacing:1px;
            background:linear-gradient(90deg,#fff,#dbe4ff);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
        }

        .hero{
            margin-top:120px;
            position:relative;
            z-index:2;
        }

        .hero small{font-size:22px;}
        .hero h1{font-size:60px;font-weight:700;}
        .hero h2{font-size:46px;font-weight:300;}

        .line{
            margin-top:30px;
            width:260px;
            height:3px;
            background:white;
        }

        .circle1,.circle2{
            position:absolute;
            border-radius:50%;
            background:rgba(255,255,255,.15);
        }

        .circle1{width:300px;height:300px;top:-80px;right:-80px;}
        .circle2{width:400px;height:400px;bottom:-150px;left:-100px;}

        .right{
            width:50%;
            display:flex;
            justify-content:center;
            align-items:center;
            background:#fff;
            padding:24px;
            overflow:auto;
        }

        .login-box{
            width:420px;
            max-width:100%;
        }

        .login-box h2{
            text-align:center;
            color:#5e7cff;
            font-size:32px;
            margin-bottom:26px;
        }

        .input-group{
            margin-bottom:16px;
        }

        .input-group label{
            font-weight:600;
            margin-bottom:6px;
            display:block;
        }

        .input-group input{
            width:100%;
            height:52px;
            border-radius:30px;
            border:2px solid #e0e5f2;
            padding:0 20px;
            outline:none;
            transition:.25s;
        }

        .input-group input:focus{
            border-color:#5e7cff;
            box-shadow:0 0 0 4px rgba(94,124,255,.1);
        }

        .btn-login{
            width:100%;
            height:52px;
            border:none;
            border-radius:30px;
            background:linear-gradient(135deg,#5e7cff,#6ad4f7);
            color:white;
            font-weight:600;
            cursor:pointer;
            transition:.25s;
        }

        .btn-login:hover{
            transform:translateY(-2px);
        }

        .extra{
            text-align:center;
            margin-top:11px;
            font-size:14px;
        }

        .extra a{
            color:#5e7cff;
            font-weight:600;
            text-decoration:none;
        }

        .preview-box{
            margin-top:18px;
            padding:16px;
            border-radius:22px;
            background:linear-gradient(180deg,#f8faff,#ffffff);
            border:1px solid #e6edff;
            box-shadow:0 10px 24px rgba(94,124,255,.08);
        }

        .preview-title{
            display:flex;
            align-items:center;
            justify-content:space-between;
            margin-bottom:14px;
        }

        .preview-title h3{
            color:#4d6ef5;
            font-size:16px;
        }

        .guest-badge{
            padding:5px 10px;
            border-radius:999px;
            background:#eef3ff;
            color:#4d6ef5;
            font-size:11px;
            font-weight:700;
            white-space:nowrap;
        }

        .preview-grid{
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:10px;
        }

        .preview-card{
            background:white;
            border-radius:16px;
            padding:12px;
            border:1px solid #edf2ff;
        }

        .preview-card h4{
            color:#6b7280;
            font-size:12px;
            margin-bottom:5px;
            font-weight:600;
        }

        .preview-card span{
            font-size:20px;
            font-weight:700;
            color:#111827;
        }

        .preview-card small{
            display:block;
            margin-top:3px;
            color:#10b981;
            font-size:11px;
        }

        .btn-preview{
            width:100%;
            height:50px;
            margin-top:14px;
            border:none;
            border-radius:30px;
            background:#111827;
            color:white;
            font-weight:600;
            cursor:pointer;
            transition:.25s;
        }

        .btn-preview:hover{
            transform:translateY(-2px);
            background:#000;
        }

        @media(max-width:900px){
            .left{display:none;}
            .right{width:100%;}
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <div class="left">
        <div class="circle1"></div>
        <div class="circle2"></div>

        <div class="logo">
            <div class="logo-icon">
                <img src="images/logo.png" alt="logo" />
            </div>
            <div class="logo-text">EXPENSE AI</div>
        </div>

        <div class="hero">
            <small>Website</small>
            <h1>Quản Lý Chi Tiêu</h1>
            <h2>Tích hợp AI</h2>
            <div class="line"></div>
        </div>
    </div>

    <div class="right">

        <div class="login-box">

            <h2>ĐĂNG NHẬP</h2>

            <div class="input-group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Nhập email"></asp:TextBox>
            </div>

            <div class="input-group">
                <label>Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Nhập mật khẩu"></asp:TextBox>
            </div>

            <asp:Button
                ID="btnLogin"
                runat="server"
                Text="Đăng Nhập"
                CssClass="btn-login"
                OnClick="btnLogin_Click" />

            <div class="extra">
                <asp:LinkButton ID="lnkForgot" runat="server" OnClick="lnkForgot_Click">
                    Quên mật khẩu?
                </asp:LinkButton>
            </div>

            <div class="extra">
                Chưa có tài khoản?
                <asp:LinkButton ID="lnkRegister" runat="server" OnClick="lnkRegister_Click">
                    Đăng ký
                </asp:LinkButton>
            </div>

            <div class="preview-box">

                <div class="preview-title">
                    <h3>Xem trước hệ thống</h3>
                    <div class="guest-badge">Khách vãng lai</div>
                </div>

                <div class="preview-grid">

                    <div class="preview-card">
                        <h4>Thu nhập mẫu</h4>
                        <span>25M</span>
                        <small>Demo dashboard</small>
                    </div>

                    <div class="preview-card">
                        <h4>Chi tiêu mẫu</h4>
                        <span>8.3M</span>
                        <small>Thống kê nhanh</small>
                    </div>

                    <div class="preview-card">
                        <h4>AI tài chính</h4>
                        <span>Demo</span>
                        <small>Gợi ý thông minh</small>
                    </div>

                    <div class="preview-card">
                        <h4>Biểu đồ</h4>
                        <span>Live</span>
                        <small>Trực quan dữ liệu</small>
                    </div>

                </div>

                <asp:Button
                    ID="btnGuest"
                    runat="server"
                    Text="Xem trước hệ thống"
                    CssClass="btn-preview"
                    OnClick="btnGuest_Click" />

            </div>

        </div>

    </div>

</div>

</form>
</body>
</html>