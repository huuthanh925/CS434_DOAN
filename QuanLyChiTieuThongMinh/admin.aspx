<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="QuanLyChiTieuThongMinh.admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://unpkg.com/lucide@latest"></script>

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#eef2ff;color:#1f2937;}
.container{display:flex;height:100vh;}

.sidebar{
    width:260px;background:linear-gradient(180deg,#5e7cff,#4d6ef5);
    color:white;padding:26px 18px;display:flex;flex-direction:column;
    box-shadow:5px 0 25px rgba(0,0,0,.08);
}
.logo{display:flex;align-items:center;gap:12px;margin-bottom:35px;}
.logo-box{width:44px;height:44px;background:rgba(255,255,255,.18);border-radius:14px;display:flex;align-items:center;justify-content:center;}
.logo-box img{width:70%;}
.menu-group{margin-bottom:18px;}
.menu-group p{font-size:11px;opacity:.75;margin-bottom:10px;}
.nav-btn{
    width:100%;display:flex;align-items:center;gap:12px;padding:12px;border-radius:12px;
    color:white;text-decoration:none;margin-bottom:6px;transition:.25s;font-size:14px;
    background:transparent;border:none;cursor:pointer;text-align:left;
}
.nav-btn:hover{background:rgba(255,255,255,.18);transform:translateX(5px);}
.nav-btn.active{background:rgba(255,255,255,.28);}
.logout{
    margin-top:auto;padding:12px;border-radius:12px;background:rgba(255,0,0,.12);
    color:#ffdddd;display:flex;align-items:center;gap:10px;text-decoration:none;border:none;cursor:pointer;
}

.main{flex:1;overflow:auto;padding:26px;}
.header{display:flex;align-items:center;justify-content:space-between;margin-bottom:22px;}
.header h2{color:#4d6ef5;font-size:24px;}
.admin-badge{background:white;padding:12px 18px;border-radius:999px;box-shadow:0 8px 22px rgba(0,0,0,.05);font-size:14px;font-weight:600;}

.cards{display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:20px;}
.card{background:white;border-radius:20px;padding:18px;box-shadow:0 10px 25px rgba(0,0,0,.05);border:1px solid #edf2ff;}
.card h4{color:#6b7280;font-size:13px;margin-bottom:8px;}
.card h2{font-size:22px;}
.green{color:#16a34a;}
.red{color:#ef4444;}
.blue{color:#4d6ef5;}

.box{background:white;border-radius:20px;padding:22px;box-shadow:0 10px 25px rgba(0,0,0,.05);border:1px solid #edf2ff;margin-bottom:20px;}
.box-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px;}
.box h3{color:#374151;font-size:17px;}

.form-grid{display:grid;grid-template-columns:repeat(5,1fr);gap:12px;margin-bottom:18px;}
.form-grid input,.form-grid select{
    height:44px;border:1px solid #e5e7eb;border-radius:12px;padding:0 12px;outline:none;
}
.form-grid input:focus,.form-grid select:focus{
    border-color:#5e7cff;box-shadow:0 0 0 3px rgba(94,124,255,.12);
}
.btn{border:none;border-radius:12px;padding:0 16px;height:44px;cursor:pointer;font-weight:600;}
.btn-primary{background:linear-gradient(135deg,#5e7cff,#6ad4f7);color:white;}
.btn-gray{background:#e5e7eb;color:#374151;}
.btn-danger{background:#ffe7e7;color:#ef4444;}
.btn-green{background:#dcfce7;color:#16a34a;}

.table{width:100%;border-collapse:collapse;}
.table th{text-align:left;font-size:13px;color:#6b7280;padding:12px;border-bottom:1px solid #edf2ff;}
.table td{padding:13px 12px;border-bottom:1px solid #f1f5ff;font-size:14px;}

.status{padding:6px 10px;border-radius:999px;font-size:12px;font-weight:600;}
.status.active{background:#dcfce7;color:#16a34a;}
.status.lock{background:#fee2e2;color:#dc2626;}
.role{padding:6px 10px;border-radius:999px;font-size:12px;background:#eef3ff;color:#4d6ef5;font-weight:600;}
.actions{display:flex;gap:8px;}
.small-btn{border:none;border-radius:10px;padding:8px 10px;cursor:pointer;font-size:12px;font-weight:600;text-decoration:none;}

.section{display:none;}
.section.active{display:block;}
.two-col{display:grid;grid-template-columns:1fr 1fr;gap:18px;}
.report-content{background:#f8faff;border:1px solid #edf2ff;border-radius:16px;padding:16px;line-height:1.7;white-space:pre-wrap;}

.admin-category-icon{
    width:42px;height:42px;border-radius:14px;
    background:linear-gradient(135deg,#eef3ff,#ffffff);
    color:#5e7cff;display:flex;align-items:center;justify-content:center;
    border:1px solid #e6ebff;box-shadow:0 8px 18px rgba(94,124,255,.12);
}
.admin-category-icon i{width:20px;height:20px;}

@media(max-width:1100px){
    .cards{grid-template-columns:1fr 1fr;}
    .form-grid{grid-template-columns:1fr 1fr;}
    .two-col{grid-template-columns:1fr;}
}
@media(max-width:800px){
    .sidebar{display:none;}
    .cards{grid-template-columns:1fr;}
}
</style>
</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <div class="sidebar">
        <div>
            <div class="logo">
                <div class="logo-box"><img src="images/logo.png"/></div>
                <span style="font-weight:700;">EXPENSE AI</span>
            </div>

            <div class="menu-group">
                <p>ADMIN</p>

                <asp:LinkButton ID="btnDash" runat="server" CssClass="nav-btn active" OnClick="ShowDashboard">
                    <i data-lucide="layout-dashboard"></i> Tổng quan
                </asp:LinkButton>

                <asp:LinkButton ID="btnUsers" runat="server" CssClass="nav-btn" OnClick="ShowUsers">
                    <i data-lucide="users"></i> Người dùng
                </asp:LinkButton>

                <asp:LinkButton ID="btnCategories" runat="server" CssClass="nav-btn" OnClick="ShowCategories">
                    <i data-lucide="folder"></i> Danh mục
                </asp:LinkButton>

                <asp:LinkButton ID="btnReports" runat="server" CssClass="nav-btn" OnClick="ShowReports">
                    <i data-lucide="file-text"></i> Báo cáo
                </asp:LinkButton>

                <asp:LinkButton ID="btnActivity" runat="server" CssClass="nav-btn" OnClick="ShowActivity">
                    <i data-lucide="activity"></i> Hoạt động
                </asp:LinkButton>
            </div>
        </div>

        <asp:LinkButton ID="btnLogout" runat="server" CssClass="logout" OnClick="Logout_Click">
            <i data-lucide="log-out"></i> Đăng xuất
        </asp:LinkButton>
    </div>

    <div class="main">

        <div class="header">
            <h2>Admin Dashboard</h2>
            <div class="admin-badge">
                Xin chào, <asp:Label ID="lblAdminName" runat="server" />
            </div>
        </div>

        <asp:Panel ID="pDashboard" runat="server" CssClass="section active">
            <div class="cards">
                <div class="card"><h4>Tổng người dùng</h4><h2 class="blue"><asp:Label ID="lblTotalUsers" runat="server"/></h2></div>
                <div class="card"><h4>Tổng giao dịch</h4><h2><asp:Label ID="lblTotalTransactions" runat="server"/></h2></div>
                <div class="card"><h4>Tổng thu</h4><h2 class="green"><asp:Label ID="lblTotalIncome" runat="server"/></h2></div>
                <div class="card"><h4>Tổng chi</h4><h2 class="red"><asp:Label ID="lblTotalExpense" runat="server"/></h2></div>
            </div>

            <div class="two-col">
                <div class="box">
                    <h3>Người dùng mới</h3>
                    <asp:Repeater ID="rpNewUsers" runat="server">
                        <HeaderTemplate><table class="table"><tr><th>Họ tên</th><th>Email</th><th>Vai trò</th><th>Ngày tạo</th></tr></HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("HoTen") %></td>
                                <td><%# Eval("Email") %></td>
                                <td><span class="role"><%# Eval("VaiTro") %></span></td>
                                <td><%# Eval("NgayTao","{0:dd/MM/yyyy}") %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate></table></FooterTemplate>
                    </asp:Repeater>
                </div>

                <div class="box">
                    <h3>Giao dịch gần đây</h3>
                    <asp:Repeater ID="rpRecentTransactions" runat="server">
                        <HeaderTemplate><table class="table"><tr><th>Mô tả</th><th>Loại</th><th>Số tiền</th></tr></HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("MoTa") %></td>
                                <td><%# Eval("Loai") %></td>
                                <td><%# Eval("SoTien","{0:N0}") %>đ</td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate></table></FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pUsers" runat="server" CssClass="section">
            <div class="box">
                <div class="box-head"><h3>Quản lý người dùng</h3></div>

                <asp:HiddenField ID="hdUserID" runat="server"/>

                <div class="form-grid">
                    <asp:TextBox ID="txtUserName" runat="server" placeholder="Tên đăng nhập"/>
                    <asp:TextBox ID="txtFullName" runat="server" placeholder="Họ tên"/>
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"/>
                    <asp:TextBox ID="txtPhone" runat="server" placeholder="Số điện thoại"/>
                    <asp:TextBox ID="txtPassword" runat="server" placeholder="Mật khẩu"/>

                    <asp:DropDownList ID="ddlRole" runat="server">
                        <asp:ListItem Value="User">User</asp:ListItem>
                        <asp:ListItem Value="Admin">Admin</asp:ListItem>
                    </asp:DropDownList>

                    <asp:DropDownList ID="ddlUserStatus" runat="server">
                        <asp:ListItem Value="HoatDong">Hoạt động</asp:ListItem>
                        <asp:ListItem Value="Khoa">Khóa</asp:ListItem>
                    </asp:DropDownList>

                    <asp:Button ID="btnSaveUser" runat="server" Text="Lưu" CssClass="btn btn-primary" OnClick="SaveUser_Click"/>
                    <asp:Button ID="btnClearUser" runat="server" Text="Làm mới" CssClass="btn btn-gray" OnClick="ClearUser_Click"/>
                </div>

                <asp:Repeater ID="rpUsers" runat="server">
                    <HeaderTemplate><table class="table"><tr><th>ID</th><th>Tên</th><th>Email</th><th>Vai trò</th><th>Trạng thái</th><th>Thao tác</th></tr></HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("MaND") %></td>
                            <td><%# Eval("HoTen") %></td>
                            <td><%# Eval("Email") %></td>
                            <td><span class="role"><%# Eval("VaiTro") %></span></td>
                            <td><span class='status <%# Eval("TrangThai").ToString()=="Khoa" ? "lock" : "active" %>'><%# Eval("TrangThai") %></span></td>
                            <td>
                                <div class="actions">
                                    <asp:LinkButton runat="server" CssClass="small-btn btn-green" CommandArgument='<%# Eval("MaND") %>' OnCommand="EditUser">Sửa</asp:LinkButton>
                                    <asp:LinkButton runat="server" CssClass="small-btn btn-danger" CommandArgument='<%# Eval("MaND") %>' OnCommand="ToggleUser">Khóa/Mở</asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></table></FooterTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

        <asp:Panel ID="pCategories" runat="server" CssClass="section">
            <div class="box">
                <div class="box-head"><h3>Quản lý danh mục</h3></div>

                <asp:HiddenField ID="hdCategoryID" runat="server"/>

                <div class="form-grid">
                    <asp:TextBox ID="txtCategoryName" runat="server" placeholder="Tên danh mục"/>
                    <asp:DropDownList ID="ddlCategoryType" runat="server">
                        <asp:ListItem Value="Chi">Chi</asp:ListItem>
                        <asp:ListItem Value="Thu">Thu</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="txtCategoryIcon" runat="server" placeholder="Icon Lucide: wallet, car..."/>
                    <asp:TextBox ID="txtCategoryDesc" runat="server" placeholder="Mô tả"/>
                    <asp:DropDownList ID="ddlCategoryStatus" runat="server">
                        <asp:ListItem Value="HoatDong">Hoạt động</asp:ListItem>
                        <asp:ListItem Value="An">Ẩn</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnSaveCategory" runat="server" Text="Lưu danh mục" CssClass="btn btn-primary" OnClick="SaveCategory_Click"/>
                </div>

                <asp:Repeater ID="rpCategories" runat="server">
                    <HeaderTemplate><table class="table"><tr><th>ID</th><th>Icon</th><th>Tên</th><th>Loại</th><th>Mô tả</th><th>Trạng thái</th><th>Thao tác</th></tr></HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("MaDM") %></td>
                            <td><div class="admin-category-icon"><i data-lucide='<%# Eval("Icon") %>'></i></div></td>
                            <td><%# Eval("TenDanhMuc") %></td>
                            <td><%# Eval("Loai") %></td>
                            <td><%# Eval("MoTa") %></td>
                            <td><%# Eval("TrangThai") %></td>
                            <td>
                                <div class="actions">
                                    <asp:LinkButton runat="server" CssClass="small-btn btn-green" CommandArgument='<%# Eval("MaDM") %>' OnCommand="EditCategory">Sửa</asp:LinkButton>
                                    <asp:LinkButton runat="server" CssClass="small-btn btn-danger" CommandArgument='<%# Eval("MaDM") %>' OnCommand="DeleteCategory">Xóa</asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></table></FooterTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

        <asp:Panel ID="pReports" runat="server" CssClass="section">
            <div class="box">
                <div class="box-head">
                    <h3>Hỗ trợ báo cáo</h3>
                    <asp:Button ID="btnCreateReport" runat="server" Text="Tạo báo cáo" CssClass="btn btn-primary" OnClick="CreateReport_Click"/>
                </div>
                <div class="report-content"><asp:Literal ID="ltReport" runat="server"/></div>
            </div>

            <div class="box">
                <h3>Lịch sử báo cáo</h3>
                <asp:Repeater ID="rpReports" runat="server">
                    <HeaderTemplate><table class="table"><tr><th>Nội dung</th><th>Người dùng</th><th>Giao dịch</th><th>Tổng thu</th><th>Tổng chi</th><th>Thời gian</th></tr></HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("NoiDung") %></td>
                            <td><%# Eval("TongNguoiDung") %></td>
                            <td><%# Eval("TongGiaoDich") %></td>
                            <td><%# Eval("TongThu","{0:N0}") %>đ</td>
                            <td><%# Eval("TongChi","{0:N0}") %>đ</td>
                            <td><%# Eval("ThoiGian","{0:dd/MM/yyyy HH:mm}") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></table></FooterTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

        <asp:Panel ID="pActivity" runat="server" CssClass="section">
            <div class="box">
                <h3>Theo dõi hoạt động</h3>
                <asp:Repeater ID="rpActivity" runat="server">
                    <HeaderTemplate><table class="table"><tr><th>Người dùng</th><th>Email</th><th>Hành động</th><th>Thời gian</th></tr></HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("HoTen") %></td>
                            <td><%# Eval("Email") %></td>
                            <td><%# Eval("HanhDong") %></td>
                            <td><%# Eval("ThoiGian","{0:dd/MM/yyyy HH:mm}") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></table></FooterTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

    </div>

</div>

</form>

<script>
    lucide.createIcons();
</script>

</body>
</html>