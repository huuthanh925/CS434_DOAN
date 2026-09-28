<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dangky.aspx.cs" Inherits="QuanLyChiTieuThongMinh.dangky" %>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head runat="server">
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Đăng ký tài khoản - EXPENSE AI</title>

    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>

    <script id="tailwind-config">
tailwind.config = {
    darkMode: "class",
    theme: {
        extend: {
            colors: {
                "surface": "#0f131c",
                "on-background": "#dfe2ef",
                "background": "#0f131c",
                "surface-bright": "#353943",
                "error": "#ffb4ab",
                "primary": "#4cd7f6",
                "tertiary": "#4edea3",
                "secondary": "#c0c1ff",
                "outline-variant": "#3d494c",
                "surface-container-high": "#262a34",
                "primary-container": "#06b6d4",
                "on-primary-container": "#00424f",
                "on-surface-variant": "#bcc9cd",
                "surface-container-low": "#181b25",
                "surface-container": "#1c1f29",
                "surface-container-highest": "#31353f",
                "surface-container-lowest": "#0a0e17"
            },
            fontFamily: {
                sans: ["Plus Jakarta Sans", "sans-serif"],
                mono: ["JetBrains Mono", "monospace"]
            }
        }
    }
}
</script>

    <style>
        ::-webkit-scrollbar { display: none; }
    </style>
</head>

