<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgot.aspx.cs" Inherits="QuanLyChiTieuThongMinh.forgot" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quên mật khẩu</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
        html,body,form{width:100%;height:100%;}
        body{background:#f7f9fc;}

        .container{display:flex;height:100vh;}

        /* LEFT */
        .left{
            width:50%;
            background:linear-gradient(135deg,#5e7cff,#65d2f8);
            padding:60px;
            color:#fff;
            position:relative;
            overflow:hidden;
        }

        .logo{display:flex;align-items:center;gap:15px;}
        .logo-icon{
            width:65px;height:65px;border-radius:20px;
            background:rgba(255,255,255,.2);
            backdrop-filter:blur(12px);
            display:flex;align-items:center;justify-content:center;
            overflow:hidden;
        }
        .logo-icon img{width:75%;object-fit:contain;mix-blend-mode:darken;}
        .logo-text{font-size:26px;font-weight:700;}

        .hero{margin-top:120px;}
        .hero small{font-size:20px;}
        .hero h1{font-size:60px;font-weight:700;}
        .hero h2{font-size:46px;font-weight:300;}
        .line{margin-top:30px;width:250px;height:3px;background:#fff;}

        .circle{position:absolute;border-radius:50%;background:rgba(255,255,255,.15);}
        .c1{width:300px;height:300px;top:-80px;right:-80px;}
        .c2{width:400px;height:400px;bottom:-150px;left:-100px;}

        /* RIGHT */
        .right{
            width:50%;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .box{width:420px;}
        .box h2{
            text-align:center;
            color:#5e7cff;
            font-size:34px;
            margin-bottom:35px;
        }

        .desc{
            text-align:center;
            margin-bottom:25px;
            color:#666;
            font-size:14px;
        }

        .group{margin-bottom:20px;}
        .group label{font-weight:600;display:block;margin-bottom:6px;}

        .group input{
            width:100%;height:55px;
            border-radius:30px;
            border:2px solid #e0e5f2;
            padding:0 20px;
        }

        .group input:focus{
            border-color:#5e7cff;
            box-shadow:0 0 0 4px rgba(94,124,255,.1);
            outline:none;
        }

        .btn{
            width:100%;height:55px;
            border:none;border-radius:30px;
            background:linear-gradient(135deg,#5e7cff,#6ad4f7);
            color:#fff;font-weight:600;
            cursor:pointer;
        }

        .btn:hover{transform:translateY(-2px);}

        .extra{text-align:center;margin-top:15px;}
        .extra a{
            color:#5e7cff;
            font-weight:600;
            text-decoration:none;
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

    <!-- LEFT -->
    <div class="left">
        <div class="circle c1"></div>
        <div class="circle c2"></div>

        <div class="logo">
            <div class="logo-icon">
                <img src="images/logo.png" />
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

    <!-- RIGHT -->
    <div class="right">
        <div class="box">

            <h2>QUÊN MẬT KHẨU</h2>

            <div class="desc">
                Nhập email của bạn để nhận hướng dẫn đặt lại mật khẩu
            </div>

            <div class="group">
                <label>Email</label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Nhập email"></asp:TextBox>
            </div>

            <asp:Button ID="btnSend" runat="server"
                Text="Gửi yêu cầu"
                CssClass="btn"
                OnClick="btnSend_Click" />

            <div class="extra">
                Quay lại?
                <asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click">
                    Đăng nhập
                </asp:LinkButton>
            </div>

        </div>
    </div>

</div>

</form>
</body>
</html>