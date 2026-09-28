<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="taikhoan.aspx.cs" Inherits="QuanLyChiTieuThongMinh.taikhoan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tài khoản</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <script src="https://unpkg.com/lucide@latest"></script>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#f4f6fb;
}

/* LAYOUT */
.container{
    display:flex;
    height:100vh;
}

/* ===== SIDEBAR CHUẨN HOÁ (GIỐNG TRANG CHỦ) ===== */
.sidebar{
    width:270px;
    background:linear-gradient(180deg,#5e7cff,#4d6ef5);
    color:#fff;
    padding:26px 18px;
    display:flex;
    flex-direction:column;
    box-shadow:6px 0 20px rgba(0,0,0,0.08);
}

.logo{
    display:flex;
    align-items:center;
    gap:12px;
    padding:10px 10px 20px;
    margin-bottom:10px;
}

.logo-box{
    width:44px;
    height:44px;
    border-radius:14px;
    background:rgba(255,255,255,0.18);
    display:flex;
    align-items:center;
    justify-content:center;
}

.logo-box img{
    width:70%;
}

.logo span{
    font-weight:700;
}

/* MENU */
.menu-group{
    margin-top:18px;
}

.menu-group p{
    font-size:11px;
    opacity:.75;
    margin:14px 10px 8px;
    letter-spacing:.8px;
}

.menu-group a{
    display:flex;
    align-items:center;
    gap:12px;
    padding:12px 14px;
    margin:6px 0;
    border-radius:12px;
    color:#fff;
    text-decoration:none;
    font-size:14px;
    transition:.2s ease;
}

.menu-group a:hover{
    background:rgba(255,255,255,0.15);
    transform:translateX(4px);
}

.menu-group a.active{
    background:rgba(255,255,255,0.25);
    box-shadow:inset 0 0 0 1px rgba(255,255,255,0.2);
}

/* LOGOUT CHUẨN HOÁ */
.logout{
    margin-top:auto;
    padding:14px 12px;
    border-radius:12px;
    background:rgba(255,255,255,0.12);
    display:flex;
    align-items:center;
    gap:10px;
    cursor:pointer;
    transition:.2s;
}

.logout:hover{
    background:rgba(255,255,255,0.2);
}

/* MAIN */
.main{
    flex:1;
    padding:28px 36px;
    overflow:auto;
}

.main h2{
    color:#4d6ef5;
    margin-bottom:20px;
}

/* GRID */
.grid{
    display:grid;
    grid-template-columns:1fr 2fr;
    gap:20px;
}

/* CARD */
.card{
    background:white;
    border-radius:18px;
    padding:25px;
    box-shadow:0 10px 25px rgba(0,0,0,0.06);
}

/* AVATAR */
.avatar{
    width:120px;
    height:120px;
    border-radius:50%;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:40px;
    color:white;
    margin:auto;
}

.center{
    text-align:center;
    margin-top:15px;
}

.btn{
    margin-top:15px;
    padding:10px 15px;
    border:none;
    border-radius:10px;
    background:#eef2ff;
    color:#5e7cff;
    cursor:pointer;
}

/* FORM */
.form{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:15px;
}

.form input,
.form select{
    height:45px;
    border-radius:10px;
    border:1px solid #ddd;
    padding:0 12px;
}

/* SWITCH */
.switch{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-top:15px;
}

.toggle{
    width:50px;
    height:26px;
    background:#ddd;
    border-radius:20px;
    position:relative;
    cursor:pointer;
}

.toggle.active{
    background:#5e7cff;
}

.toggle::after{
    content:"";
    width:22px;
    height:22px;
    background:white;
    position:absolute;
    top:2px;
    left:2px;
    border-radius:50%;
    transition:.3s;
}

.toggle.active::after{
    left:26px;
}

/* SAVE BUTTON */
.save-btn{
    margin-top:20px;
    padding:12px;
    border:none;
    border-radius:12px;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    color:white;
    font-weight:600;
    cursor:pointer;
}

/* RESPONSIVE */
@media(max-width:900px){
    .sidebar{display:none;}
    .grid{grid-template-columns:1fr;}
}
</style>

</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <!-- SIDEBAR ĐỒNG BỘ -->
    <div class="sidebar">

        <div>

            <div class="logo">
                <div class="logo-box">
                    <img src="images/logo.png" />
                </div>
                <span>EXPENSE AI</span>
            </div>

            <div class="menu-group">
                <p>TỔNG QUAN</p>
                <a href="trangchu.aspx"><i data-lucide="home"></i> Trang chủ</a>
                <a href="thuchi.aspx"><i data-lucide="wallet"></i> Thu chi</a>
            </div>

            <div class="menu-group">
                <p>PHÂN TÍCH</p>
                <a href="goiyai.aspx"><i data-lucide="sparkles"></i> Gợi ý AI</a>
                <a href="lichsu.aspx"><i data-lucide="history"></i> Lịch sử</a>
            </div>

            <div class="menu-group">
                <p>CÀI ĐẶT</p>
                <a href="thongke.aspx"><i data-lucide="bar-chart-3"></i> Thống kê</a>
                <a class="active" href="taikhoan.aspx"><i data-lucide="user"></i> Tài khoản</a>
            </div>

        </div>

        <asp:LinkButton runat="server" CssClass="logout" OnClick="Logout_Click">
            <i data-lucide="log-out"></i> Đăng xuất
        </asp:LinkButton>

    </div>

    <!-- MAIN -->
    <div class="main">

        <h2>Quản lý tài khoản</h2>

        <div class="grid">

            <!-- LEFT -->
            <div class="card">
                <div class="avatar">

                    <!-- HIỂN THỊ ẢNH -->
                    <asp:Image ID="imgAvatar" runat="server"
                        Width="120px"
                        Height="120px"
                        Style="border-radius:50%; object-fit:cover;" />

                    <!-- FALLBACK CHỮ -->
                    <asp:Label ID="lblAvatar" runat="server" Text="U"></asp:Label>

                </div>

                <div class="center">
                    <h3><asp:Label ID="lblName" runat="server" /></h3>
                    <p>Thành viên</p>

                    <asp:FileUpload ID="fileAvatar" runat="server" />
                    <asp:Button runat="server" Text="Cập nhật ảnh" CssClass="btn" OnClick="UploadAvatar" />
                </div>
            </div>

            <!-- RIGHT -->
            <div class="card">

                <h3>Thông tin cá nhân</h3>

                <div class="form">
                    <asp:TextBox ID="txtName" runat="server" placeholder="Họ tên" />
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" />
                    <asp:TextBox ID="txtPhone" runat="server" placeholder="SĐT" />

                    <asp:DropDownList ID="ddlLang" runat="server">
                        <asp:ListItem>Tiếng Việt</asp:ListItem>
                        <asp:ListItem>English</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <h3 style="margin-top:20px;">Cài đặt</h3>

                <div class="switch">
                    <span>Thông báo chi tiêu</span>
                    <div class="toggle" onclick="toggle(this)"></div>
                </div>

                <div class="switch">
                    <span>Báo cáo tuần</span>
                    <div class="toggle active" onclick="toggle(this)"></div>
                </div>

                <asp:Button runat="server" Text="Lưu thay đổi"
                    CssClass="save-btn"
                    OnClick="Save_Click" />

            </div>

        </div>

    </div>

</div>

</form>

<script>
    lucide.createIcons();

    function toggle(el) {
        el.classList.toggle("active");
    }
</script>

</body>
</html>