<body class="bg-[#0f131c] font-sans !text-slate-100 antialiased min-h-screen flex flex-col justify-between selection:bg-primary-container selection:text-on-primary-container">
<form id="form1" runat="server" class="min-h-screen flex flex-col justify-between w-full">

    <!-- TOP HEADER -->
    <header class="fixed top-0 left-0 w-full z-50 bg-[#0f131c]/80 backdrop-blur-xl border-b border-outline-variant/20">
        <div class="h-16 w-full max-w-[1440px] mx-auto px-8 flex items-center justify-between">
            <a href="dangnhap.aspx" class="flex items-center gap-3">
                <div class="w-8 h-8 rounded-lg bg-surface-container flex items-center justify-center shadow-[0_0_15px_rgba(6,182,212,0.3)]">
                    <span class="material-symbols-outlined text-primary text-[20px]">account_balance_wallet</span>
                </div>
                <div class="flex items-baseline gap-1">
                    <span class="text-base font-bold text-white tracking-tight">EXPENSE</span>
                    <span class="font-mono text-xs text-primary font-bold tracking-widest">AI</span>
                </div>
            </a>
            <nav class="flex items-center gap-6">
                <a href="dangnhap.aspx" class="text-sm font-semibold !text-slate-300 hover:!text-white transition-colors">Đăng nhập</a>
                <a href="dangky.aspx" class="px-3.5 py-1.5 rounded-lg bg-primary-container !text-on-primary-container font-bold text-sm shadow-md shadow-primary/20">Đăng ký</a>
            </nav>
        </div>
    </header>

    <!-- MAIN REGISTRATION AREA -->
    <main class="w-full flex-1 pt-20 bg-[#0f131c]">
        <div class="relative w-full max-w-[1440px] mx-auto px-6 lg:px-12 py-8 overflow-hidden">
            
            <!-- Ambient Aurora Background Glows -->
            <div class="absolute -top-32 -left-20 w-[520px] h-[520px] bg-primary/10 rounded-full blur-[140px] pointer-events-none -z-10"></div>
            <div class="absolute top-1/3 -right-24 w-[480px] h-[480px] bg-secondary/10 rounded-full blur-[160px] pointer-events-none -z-10"></div>

            <!-- Main Split Grid (12 Columns) -->
            <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 items-start">

                <!-- LEFT COLUMN: Quantum Capabilities & VIP Showcase (5 Cols) -->
                <div class="lg:col-span-5 flex flex-col gap-6 relative z-10">
                    
                    <!-- Top Telemetry Badge -->
                    <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-surface-container-high/70 border border-outline-variant/30 backdrop-blur-md self-start">
                        <span class="w-2 h-2 rounded-full bg-tertiary animate-ping"></span>
                        <span class="font-mono text-[11px] text-tertiary tracking-wider uppercase font-semibold">
                            MẠNG LƯỢNG TỬ V4.9 • KHỞI TẠO TÀI KHOẢN MỚI
                        </span>
                    </div>

                    <!-- Headline Statement -->
                    <div class="flex flex-col gap-2">
                        <div class="flex items-baseline gap-2">
                            <h1 class="text-4xl font-extrabold tracking-tight !text-white uppercase">EXPENSE</h1>
                            <span class="text-4xl font-black text-primary drop-shadow-[0_0_24px_rgba(76,215,246,0.55)]">AI</span>
                        </div>
                        <p class="text-lg text-primary font-semibold leading-snug">
                            Khai mở Kỷ nguyên Quản trị Tài chính Siêu việt Cùng Trí tuệ Nhân tạo Độc bản.
                        </p>
                        <p class="text-xs !text-slate-300 leading-relaxed mt-1">
                            Thiết lập danh tính tài chính số hóa đa chiều, tự động hóa kiểm toán dòng tiền cá nhân và doanh nghiệp với mô hình suy luận lượng tử.
                        </p>
                    </div>

                    <!-- Glassmorphic VIP Privilege Card -->
                    <div class="relative rounded-2xl bg-surface-container/70 backdrop-blur-xl p-6 border border-outline-variant/20 shadow-xl overflow-hidden">
                        <div class="flex items-center justify-between pb-3 mb-3 border-b border-outline-variant/15">
                            <div class="flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary text-[22px]">workspace_premium</span>
                                <span class="font-mono text-xs text-white font-semibold uppercase tracking-wide">
                                    Đặc quyền Hội viên Mới
                                </span>
                            </div>
                            <span class="px-2 py-0.5 rounded-full bg-primary/10 text-primary font-mono text-[10px] font-bold">
                                PREMIUM ACCESS
                            </span>
                        </div>

                        <ul class="flex flex-col gap-4">
                            <li class="flex items-start gap-3">
                                <div class="w-6 h-6 rounded-lg bg-surface-container-highest flex items-center justify-center shrink-0 mt-0.5 text-tertiary">
                                    <span class="material-symbols-outlined text-[16px]">check_circle</span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-xs font-semibold !text-white">Trải nghiệm Elite VIP Member</span>
                                    <span class="text-[11px] !text-slate-400">Kích hoạt trọn bộ Neural Co-pilot v4.9 tự động phân tích hành vi chi tiêu.</span>
                                </div>
                            </li>
                            <li class="flex items-start gap-3">
                                <div class="w-6 h-6 rounded-lg bg-surface-container-highest flex items-center justify-center shrink-0 mt-0.5 text-tertiary">
                                    <span class="material-symbols-outlined text-[16px]">hub</span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-xs font-semibold !text-white">Đồng bộ Open Banking 256-bit Enclave</span>
                                    <span class="text-[11px] !text-slate-400">Tích hợp tức thì với các định chế tài chính nội địa và toàn cầu.</span>
                                </div>
                            </li>
                            <li class="flex items-start gap-3">
                                <div class="w-6 h-6 rounded-lg bg-surface-container-highest flex items-center justify-center shrink-0 mt-0.5 text-tertiary">
                                    <span class="material-symbols-outlined text-[16px]">document_scanner</span>
                                </div>
                                <div class="flex flex-col">
                                    <span class="text-xs font-semibold !text-white">Hạn mức AI vô hạn &amp; OCR siêu tốc</span>
                                    <span class="text-[11px] !text-slate-400">Quét bóc tách hóa đơn, chứng từ PDF đa trang dưới 0.35 giây.</span>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <!-- Security Badge Grid -->
                    <div class="grid grid-cols-4 gap-2">
                        <div class="p-2 rounded-xl bg-surface-container/60 border border-outline-variant/10 text-center flex flex-col items-center">
                            <span class="material-symbols-outlined text-slate-400 text-[18px]">gavel</span>
                            <span class="font-mono text-[10px] !text-slate-200 mt-1 font-semibold">ISO 27001</span>
                        </div>
                        <div class="p-2 rounded-xl bg-surface-container/60 border border-outline-variant/10 text-center flex flex-col items-center">
                            <span class="material-symbols-outlined text-primary text-[18px]">key</span>
                            <span class="font-mono text-[10px] !text-slate-200 mt-1 font-semibold">Mã Hóa Lượng Tử</span>
                        </div>
                        <div class="p-2 rounded-xl bg-surface-container/60 border border-outline-variant/10 text-center flex flex-col items-center">
                            <span class="material-symbols-outlined text-tertiary text-[18px]">security</span>
                            <span class="font-mono text-[10px] !text-slate-200 mt-1 font-semibold">Zero-Knowledge</span>
                        </div>
                        <div class="p-2 rounded-xl bg-surface-container/60 border border-outline-variant/10 text-center flex flex-col items-center">
                            <span class="material-symbols-outlined text-secondary text-[18px]">support_agent</span>
                            <span class="font-mono text-[10px] !text-slate-200 mt-1 font-semibold">Hỗ Trợ 24/7 VIP</span>
                        </div>
                    </div>

                </div>

                <!-- RIGHT COLUMN: Registration Form Deck (7 Cols) -->
                <div class="lg:col-span-7 relative z-10">
                    <div class="relative rounded-2xl bg-surface-container-low/90 backdrop-blur-2xl p-6 sm:p-8 border border-outline-variant/20 shadow-2xl overflow-hidden">
                        
                        <div class="flex items-start justify-between mb-6">
                            <div>
                                <div class="flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary text-[24px]">person_add</span>
                                    <h2 class="text-xl font-bold !text-white">Đăng ký tài khoản mới</h2>
                                </div>
                                <p class="text-xs !text-slate-400 mt-1">
                                    Bắt đầu hành trình tối ưu hóa dòng tiền thông minh chỉ trong 60 giây.
                                </p>
                            </div>
                            <div class="w-10 h-10 rounded-xl bg-surface-container-high flex items-center justify-center shrink-0 border border-outline-variant/20">
                                <span class="material-symbols-outlined text-primary text-[22px]">fingerprint</span>
                            </div>
                        </div>

                        <!-- Registration Form Controls -->
                        <div class="flex flex-col gap-4">
                            
                            <!-- Email Input -->
                            <div class="flex flex-col gap-1">
                                <label class="font-mono text-[10px] !text-slate-300 uppercase font-semibold">Địa chỉ Email</label>
                                <div class="relative flex items-center">
                                    <span class="material-symbols-outlined text-slate-400 text-[18px] absolute left-3 pointer-events-none">mail</span>
                                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email" CssClass="w-full h-11 pl-10 pr-4 rounded-xl bg-[#1c1f29] !text-white font-sans text-sm border border-outline-variant/30 focus:border-primary focus:outline-none transition-all placeholder:!text-slate-500" />
                                </div>
                            </div>

                            <!-- Password Input -->
                            <div class="flex flex-col gap-1">
                                <label class="font-mono text-[10px] !text-slate-300 uppercase font-semibold">Mật khẩu</label>
                                <div class="relative flex items-center">
                                    <span class="material-symbols-outlined text-slate-400 text-[18px] absolute left-3 pointer-events-none">lock</span>
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password" CssClass="w-full h-11 pl-10 pr-4 rounded-xl bg-[#1c1f29] !text-white font-sans text-sm border border-outline-variant/30 focus:border-primary focus:outline-none transition-all placeholder:!text-slate-500" />
                                </div>
                            </div>

                            <!-- Confirm Password Input -->
                            <div class="flex flex-col gap-1">
                                <label class="font-mono text-[10px] !text-slate-300 uppercase font-semibold">Xác nhận Mật khẩu</label>
                                <div class="relative flex items-center">
                                    <span class="material-symbols-outlined text-slate-400 text-[18px] absolute left-3 pointer-events-none">lock_reset</span>
                                    <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" placeholder="Confirm password" CssClass="w-full h-11 pl-10 pr-4 rounded-xl bg-[#1c1f29] !text-white font-sans text-sm border border-outline-variant/30 focus:border-primary focus:outline-none transition-all placeholder:!text-slate-500" />
                                </div>
                            </div>

                            <!-- Terms & Conditions Disclaimer -->
                            <div class="flex items-start gap-2 pt-1">
                                <span class="material-symbols-outlined text-tertiary text-[18px] shrink-0 mt-0.5">verified</span>
                                <p class="text-xs !text-slate-400">
                                    Bằng việc bấm đăng ký, bạn đồng ý với <a href="#" class="text-primary hover:underline">Điều khoản dịch vụ</a> và <a href="#" class="text-primary hover:underline">Chính sách bảo mật</a> của EXPENSE AI.
                                </p>
                            </div>

                            <!-- ASP.NET Register Button -->
                            <asp:Button ID="btnRegister" runat="server" Text="Đăng ký tài khoản" CssClass="w-full h-12 mt-2 rounded-xl bg-primary-container !text-on-primary-container font-bold text-sm hover:brightness-110 transition-all cursor-pointer shadow-lg shadow-primary/20" OnClick="btnRegister_Click" />

                            <!-- Separator -->
                            <div class="relative flex items-center justify-center my-2">
                                <div class="w-full h-px bg-outline-variant/20"></div>
                                <span class="absolute bg-[#181b25] px-3 font-mono text-[10px] !text-slate-400 uppercase">Đã có tài khoản?</span>
                            </div>

                            <!-- Login Redirect Link -->
                            <div class="text-center">
                                <asp:LinkButton ID="lnkLogin" runat="server" CssClass="w-full inline-block py-2.5 rounded-xl bg-[#1c1f29] hover:bg-[#262a34] !text-white text-xs font-semibold border border-outline-variant/30 transition-all text-center cursor-pointer" OnClick="lnkLogin_Click">
                                    Đăng nhập ngay
                                </asp:LinkButton>
                            </div>

                        </div>

                    </div>
                </div>

            </div>

        </div>
    </main>

    <!-- FOOTER -->
    <footer class="w-full bg-surface-container-lowest py-4 border-t border-outline-variant/15">
        <div class="w-full max-w-[1440px] mx-auto px-8 flex flex-col sm:flex-row items-center justify-between gap-3 text-xs !text-slate-400 font-mono">
            <span>© 2026 EXPENSE AI CORPORATION. ALL RIGHTS RESERVED.</span>
            <div class="flex items-center gap-2 text-tertiary">
                <span class="w-2 h-2 rounded-full bg-tertiary animate-pulse"></span>
                <span>Node Lượng Tử: Operational</span>
            </div>
        </div>
    </footer>

</form>
</body>
</html>