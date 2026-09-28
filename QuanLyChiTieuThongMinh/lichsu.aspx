<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lichsu.aspx.cs" Inherits="QuanLyChiTieuThongMinh.lichsu" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lịch sử</title>

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
    background:#eef2ff;
    color:#1f2937;
}

.container{
    display:flex;
    height:100vh;
}

.sidebar{
    width:260px;
    background:linear-gradient(180deg,#5e7cff,#4d6ef5);
    color:white;
    padding:26px 18px;
    display:flex;
    flex-direction:column;
    box-shadow:5px 0 25px rgba(0,0,0,.08);
}

.logo{
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:35px;
}

.logo-box{
    width:44px;
    height:44px;
    background:rgba(255,255,255,.18);
    border-radius:14px;
    display:flex;
    align-items:center;
    justify-content:center;
}

.logo-box img{
    width:70%;
}

.menu-group{
    margin-bottom:18px;
}

.menu-group p{
    font-size:11px;
    opacity:.75;
    margin-bottom:10px;
}

.menu-group a{
    display:flex;
    align-items:center;
    gap:12px;
    padding:12px;
    border-radius:12px;
    color:white;
    text-decoration:none;
    margin-bottom:6px;
    transition:.25s;
    font-size:14px;
}

.menu-group a:hover{
    background:rgba(255,255,255,.18);
    transform:translateX(5px);
}

.menu-group a.active{
    background:rgba(255,255,255,.28);
}

.logout{
    margin-top:auto;
}

.logout a{
    color:#ffdddd;
    display:flex;
    gap:10px;
    text-decoration:none;
    font-weight:500;
    padding:12px;
    border-radius:12px;
    background:rgba(255,0,0,.12);
}

.main{
    flex:1;
    padding:28px;
    overflow:auto;
}

.header{
    margin-bottom:22px;
}

.header h2{
    color:#4d6ef5;
    font-size:24px;
}

.filter-box{
    background:white;
    border-radius:20px;
    padding:20px;
    margin-bottom:22px;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    border:1px solid #edf2ff;
}

.filter-grid{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:14px;
}

.filter-grid input,
.filter-grid select{
    height:48px;
    border:1px solid #e5e7eb;
    border-radius:14px;
    padding:0 14px;
    outline:none;
}

.btn-filter{
    border:none;
    border-radius:14px;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    color:white;
    font-weight:600;
    cursor:pointer;
}

.history-card{
    background:white;
    border-radius:22px;
    padding:22px;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    border:1px solid #edf2ff;
}

.history-item{
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:16px;
    border-radius:18px;
    border:1px solid #eef2ff;
    margin-bottom:14px;
    transition:.2s;
    background:#fff;
}

.history-item:hover{
    transform:translateY(-2px);
    box-shadow:0 10px 22px rgba(0,0,0,.05);
}

.left-info{
    display:flex;
    align-items:center;
    gap:14px;
}

.icon-box{
    width:46px;
    height:46px;
    min-width:46px;
    border-radius:16px;
    display:flex;
    align-items:center;
    justify-content:center;
    background:linear-gradient(135deg,#eef3ff,#ffffff);
    color:#5e7cff;
    border:1px solid #e6ebff;
}

.icon-box i{
    width:21px;
    height:21px;
}

.title{
    font-weight:600;
    color:#111827;
}

.date{
    font-size:12px;
    color:#6b7280;
    margin-top:3px;
}

.amount{
    font-weight:700;
    font-size:15px;
}

.income{
    color:#16a34a;
}

.expense{
    color:#ef4444;
}

.status{
    padding:6px 11px;
    border-radius:999px;
    background:#eef3ff;
    color:#4d6ef5;
    font-size:12px;
    font-weight:600;
    margin-left:12px;
}

.empty{
    padding:28px;
    text-align:center;
    color:#6b7280;
    background:#f8faff;
    border-radius:18px;
    border:1px dashed #dbe4ff;
}

@media(max-width:900px){
    .sidebar{
        display:none;
    }

    .filter-grid{
        grid-template-columns:1fr;
    }
}
</style>
</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <div class="sidebar">

        <div>

            <div class="logo">
                <div class="logo-box">
                    <img src="images/logo.png" />
                </div>

                <span style="font-weight:700;">
                    EXPENSE AI
                </span>
            </div>

            <div class="menu-group">
                <p>TỔNG QUAN</p>

                <a href="trangchu.aspx">
                    <i data-lucide="home"></i>
                    Trang chủ
                </a>

                <a href="thuchi.aspx">
                    <i data-lucide="wallet"></i>
                    Thu chi
                </a>
            </div>

            <div class="menu-group">
                <p>PHÂN TÍCH</p>

                <a href="goiyai.aspx">
                    <i data-lucide="sparkles"></i>
                    Gợi ý AI
                </a>

                <a class="active" href="lichsu.aspx">
                    <i data-lucide="history"></i>
                    Lịch sử
                </a>
            </div>

            <div class="menu-group">
                <p>CÀI ĐẶT</p>

                <a href="thongke.aspx">
                    <i data-lucide="bar-chart-3"></i>
                    Thống kê
                </a>

                <a href="taikhoan.aspx">
                    <i data-lucide="user"></i>
                    Tài khoản
                </a>
            </div>

        </div>

        <div class="logout">
            <a href="login.aspx">
                <i data-lucide="log-out"></i>
                Đăng xuất
            </a>
        </div>

    </div>

    <div class="main">

        <div class="header">
            <h2>Lịch sử giao dịch</h2>
        </div>

        <div class="filter-box">
            <div class="filter-grid">

                <asp:TextBox
                    ID="txtFrom"
                    runat="server"
                    TextMode="Date">
                </asp:TextBox>

                <asp:TextBox
                    ID="txtTo"
                    runat="server"
                    TextMode="Date">
                </asp:TextBox>

                <asp:DropDownList
                    ID="ddlType"
                    runat="server">

                    <asp:ListItem Value="">Tất cả</asp:ListItem>
                    <asp:ListItem Value="Thu">Thu</asp:ListItem>
                    <asp:ListItem Value="Chi">Chi</asp:ListItem>

                </asp:DropDownList>

                <asp:Button
                    ID="btnFilter"
                    runat="server"
                    Text="Lọc dữ liệu"
                    CssClass="btn-filter"
                    OnClick="FilterData" />

            </div>
        </div>

        <div class="history-card">

            <asp:Repeater ID="rpList" runat="server">

                <ItemTemplate>

                    <div class="history-item">

                        <div class="left-info">

                            <div class="icon-box">
                                <i data-lucide='<%# Eval("Icon") %>'></i>
                            </div>

                            <div>
                                <div class="title">
                                    <%# Eval("MoTa") %>
                                </div>

                                <div class="date">
                                    <%# Eval("TenDanhMuc") %> •
                                    <%# Eval("NgayGiaoDich","{0:dd/MM/yyyy}") %>
                                </div>
                            </div>

                        </div>

                        <div style="display:flex;align-items:center;">

                            <div class='amount <%# Eval("Loai").ToString()=="Thu" ? "income" : "expense" %>'>
                                <%# Eval("Loai").ToString()=="Thu" ? "+" : "-" %>
                                <%# Eval("SoTien","{0:N0}") %>đ
                            </div>

                            <span class="status">
                                <%# Eval("TrangThai") %>
                            </span>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

            <asp:Panel
                ID="pnlEmpty"
                runat="server"
                CssClass="empty"
                Visible="false">
                Không có giao dịch phù hợp.
            </asp:Panel>

        </div>

    </div>

</div>

</form>

<script>
    lucide.createIcons();
</script>

</body>
</html>