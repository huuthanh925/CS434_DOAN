<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="QuanLyChiTieuThongMinh.admin" %>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cổng Quản Trị Hệ Thống - EXPENSE AI</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="crossorigin" />
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />

    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#4cd7f6",
                        "primary-container": "#06b6d4",
                        "on-primary-container": "#00424f",
                        "secondary": "#c0c1ff",
                        "secondary-container": "#3131c0",
                        "tertiary": "#4edea3",
                        "tertiary-container": "#1bbd85",
                        "surface-dim": "#0f131c",
                        "surface-container-lowest": "#0a0e17",
                        "surface-container-low": "#181b25",
                        "surface-container": "#1c1f29",
                        "surface-container-high": "#262a34",
                        "surface-container-highest": "#31353f",
                        "on-surface": "#dfe2ef",
                        "on-surface-variant": "#bcc9cd",
                        "error": "#ffb4ab",
                        "error-container": "#93000a"
                    },
                    fontFamily: {
                        sans: ['Plus Jakarta Sans', 'sans-serif'],
                        mono: ['JetBrains Mono', 'monospace']
                    }
                }
            }
        };
    </script>
    <style>
        ::-webkit-scrollbar { display: none; }
        .section { display: none; }
        .section.active { display: block !important; }
    </style>
</head>
<body class="bg-surface-container-lowest font-sans text-on-surface antialiased">
    <form id="form1" runat="server" autocomplete="off">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
        <asp:UpdatePanel ID="MainUpdatePanel" runat="server">
            <ContentTemplate>
                <!-- Sidebar Navigation -->
                <aside class="fixed left-0 top-0 h-full w-72 bg-surface-container-low/90 backdrop-blur-xl z-50 flex flex-col justify-between shadow-xl border-r border-white/5">
                    <div class="flex flex-col">
                        <div class="h-16 px-6 flex items-center gap-3 border-b border-white/5">
                            <div class="w-9 h-9 rounded-lg bg-primary-container/20 flex items-center justify-center text-primary">
                                <span class="material-symbols-outlined text-[22px]">auto_awesome</span>
                            </div>
                            <div>
                                <div class="font-bold tracking-tight text-on-surface text-lg">EXPENSE <span class="text-primary">AI</span></div>
                                <div class="font-mono text-[10px] uppercase text-on-surface-variant tracking-wider">Admin Portal</div>
                            </div>
                        </div>

                        <nav class="flex flex-col gap-1.5 px-4 mt-6">
                            <asp:LinkButton ID="btnDash" runat="server" OnClick="ShowDashboard" CssClass="flex items-center gap-3 px-4 py-3 rounded-xl transition-all font-medium text-sm text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface">
                                <span class="material-symbols-outlined text-[20px]">space_dashboard</span>
                                <span>Tổng quan</span>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnUsers" runat="server" OnClick="ShowUsers" CssClass="flex items-center gap-3 px-4 py-3 rounded-xl transition-all font-medium text-sm text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface">
                                <span class="material-symbols-outlined text-[20px]">group</span>
                                <span>Quản lý người dùng</span>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnCategories" runat="server" OnClick="ShowCategories" CssClass="flex items-center gap-3 px-4 py-3 rounded-xl transition-all font-medium text-sm text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface">
                                <span class="material-symbols-outlined text-[20px]">category</span>
                                <span>Quản lý danh mục</span>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnReports" runat="server" OnClick="ShowReports" CssClass="flex items-center gap-3 px-4 py-3 rounded-xl transition-all font-medium text-sm text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface">
                                <span class="material-symbols-outlined text-[20px]">analytics</span>
                                <span>Báo cáo hệ thống</span>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnActivity" runat="server" OnClick="ShowActivity" CssClass="flex items-center gap-3 px-4 py-3 rounded-xl transition-all font-medium text-sm text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface">
                                <span class="material-symbols-outlined text-[20px]">receipt_long</span>
                                <span>Nhật ký hoạt động</span>
                            </asp:LinkButton>
                        </nav>
                    </div>

                    <div class="p-4 border-t border-white/5">
                        <asp:LinkButton ID="btnLogout" runat="server" OnClick="Logout_Click" CssClass="flex items-center gap-3 px-4 py-3 rounded-xl text-error hover:bg-error-container/20 transition-all font-medium text-sm w-full">
                            <span class="material-symbols-outlined text-[20px]">logout</span>
                            <span>Đăng xuất</span>
                        </asp:LinkButton>
                    </div>
                </aside>

                <!-- Top Header & Main Content Area -->
                <div class="pl-72">
                    <header class="fixed top-0 left-72 right-0 h-16 bg-surface-container-lowest/80 backdrop-blur-xl z-40 flex items-center justify-between px-8 border-b border-white/5">
                        <!-- Ô TÌM KIẾM CHỐNG AUTOFILL BẰNG READONLY -->
                        <div class="flex items-center w-96 relative">
                            <span class="material-symbols-outlined absolute left-3 text-on-surface-variant text-[18px]">search</span>
                            <input type="text" id="txtFilterKeyword" readonly onfocus="this.removeAttribute('readonly');" oninput="filterGlobalTables()" placeholder="Tìm kiếm dữ liệu..." class="w-full h-10 pl-10 pr-4 rounded-xl bg-surface-container-low text-on-surface placeholder:text-on-surface-variant/60 text-sm focus:outline-none focus:ring-1 focus:ring-primary transition-all" />
                        </div>

                        <div class="flex items-center gap-6">
                            <div class="hidden md:flex items-center gap-2 px-3 py-1 rounded-full bg-tertiary/10 text-tertiary border border-tertiary/20">
                                <span class="w-2 h-2 rounded-full bg-tertiary animate-pulse"></span>
                                <span class="font-mono text-xs uppercase tracking-wide">Hệ thống hoạt động 99.99%</span>
                            </div>
                            <div class="flex items-center gap-3 pl-3 border-l border-white/10">
                                <div class="text-right hidden sm:block">
                                    <div class="text-sm font-semibold text-on-surface">Xin chào, <asp:Label ID="lblAdminName" runat="server" /></div>
                                    <div class="font-mono text-xs text-primary">Super Admin</div>
                                </div>
                                <div class="w-9 h-9 rounded-full bg-primary flex items-center justify-center text-on-primary-container font-bold">
                                    <span class="material-symbols-outlined text-[20px]">admin_panel_settings</span>
                                </div>
                            </div>
                        </div>
                    </header>

                    <main class="w-full pt-20 px-8 pb-12 min-h-screen">
                        
                        <!-- SECTION 1: DASHBOARD -->
                        <asp:Panel ID="pDashboard" runat="server" CssClass="section">
                            <div class="flex flex-col gap-6">
                                <div>
                                    <h1 class="text-2xl font-bold text-on-surface">Tổng Quan Hệ Thống</h1>
                                    <p class="text-sm text-on-surface-variant">Thống kê chỉ số tài chính và các hoạt động thực hiện gần đây</p>
                                </div>

                                <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">
                                    <div class="rounded-2xl bg-surface-container-low p-5 border border-white/5 flex flex-col justify-between">
                                        <div class="flex justify-between items-start">
                                            <span class="text-sm text-on-surface-variant">Tổng người dùng</span>
                                            <span class="material-symbols-outlined text-primary p-2 bg-primary/10 rounded-xl">group</span>
                                        </div>
                                        <div class="text-3xl font-bold text-on-surface mt-4"><asp:Label ID="lblTotalUsers" runat="server"/></div>
                                    </div>
                                    <div class="rounded-2xl bg-surface-container-low p-5 border border-white/5 flex flex-col justify-between">
                                        <div class="flex justify-between items-start">
                                            <span class="text-sm text-on-surface-variant">Tổng giao dịch</span>
                                            <span class="material-symbols-outlined text-secondary p-2 bg-secondary/10 rounded-xl">receipt_long</span>
                                        </div>
                                        <div class="text-3xl font-bold text-on-surface mt-4"><asp:Label ID="lblTotalTransactions" runat="server"/></div>
                                    </div>
                                    <div class="rounded-2xl bg-surface-container-low p-5 border border-white/5 flex flex-col justify-between">
                                        <div class="flex justify-between items-start">
                                            <span class="text-sm text-on-surface-variant">Tổng thu hệ thống</span>
                                            <span class="material-symbols-outlined text-tertiary p-2 bg-tertiary/10 rounded-xl">trending_up</span>
                                        </div>
                                        <div class="text-2xl font-bold text-tertiary mt-4"><asp:Label ID="lblTotalIncome" runat="server"/></div>
                                    </div>
                                    <div class="rounded-2xl bg-surface-container-low p-5 border border-white/5 flex flex-col justify-between">
                                        <div class="flex justify-between items-start">
                                            <span class="text-sm text-on-surface-variant">Tổng chi hệ thống</span>
                                            <span class="material-symbols-outlined text-error p-2 bg-error/10 rounded-xl">payments</span>
                                        </div>
                                        <div class="text-2xl font-bold text-error mt-4"><asp:Label ID="lblTotalExpense" runat="server"/></div>
                                    </div>
                                </div>

                                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 flex flex-col gap-4">
                                        <h3 class="text-lg font-bold text-on-surface">Người dùng mới đăng ký</h3>
                                        <asp:Repeater ID="rpNewUsers" runat="server">
                                            <HeaderTemplate>
                                                <table class="w-full text-left text-sm searchable-table">
                                                    <thead>
                                                        <tr class="text-on-surface-variant font-mono text-xs uppercase border-b border-white/5">
                                                            <th class="pb-3">Họ tên</th>
                                                            <th class="pb-3">Email</th>
                                                            <th class="pb-3">Vai trò</th>
                                                            <th class="pb-3 text-right">Ngày tạo</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="divide-y divide-white/5">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr class="hover:bg-surface-container/40">
                                                    <td class="py-3 font-semibold text-on-surface"><%# Eval("HoTen") %></td>
                                                    <td class="py-3 text-on-surface-variant font-mono text-xs"><%# Eval("Email") %></td>
                                                    <td class="py-3"><span class="px-2 py-0.5 rounded-full text-xs font-mono bg-secondary/10 text-secondary"><%# Eval("VaiTro") %></span></td>
                                                    <td class="py-3 text-right text-on-surface-variant font-mono text-xs"><%# Eval("NgayTao","{0:dd/MM/yyyy}") %></td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                    </tbody>
                                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </div>

                                    <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 flex flex-col gap-4">
                                        <h3 class="text-lg font-bold text-on-surface">Giao dịch gần đây</h3>
                                        <asp:Repeater ID="rpRecentTransactions" runat="server">
                                            <HeaderTemplate>
                                                <table class="w-full text-left text-sm searchable-table">
                                                    <thead>
                                                        <tr class="text-on-surface-variant font-mono text-xs uppercase border-b border-white/5">
                                                            <th class="pb-3">Mô tả</th>
                                                            <th class="pb-3">Loại</th>
                                                            <th class="pb-3 text-right">Số tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="divide-y divide-white/5">
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr class="hover:bg-surface-container/40">
                                                    <td class="py-3 font-medium text-on-surface"><%# Eval("MoTa") %></td>
                                                    <td class="py-3"><span class='<%# Eval("Loai").ToString() == "Thu" ? "text-tertiary bg-tertiary/10" : "text-error bg-error/10" %> px-2 py-0.5 rounded text-xs font-mono uppercase'><%# Eval("Loai") %></span></td>
                                                    <td class="py-3 text-right font-mono font-bold text-on-surface"><%# Eval("SoTien","{0:N0}") %>đ</td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                    </tbody>
                                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- SECTION 2: USERS MANAGEMENT -->
                        <asp:Panel ID="pUsers" runat="server" CssClass="section">
                            <div class="flex flex-col gap-6">
                                <div>
                                    <h1 class="text-2xl font-bold text-on-surface">Quản Lý Người Dùng & Phân Quyền</h1>
                                    <p class="text-sm text-on-surface-variant">Cập nhật thông tin chi tiết, cấp quyền và quản lý trạng thái truy cập</p>
                                </div>

                                <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 flex flex-col gap-4">
                                    <h3 class="text-md font-bold text-primary flex items-center gap-2">
                                        <span class="material-symbols-outlined">manage_accounts</span> Cấu hình tài khoản
                                    </h3>
                                    <asp:HiddenField ID="hdUserID" runat="server"/>
                                    
                                    <div class="grid grid-cols-1 md:grid-cols-3 xl:grid-cols-5 gap-3">
                                        <asp:TextBox ID="txtUserName" runat="server" placeholder="Tên đăng nhập" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                        <asp:TextBox ID="txtFullName" runat="server" placeholder="Họ tên" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Email" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                        <asp:TextBox ID="txtPhone" runat="server" placeholder="Số điện thoại" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                        <asp:TextBox ID="txtPassword" runat="server" placeholder="Mật khẩu" TextMode="Password" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                    </div>

                                    <div class="grid grid-cols-1 md:grid-cols-4 gap-3">
                                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none">
                                            <asp:ListItem Value="User">Quyền: User</asp:ListItem>
                                            <asp:ListItem Value="Admin">Quyền: Admin</asp:ListItem>
                                        </asp:DropDownList>

                                        <asp:DropDownList ID="ddlUserStatus" runat="server" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none">
                                            <asp:ListItem Value="HoatDong">Trạng thái: Hoạt động</asp:ListItem>
                                            <asp:ListItem Value="Khoa">Trạng thái: Khóa</asp:ListItem>
                                        </asp:DropDownList>

                                        <asp:Button ID="btnSaveUser" runat="server" Text="Lưu thay đổi" OnClick="SaveUser_Click" CssClass="h-11 rounded-xl bg-primary text-on-primary-container font-bold text-sm hover:brightness-110 cursor-pointer"/>
                                        <asp:Button ID="btnClearUser" runat="server" Text="Làm mới" OnClick="ClearUser_Click" CssClass="h-11 rounded-xl bg-surface-container-highest text-on-surface font-medium text-sm hover:bg-surface-bright cursor-pointer"/>
                                    </div>
                                </div>

                                <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 overflow-x-auto">
                                    <asp:Repeater ID="rpUsers" runat="server">
                                        <HeaderTemplate>
                                            <table class="w-full text-left text-sm searchable-table">
                                                <thead>
                                                    <tr class="text-on-surface-variant font-mono text-xs uppercase border-b border-white/5">
                                                        <th class="pb-3">ID</th>
                                                        <th class="pb-3">Họ tên</th>
                                                        <th class="pb-3">Email</th>
                                                        <th class="pb-3">Vai trò</th>
                                                        <th class="pb-3">Trạng thái</th>
                                                        <th class="pb-3 text-right">Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="divide-y divide-white/5">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="hover:bg-surface-container/40">
                                                <td class="py-3.5 font-mono text-primary font-bold">#<%# Eval("MaND") %></td>
                                                <td class="py-3.5 font-semibold text-on-surface"><%# Eval("HoTen") %></td>
                                                <td class="py-3.5 text-on-surface-variant font-mono text-xs"><%# Eval("Email") %></td>
                                                <td class="py-3.5"><span class="px-2.5 py-0.5 rounded-full text-xs font-mono bg-secondary/10 text-secondary border border-secondary/20"><%# Eval("VaiTro") %></span></td>
                                                <td class="py-3.5"><span class='<%# Eval("TrangThai").ToString() == "Khoa" ? "bg-error/10 text-error" : "bg-tertiary/10 text-tertiary" %> px-2.5 py-0.5 rounded-full text-xs font-mono'><%# Eval("TrangThai") %></span></td>
                                                <td class="py-3.5 text-right">
                                                    <div class="flex items-center justify-end gap-2">
                                                        <asp:LinkButton runat="server" CommandArgument='<%# Eval("MaND") %>' OnCommand="EditUser" CssClass="px-3 py-1 rounded-lg bg-tertiary/10 text-tertiary hover:bg-tertiary/20 text-xs font-bold">Sửa</asp:LinkButton>
                                                        <asp:LinkButton runat="server" CommandArgument='<%# Eval("MaND") %>' OnCommand="ToggleUser" CssClass="px-3 py-1 rounded-lg bg-error/10 text-error hover:bg-error/20 text-xs font-bold">Khóa/Mở</asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                                </tbody>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- SECTION 3: CATEGORIES MANAGEMENT -->
                        <asp:Panel ID="pCategories" runat="server" CssClass="section">
                            <div class="flex flex-col gap-6">
                                <div>
                                    <h1 class="text-2xl font-bold text-on-surface">Quản Lý Danh Mục Thu Chi</h1>
                                    <p class="text-sm text-on-surface-variant">Cấu hình hệ thống phân loại danh mục thu nhập và chi tiêu</p>
                                </div>

                                <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 flex flex-col gap-4">
                                    <h3 class="text-md font-bold text-primary flex items-center gap-2">
                                        <span class="material-symbols-outlined">category</span> Cấu hình danh mục
                                    </h3>
                                    <asp:HiddenField ID="hdCategoryID" runat="server"/>
                                    
                                    <div class="grid grid-cols-1 md:grid-cols-5 gap-3">
                                        <asp:TextBox ID="txtCategoryName" runat="server" placeholder="Tên danh mục" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                        <asp:DropDownList ID="ddlCategoryType" runat="server" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none">
                                            <asp:ListItem Value="Chi">Loại: Chi</asp:ListItem>
                                            <asp:ListItem Value="Thu">Loại: Thu</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtCategoryIcon" runat="server" placeholder="Material Icon (VD: payments, restaurant)" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                        <asp:TextBox ID="txtCategoryDesc" runat="server" placeholder="Mô tả công dụng" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none focus:ring-1 focus:ring-primary"/>
                                        <asp:DropDownList ID="ddlCategoryStatus" runat="server" CssClass="h-11 px-4 rounded-xl bg-surface-container text-on-surface text-sm outline-none">
                                            <asp:ListItem Value="HoatDong">Trạng thái: Hoạt động</asp:ListItem>
                                            <asp:ListItem Value="An">Trạng thái: Ẩn</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>

                                    <div class="flex justify-end gap-3">
                                        <asp:Button ID="btnSaveCategory" runat="server" Text="Lưu danh mục" OnClick="SaveCategory_Click" CssClass="px-6 h-11 rounded-xl bg-primary text-on-primary-container font-bold text-sm hover:brightness-110 cursor-pointer"/>
                                    </div>
                                </div>

                                <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 overflow-x-auto">
                                    <asp:Repeater ID="rpCategories" runat="server">
                                        <HeaderTemplate>
                                            <table class="w-full text-left text-sm searchable-table">
                                                <thead>
                                                    <tr class="text-on-surface-variant font-mono text-xs uppercase border-b border-white/5">
                                                        <th class="pb-3">ID</th>
                                                        <th class="pb-3 text-center">Icon</th>
                                                        <th class="pb-3">Tên danh mục</th>
                                                        <th class="pb-3">Loại</th>
                                                        <th class="pb-3">Mô tả</th>
                                                        <th class="pb-3">Trạng thái</th>
                                                        <th class="pb-3 text-right">Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="divide-y divide-white/5">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="hover:bg-surface-container/40">
                                                <td class="py-3.5 font-mono text-primary font-bold">#<%# Eval("MaDM") %></td>
                                                <td class="py-3.5 text-center">
                                                    <span class="material-symbols-outlined text-primary p-2 bg-primary/10 rounded-xl text-lg"><%# NormalizeIcon(Eval("Icon"), Eval("TenDanhMuc")) %></span>
                                                </td>
                                                <td class="py-3.5 font-bold text-on-surface"><%# Eval("TenDanhMuc") %></td>
                                                <td class="py-3.5"><span class="px-2.5 py-0.5 rounded-full text-xs font-mono bg-tertiary/10 text-tertiary"><%# Eval("Loai") %></span></td>
                                                <td class="py-3.5 text-on-surface-variant"><%# Eval("MoTa") %></td>
                                                <td class="py-3.5"><%# Eval("TrangThai") %></td>
                                                <td class="py-3.5 text-right">
                                                    <div class="flex items-center justify-end gap-2">
                                                        <asp:LinkButton runat="server" CommandArgument='<%# Eval("MaDM") %>' OnCommand="EditCategory" CssClass="px-3 py-1 rounded-lg bg-tertiary/10 text-tertiary hover:bg-tertiary/20 text-xs font-bold">Sửa</asp:LinkButton>
                                                        <asp:LinkButton runat="server" CommandArgument='<%# Eval("MaDM") %>' OnCommand="DeleteCategory" CssClass="px-3 py-1 rounded-lg bg-error/10 text-error hover:bg-error/20 text-xs font-bold">Xóa</asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                                </tbody>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- SECTION 4: SYSTEM REPORTS -->
                        <asp:Panel ID="pReports" runat="server" CssClass="section">
                            <div class="flex flex-col gap-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <h1 class="text-2xl font-bold text-on-surface">Báo Cáo & Kiểm Toán Hệ Thống</h1>
                                        <p class="text-sm text-on-surface-variant">Kết xuất và lưu trữ nhật ký đối soát dòng tiền tự động</p>
                                    </div>
                                    <asp:Button ID="btnCreateReport" runat="server" Text="+ Tạo Báo Cáo Ngay" OnClick="CreateReport_Click" CssClass="px-5 h-11 rounded-xl bg-primary text-on-primary-container font-bold text-sm shadow-lg hover:brightness-110 cursor-pointer"/>
                                </div>

                                <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5">
                                    <h3 class="text-md font-bold text-tertiary mb-3 flex items-center gap-2">
                                        <span class="material-symbols-outlined">analytics</span> Kết quả báo cáo vừa tạo
                                    </h3>
                                    <div class="bg-surface-container-lowest p-4 rounded-xl border border-white/5 font-mono text-sm leading-relaxed text-on-surface">
                                        <asp:Literal ID="ltReport" runat="server" Text="Chưa có dữ liệu khởi tạo phiên này." />
                                    </div>
                                </div>

                                <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 overflow-x-auto">
                                    <h3 class="text-lg font-bold text-on-surface mb-4">Lịch sử các kỳ báo cáo</h3>
                                    <asp:Repeater ID="rpReports" runat="server">
                                        <HeaderTemplate>
                                            <table class="w-full text-left text-sm searchable-table">
                                                <thead>
                                                    <tr class="text-on-surface-variant font-mono text-xs uppercase border-b border-white/5">
                                                        <th class="pb-3">Nội dung tóm tắt</th>
                                                        <th class="pb-3 text-center">Người dùng</th>
                                                        <th class="pb-3 text-center">Giao dịch</th>
                                                        <th class="pb-3 text-right">Tổng thu</th>
                                                        <th class="pb-3 text-right">Tổng chi</th>
                                                        <th class="pb-3 text-right">Thời gian</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="divide-y divide-white/5">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="hover:bg-surface-container/40">
                                                <td class="py-3.5 max-w-md font-medium text-on-surface"><%# Eval("NoiDung") %></td>
                                                <td class="py-3.5 text-center font-mono font-bold"><%# Eval("TongNguoiDung") %></td>
                                                <td class="py-3.5 text-center font-mono font-bold"><%# Eval("TongGiaoDich") %></td>
                                                <td class="py-3.5 text-right font-mono text-tertiary font-bold"><%# Eval("TongThu","{0:N0}") %>đ</td>
                                                <td class="py-3.5 text-right font-mono text-error font-bold"><%# Eval("TongChi","{0:N0}") %>đ</td>
                                                <td class="py-3.5 text-right font-mono text-xs text-on-surface-variant"><%# Eval("ThoiGian","{0:dd/MM/yyyy HH:mm}") %></td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                                </tbody>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </asp:Panel>

                        <!-- SECTION 5: ACTIVITY LOGS -->
                        <asp:Panel ID="pActivity" runat="server" CssClass="section">
                            <div class="flex flex-col gap-6">
                                <div>
                                    <h1 class="text-2xl font-bold text-on-surface">Nhật Ký Hoạt Động Quản Trị</h1>
                                    <p class="text-sm text-on-surface-variant">Truy vết toàn bộ thao tác tác động hệ thống bảo mật ISO 27001</p>
                                </div>

                                <div class="rounded-2xl bg-surface-container-low p-6 border border-white/5 overflow-x-auto">
                                    <asp:Repeater ID="rpActivity" runat="server">
                                        <HeaderTemplate>
                                            <table class="w-full text-left text-sm searchable-table">
                                                <thead>
                                                    <tr class="text-on-surface-variant font-mono text-xs uppercase border-b border-white/5">
                                                        <th class="pb-3">Thành viên</th>
                                                        <th class="pb-3">Email liên kết</th>
                                                        <th class="pb-3">Hành động chi tiết</th>
                                                        <th class="pb-3 text-right">Thời điểm ghi nhận</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="divide-y divide-white/5">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr class="hover:bg-surface-container/40">
                                                <td class="py-3.5 font-bold text-on-surface"><%# Eval("HoTen") %></td>
                                                <td class="py-3.5 font-mono text-xs text-on-surface-variant"><%# Eval("Email") %></td>
                                                <td class="py-3.5 text-primary font-medium"><%# Eval("HanhDong") %></td>
                                                <td class="py-3.5 text-right font-mono text-xs text-on-surface-variant"><%# Eval("ThoiGian","{0:dd/MM/yyyy HH:mm}") %></td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                                </tbody>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </asp:Panel>

                    </main>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    <script>
        function filterGlobalTables() {
            var input = document.getElementById("txtFilterKeyword");
            if (!input) return;

            var filter = input.value.toLowerCase().trim();
            var tables = document.querySelectorAll(".searchable-table");

            tables.forEach(function (table) {
                var rows = table.querySelectorAll("tbody tr");
                rows.forEach(function (row) {
                    var text = row.textContent.toLowerCase();
                    if (filter === "" || text.indexOf(filter) > -1) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            });
        }

        function resetFilterBox() {
            var input = document.getElementById("txtFilterKeyword");
            if (input) {
                input.value = "";
                input.setAttribute("readonly", "readonly");
            }
            filterGlobalTables();
        }

        // Đảm bảo chạy reset mỗi lần AJAX UpdatePanel chuyển tab
        if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                resetFilterBox();
            });
        }
    </script>
</body>
</html>