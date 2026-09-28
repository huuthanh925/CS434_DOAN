<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thuchi.aspx.cs" Inherits="QuanLyChiTieuThongMinh.thuchi" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thu Chi</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
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
    overflow:hidden;
    color:#1f2937;
}

.container{
    display:flex;
    height:100vh;
}

/* SIDEBAR */
.sidebar{
    width:260px;
    background:linear-gradient(180deg,#5e7cff,#4d6ef5);
    color:white;
    padding:25px 20px;
    display:flex;
    flex-direction:column;
    box-shadow:5px 0 30px rgba(0,0,0,.08);
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
    border-radius:14px;
    background:rgba(255,255,255,.15);
    display:flex;
    align-items:center;
    justify-content:center;
}

.logo-box img{
    width:70%;
}

.menu-group{
    margin-bottom:24px;
}

.menu-group p{
    font-size:11px;
    opacity:.7;
    margin-bottom:10px;
    letter-spacing:.5px;
}

.menu-group a{
    display:flex;
    align-items:center;
    gap:12px;
    color:white;
    text-decoration:none;
    padding:13px 14px;
    border-radius:14px;
    margin-bottom:8px;
    transition:.25s;
    font-size:14px;
    font-weight:500;
}

.menu-group a:hover{
    background:rgba(255,255,255,.14);
    transform:translateX(4px);
}

.menu-group a.active{
    background:rgba(255,255,255,.18);
    box-shadow:inset 0 0 0 1px rgba(255,255,255,.08);
}

.logout{
    margin-top:auto;
}

.logout a{
    display:flex;
    gap:10px;
    align-items:center;
    text-decoration:none;
    color:#ffdede;
    padding:14px;
    border-radius:14px;
    background:rgba(255,255,255,.1);
    transition:.25s;
}

.logout a:hover{
    background:rgba(255,255,255,.18);
}

/* MAIN */
.main{
    flex:1;
    padding:28px;
    overflow:auto;
}

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.header h2{
    color:#4d6ef5;
    font-size:28px;
    font-weight:700;
}

/* BOX */
.box{
    background:white;
    border-radius:24px;
    padding:24px;
    margin-bottom:22px;
    box-shadow:0 10px 35px rgba(0,0,0,.06);
    border:1px solid rgba(0,0,0,.03);
}

.box h3{
    font-size:18px;
    margin-bottom:20px;
    color:#1f2937;
}

/* FORM */
.form-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(160px,1fr));
    gap:16px;
    align-items:center;
}

.form-grid input,
.form-grid select{
    width:100%;
    height:54px;
    border-radius:16px;
    border:1px solid #e5eaf7;
    padding:0 16px;
    outline:none;
    background:#f9fbff;
    transition:.25s;
    font-size:14px;
    color:#374151;
}

.form-grid input:focus,
.form-grid select:focus{
    border-color:#5e7cff;
    background:white;
    box-shadow:0 0 0 4px rgba(94,124,255,.12);
}

.category-select{
    font-weight:600;
}

/* BUTTON FIX */
.btn,
.form-grid input[type=submit]{
    width:100%;
    height:54px !important;
    border:none !important;
    border-radius:16px !important;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7) !important;
    color:white !important;
    font-weight:700 !important;
    cursor:pointer;
    transition:.25s;
    box-shadow:0 10px 25px rgba(94,124,255,.22);
}

.btn:hover,
.form-grid input[type=submit]:hover{
    transform:translateY(-2px);
    box-shadow:0 14px 30px rgba(94,124,255,.28);
}

.btn-cancel,
.form-grid input.btn-cancel[type=submit]{
    background:#eef1f7 !important;
    color:#374151 !important;
    box-shadow:none !important;
}

.btn-cancel:hover,
.form-grid input.btn-cancel[type=submit]:hover{
    background:#e5e7eb !important;
    box-shadow:none !important;
}

/* ITEM */
.item{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px;
    border-radius:22px;
    border:1px solid #edf1fa;
    margin-bottom:15px;
    transition:.25s;
    background:white;
}

.item:hover{
    transform:translateY(-3px);
    box-shadow:0 12px 25px rgba(0,0,0,.05);
}

.item-left{
    display:flex;
    align-items:center;
    gap:15px;
}

.category-icon{
    width:54px;
    height:54px;
    min-width:54px;
    border-radius:18px;
    background:linear-gradient(135deg,#eef3ff,#ffffff);
    display:flex;
    align-items:center;
    justify-content:center;
    color:#5e7cff;
    border:1px solid #e5ebff;
    box-shadow:0 8px 18px rgba(94,124,255,.12);
    position:relative;
    overflow:hidden;
}

.category-icon:after{
    content:"";
    position:absolute;
    inset:0;
    background:linear-gradient(135deg,rgba(255,255,255,.45),transparent);
}

.category-icon i{
    width:24px;
    height:24px;
    position:relative;
    z-index:1;
}

.item-info b{
    font-size:15px;
    color:#111827;
}

.item-info small{
    color:#7b8190;
    font-size:12px;
}

.category-badge{
    display:inline-flex;
    align-items:center;
    gap:6px;
    padding:5px 10px;
    border-radius:999px;
    background:#eef3ff;
    color:#4d6ef5;
    font-size:11px;
    font-weight:700;
    margin-top:6px;
}

.income{
    color:#16a34a;
    font-weight:700;
    font-size:16px;
}

.expense{
    color:#ef4444;
    font-weight:700;
    font-size:16px;
}

/* ACTIONS */
.actions{
    display:flex;
    gap:10px;
}

.action-btn{
    width:42px;
    height:42px;
    border:none;
    border-radius:14px;
    cursor:pointer;
    display:flex;
    align-items:center;
    justify-content:center;
    transition:.25s;
    text-decoration:none;
}

.edit-btn{
    background:#eef2ff;
    color:#5e7cff;
}

.edit-btn:hover{
    background:#dfe7ff;
}

.delete-btn{
    background:#ffecec;
    color:#ef4444;
}

.delete-btn:hover{
    background:#ffdede;
}

.empty-box{
    padding:30px;
    border-radius:18px;
    background:#f8faff;
    border:1px dashed #dbe4ff;
    color:#6b7280;
    text-align:center;
}

/* MOBILE */
@media(max-width:900px){
    .sidebar{
        display:none;
    }

    .main{
        padding:18px;
    }

    .item{
        flex-direction:column;
        align-items:flex-start;
        gap:16px;
    }
}
</style>
</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <!-- SIDEBAR -->
    <div class="sidebar">

        <div>

            <div class="logo">
                <div class="logo-box">
                    <img src="images/logo.png"/>
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

                <a class="active" href="thuchi.aspx">
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

                <a href="lichsu.aspx">
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

    <!-- MAIN -->
    <div class="main">

        <div class="header">
            <h2>Quản lý Thu Chi</h2>
        </div>

        <div class="box">

            <h3>Thêm / Sửa giao dịch</h3>

            <asp:HiddenField ID="hdID" runat="server"/>

            <div class="form-grid">

                <asp:DropDownList
                    ID="ddlType"
                    runat="server"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlType_SelectedIndexChanged">

                    <asp:ListItem Value="Thu">Thu</asp:ListItem>
                    <asp:ListItem Value="Chi">Chi</asp:ListItem>

                </asp:DropDownList>

                <asp:DropDownList
                    ID="ddlDanhMuc"
                    runat="server"
                    CssClass="category-select">
                </asp:DropDownList>

                <asp:TextBox
                    ID="txtAmount"
                    runat="server"
                    placeholder="Nhập số tiền">
                </asp:TextBox>

                <asp:TextBox
                    ID="txtDesc"
                    runat="server"
                    placeholder="Mô tả giao dịch">
                </asp:TextBox>

                <asp:TextBox
                    ID="txtDate"
                    runat="server"
                    TextMode="Date">
                </asp:TextBox>

                <asp:Button
                    ID="btnSave"
                    runat="server"
                    Text="Lưu giao dịch"
                    CssClass="btn"
                    OnClick="btnSave_Click"/>

                <asp:Button
                    ID="btnCancel"
                    runat="server"
                    Text="Làm mới"
                    CssClass="btn btn-cancel"
                    OnClick="btnCancel_Click"/>

            </div>

        </div>

        <div class="box">

            <h3>Danh sách giao dịch</h3>

            <asp:Repeater ID="rpList" runat="server">

                <ItemTemplate>

                    <div class="item">

                        <div class="item-left">

                            <div class="category-icon">
                                <i data-lucide='<%# Eval("Icon") %>'></i>
                            </div>

                            <div class="item-info">

                                <b><%# Eval("MoTa") %></b><br/>

                                <small>
                                    <%# Eval("NgayGiaoDich","{0:dd/MM/yyyy}") %>
                                </small>

                                <br/>

                                <span class="category-badge">
                                    <%# Eval("TenDanhMuc") %>
                                </span>

                            </div>

                        </div>

                        <div style="display:flex;align-items:center;gap:16px;">

                            <span class='<%# Eval("Loai").ToString()=="Thu" ? "income" : "expense" %>'>
                                <%# Eval("Loai").ToString()=="Thu" ? "+" : "-" %>
                                <%# Eval("SoTien","{0:N0}") %>đ
                            </span>

                            <div class="actions">

                                <asp:LinkButton runat="server"
                                    CssClass="action-btn edit-btn"
                                    CommandArgument='<%# Eval("MaGD") %>'
                                    OnCommand="EditItem">

                                    <i data-lucide="pencil"></i>

                                </asp:LinkButton>

                                <asp:LinkButton runat="server"
                                    CssClass="action-btn delete-btn"
                                    CommandArgument='<%# Eval("MaGD") %>'
                                    OnCommand="DeleteItem"
                                    OnClientClick="return confirm('Xóa giao dịch này?');">

                                    <i data-lucide="trash-2"></i>

                                </asp:LinkButton>

                            </div>

                        </div>

                    </div>

                </ItemTemplate>

            </asp:Repeater>

            <asp:Panel
                ID="pnlEmpty"
                runat="server"
                CssClass="empty-box"
                Visible="false">
                Chưa có giao dịch nào.
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