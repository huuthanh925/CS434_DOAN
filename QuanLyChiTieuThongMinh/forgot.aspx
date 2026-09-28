<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgot.aspx.cs" Inherits="QuanLyChiTieuThongMinh.forgot" %>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head runat="server">
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Khôi phục quyền truy cập - EXPENSE AI</title>

    <!-- Tailwind CSS CDN với plugins forms và container-queries -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script>
tailwind.config = {
    darkMode: 'class',
    theme: {
        extend: {
            colors: {
                obsidian: {
                    950: '#06090e',
                    900: '#0a0e17',
                    850: '#0f141f',
                    800: '#141a27',
                    700: '#1e2638'
                },
                cyanGlow: {
                    DEFAULT: '#06b6d4',
                    bright: '#22d3ee',
                    light: '#67e8f9',
                    dark: '#0891b2',
                    glow: 'rgba(6, 182, 212, 0.35)'
                },
                quantumGreen: {
                    DEFAULT: '#10b981',
                    bright: '#34d399',
                    glow: 'rgba(16, 185, 129, 0.3)'
                }
            },
            fontFamily: {
                mono: ['ui-monospace', 'SFMono-Regular', 'Menlo', 'Monaco', 'Consolas', 'monospace'],
                sans: ['Inter', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'sans-serif']
            },
            boxShadow: {
                'glow-cyan': '0 0 25px -4px rgba(6, 182, 212, 0.45)',
                'glow-cyan-sm': '0 0 15px -3px rgba(6, 182, 212, 0.35)',
                'glass-card': '0 8px 32px 0 rgba(0, 0, 0, 0.65)',
                'inner-glow': 'inset 0 1px 1px 0 rgba(255, 255, 255, 0.08)'
            }
        }
    }
};
</script>

    <!-- Custom CSS Styling -->
    <style data-purpose="background-mesh">
        .bg-grid-pattern {
            background-image: 
                radial-gradient(circle at 50% 0%, rgba(6, 182, 212, 0.12) 0%, transparent 60%),
                radial-gradient(circle at 100% 100%, rgba(16, 185, 129, 0.06) 0%, transparent 50%),
                radial-gradient(rgba(255, 255, 255, 0.03) 1px, transparent 0);
            background-size: 100% 100%, 100% 100%, 32px 32px;
        }
    </style>
    <style data-purpose="glassmorphism-borders">
        .glass-panel {
            background: rgba(15, 20, 31, 0.72);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.07);
        }
        
        .glass-panel-glow {
            background: rgba(15, 20, 31, 0.82);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(6, 182, 212, 0.28);
            box-shadow: 0 12px 40px -10px rgba(0, 0, 0, 0.7), 0 0 20px 0 rgba(6, 182, 212, 0.12);
        }

        .pulse-indicator {
            animation: pulse-glow 2.5s infinite ease-in-out;
        }

        @keyframes pulse-glow {
            0%, 100% { opacity: 0.85; transform: scale(1); }
            50% { opacity: 0.35; transform: scale(0.92); }
        }
    </style>
</head>
<body class="bg-obsidian-950 text-slate-100 font-sans min-h-screen flex flex-col justify-between selection:bg-cyan-500 selection:text-black antialiased bg-grid-pattern overflow-x-hidden">
    <form id="form1" runat="server" autocomplete="off" class="min-h-screen flex flex-col justify-between">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <!-- MainHeader -->
        <header class="w-full border-b border-white/5 bg-obsidian-950/80 backdrop-blur-md sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
                <!-- Brand Logo Container -->
                <div class="flex items-center space-x-3">
                    <div class="w-9 h-9 rounded-lg bg-gradient-to-br from-cyanGlow to-cyan-700 p-0.5 shadow-glow-cyan-sm flex items-center justify-center">
                        <div class="w-full h-full bg-obsidian-900 rounded-[7px] flex items-center justify-center">
                            <svg class="w-5 h-5 text-cyan-400" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path d="M14 10l-2 1m0 0l-2-1m2 1v2.5M20 7l-2 1m2-1l-2-1m2 1v2.5M14 4l-2-1-2 1M4 7l2-1M4 7l2 1M4 7v2.5M12 21l-2-1m2 1l2-1m-2 1v-2.5M6 18l-2-1v-2.5M18 18l2-1v-2.5" stroke-linecap="round" stroke-linejoin="round"></path>
                            </svg>
                        </div>
                    </div>
                    <div class="flex items-baseline space-x-1.5">
                        <span class="text-xl font-bold tracking-tight text-white">EXPENSE</span>
                        <span class="text-xl font-black text-cyan-400 drop-shadow-[0_0_8px_rgba(34,211,238,0.7)]">AI</span>
                    </div>
                </div>

                <!-- Navigation & Security Links -->
                <nav class="flex items-center space-x-4 sm:space-x-6 text-sm">
                    <a class="text-slate-400 hover:text-cyan-300 transition-colors flex items-center gap-1.5 font-medium" href="#">
                        <svg class="w-4 h-4 text-cyan-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-5 0a4 4 0 11-8 0 4 4 0 018 0z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                        </svg>
                        <span class="hidden md:inline">Hỗ trợ bảo mật 24/7</span>
                        <span class="md:hidden">Hỗ trợ</span>
                    </a>
                    <asp:LinkButton ID="lnkHeaderLogin" runat="server" OnClick="lnkLogin_Click" CssClass="px-3.5 py-1.5 rounded-lg border border-slate-700 bg-obsidian-850 hover:border-cyan-500/50 hover:bg-cyan-950/20 text-slate-200 hover:text-white transition-all text-xs sm:text-sm font-medium flex items-center gap-1.5">
                        <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path d="M10 19l-7-7m0 0l7-7m-7 7h18" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                        </svg>
                        Quay lại Đăng nhập
                    </asp:LinkButton>
                </nav>
            </div>
        </header>

        <!-- MainContent -->
        <main class="flex-grow flex items-center justify-center py-8 lg:py-12 px-4 sm:px-6 lg:px-8">
            <div class="max-w-7xl w-full grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-12 items-center">
                
                <!-- LeftColumnSecurityShield -->
                <section class="lg:col-span-6 space-y-6 lg:pr-4" data-purpose="recovery-security-overview">
                    <div class="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-obsidian-850 border border-slate-800 text-xs font-mono uppercase tracking-wider text-cyan-300">
                        <span class="w-2 h-2 rounded-full bg-quantumGreen-bright animate-ping"></span>
                        <span class="font-semibold tracking-wide">Giao thức bảo mật V4.9</span>
                        <span class="text-slate-600">•</span>
                        <span class="text-slate-300 font-medium">Khôi phục quyền truy cập</span>
                    </div>

                    <div class="space-y-3">
                        <h1 class="text-3xl sm:text-4xl xl:text-5xl font-extrabold tracking-tight text-white leading-tight">
                            Khôi phục Mật khẩu &amp; <br class="hidden sm:inline"/>
                            <span class="bg-gradient-to-r from-cyan-300 via-cyan-400 to-teal-300 bg-clip-text text-transparent">Bảo vệ Tài khoản AI</span>
                        </h1>
                        <p class="text-slate-400 text-sm sm:text-base leading-relaxed max-w-xl">
                            Hệ thống nhận diện lượng tử áp dụng phương thức xác minh Zero-Knowledge KYC. Dữ liệu tài chính và danh tính số của bạn luôn được bảo vệ đa lớp độc bản theo tiêu chuẩn ISO/IEC 27001 &amp; SOC2 Type II.
                        </p>
                    </div>

                    <!-- 3-Step Flow Indicator -->
                    <div class="p-5 rounded-2xl glass-panel space-y-4 shadow-glass-card">
                        <div class="flex items-center justify-between border-b border-white/5 pb-3">
                            <span class="text-xs font-mono font-semibold uppercase tracking-wider text-cyan-400 flex items-center gap-2">
                                <svg class="w-4 h-4 text-cyan-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                                </svg>
                                Quy trình khôi phục 3 bước
                            </span>
                            <span class="text-[11px] font-mono text-slate-400 bg-obsidian-950 px-2 py-0.5 rounded border border-slate-800">Cực kỳ an toàn</span>
                        </div>

                        <div class="space-y-3.5">
                            <div class="flex items-start gap-3.5 p-2.5 rounded-xl bg-cyan-950/30 border border-cyan-500/40 transition-all">
                                <div class="w-7 h-7 rounded-lg bg-cyan-500 text-obsidian-950 font-black text-xs flex items-center justify-center shadow-glow-cyan-sm shrink-0">01</div>
                                <div class="space-y-0.5">
                                    <div class="text-xs font-semibold text-cyan-300 flex items-center gap-2">
                                        Xác định định danh tài khoản
                                        <span class="text-[10px] px-1.5 py-0.2 rounded bg-cyan-400/20 text-cyan-200 uppercase font-mono">Đang thực hiện</span>
                                    </div>
                                    <p class="text-xs text-slate-300">Nhập Email hoặc ID hệ thống liên kết với tài khoản bảo mật của bạn.</p>
                                </div>
                            </div>

                            <div class="flex items-start gap-3.5 p-2.5 rounded-xl bg-obsidian-900/50 border border-slate-800/80">
                                <div class="w-7 h-7 rounded-lg bg-obsidian-800 text-slate-400 font-bold text-xs flex items-center justify-center border border-slate-700 shrink-0">02</div>
                                <div class="space-y-0.5">
                                    <div class="text-xs font-semibold text-slate-300">Xác thực OTP Lượng tử (Quantum Token)</div>
                                    <p class="text-xs text-slate-500">Nhận mã xác minh 6 số qua Email mã hóa hoặc Thiết bị FIDO2 Passkey.</p>
                                </div>
                            </div>

                            <div class="flex items-start gap-3.5 p-2.5 rounded-xl bg-obsidian-900/50 border border-slate-800/80">
                                <div class="w-7 h-7 rounded-lg bg-obsidian-800 text-slate-400 font-bold text-xs flex items-center justify-center border border-slate-700 shrink-0">03</div>
                                <div class="space-y-0.5">
                                    <div class="text-xs font-semibold text-slate-300">Thiết lập mật mã Enclave mới</div>
                                    <p class="text-xs text-slate-500">Khởi tạo mật khẩu mới và đồng bộ lại khóa riêng tư phần cứng an toàn.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 sm:grid-cols-4 gap-2.5 text-center text-xs font-mono">
                        <div class="p-2.5 rounded-xl bg-obsidian-900/80 border border-slate-800/80">
                            <div class="text-slate-500 text-[10px] uppercase">Giao thức</div>
                            <div class="font-bold text-slate-200 mt-0.5">TLS 1.3 / E2EE</div>
                        </div>
                        <div class="p-2.5 rounded-xl bg-obsidian-900/80 border border-slate-800/80">
                            <div class="text-slate-500 text-[10px] uppercase">Mã hóa</div>
                            <div class="font-bold text-cyan-400 mt-0.5">256-Bit Enclave</div>
                        </div>
                        <div class="p-2.5 rounded-xl bg-obsidian-900/80 border border-slate-800/80">
                            <div class="text-slate-500 text-[10px] uppercase">Node Định danh</div>
                            <div class="font-bold text-slate-200 mt-0.5">TOKYO-09</div>
                        </div>
                        <div class="p-2.5 rounded-xl bg-obsidian-900/80 border border-slate-800/80">
                            <div class="text-slate-500 text-[10px] uppercase">Nhật ký truy vết</div>
                            <div class="font-bold text-emerald-400 mt-0.5">Zero-Logs</div>
                        </div>
                    </div>
                </section>

                <!-- RightColumnRecoveryCard -->
                <section class="lg:col-span-6 w-full max-w-lg mx-auto lg:max-w-none" data-purpose="recovery-form-container">
                    <asp:UpdatePanel ID="upForgotPassword" runat="server">
                        <ContentTemplate>
                            <div class="p-6 sm:p-8 rounded-3xl glass-panel-glow relative overflow-hidden">
                                <div class="absolute -top-24 -right-24 w-52 h-52 bg-cyan-500/15 rounded-full blur-3xl pointer-events-none"></div>

                                <!-- Card Header -->
                                <div class="flex items-start justify-between mb-6">
                                    <div>
                                        <div class="inline-flex items-center gap-2 mb-2">
                                            <span class="p-2 rounded-xl bg-cyan-500/10 border border-cyan-500/30 text-cyan-400">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path d="M15 7a2 2 0 012 2m4 0a6 6 0 01-7.743 5.743L11 17H9v2H7v2H4a1 1 0 01-1-1v-2.586a1 1 0 01.293-.707l5.964-5.964A6 6 0 1121 9z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                                                </svg>
                                            </span>
                                            <span class="text-xs font-mono uppercase tracking-wider text-cyan-300">Kênh hỗ trợ khẩn cấp</span>
                                        </div>
                                        <h2 class="text-2xl sm:text-3xl font-bold text-white tracking-tight">Khôi phục mật khẩu</h2>
                                        <p class="text-slate-400 text-xs sm:text-sm mt-1">
                                            Nhập địa chỉ email đăng ký với EXPENSE AI để nhận hướng dẫn khôi phục tài khoản.
                                        </p>
                                    </div>
                                    <div class="hidden sm:flex w-10 h-10 rounded-xl bg-obsidian-850 border border-slate-700/80 items-center justify-center text-cyan-400 shrink-0">
                                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                                        </svg>
                                    </div>
                                </div>

                                <!-- Recovery Input Box -->
                                <div class="space-y-5">
                                    <div class="space-y-2">
                                        <div class="flex items-center justify-between">
                                            <label class="text-xs font-mono uppercase tracking-wider text-slate-300 flex items-center gap-1.5" for="txtEmail">
                                                <span>Địa chỉ Email tài khoản</span>
                                            </label>
                                            <button class="text-[11px] font-mono text-cyan-400 hover:text-cyan-300 underline transition-all" onclick="document.getElementById('<%= txtEmail.ClientID %>').value='voduchuy752005@gmail.com'; return false;" type="button">
                                                Tự động điền
                                            </button>
                                        </div>
                                        <div class="relative rounded-xl shadow-sm">
                                            <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-500">
                                                <span class="font-mono text-cyan-400">@</span>
                                            </div>
                                            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="name@domain.com" CssClass="block w-full pl-10 pr-4 py-3 bg-obsidian-900 border border-slate-700/80 rounded-xl text-slate-100 placeholder-slate-500 focus:outline-none focus:ring-2 focus:ring-cyan-400 focus:border-cyan-400 text-sm font-mono transition-colors" />
                                        </div>
                                        <p class="text-[11px] text-slate-400 flex items-center gap-1.5 pt-0.5">
                                            <svg class="w-3.5 h-3.5 text-cyan-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                                            </svg>
                                            Mã xác thực khôi phục sẽ được gửi trực tiếp về email này.
                                        </p>
                                    </div>

                                    <!-- Action Button -->
                                    <asp:Button ID="btnSend" runat="server" Text="Gửi yêu cầu khôi phục" OnClick="btnSend_Click" CssClass="w-full py-3.5 px-6 rounded-xl bg-gradient-to-r from-cyan-400 to-cyan-500 hover:from-cyan-300 hover:to-cyan-400 text-obsidian-950 font-bold text-sm tracking-wide shadow-glow-cyan hover:shadow-glow-cyan transition-all duration-200 cursor-pointer" />

                                    <!-- Security Warning -->
                                    <div class="p-3 rounded-xl bg-amber-500/10 border border-amber-500/20 flex items-start gap-2.5">
                                        <svg class="w-4 h-4 text-amber-400 shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                                        </svg>
                                        <p class="text-[11px] text-amber-200/90 leading-relaxed">
                                            <strong class="font-semibold text-amber-300">Cảnh báo an toàn:</strong> EXPENSE AI không bao giờ yêu cầu bạn cung cấp mật khẩu qua điện thoại hay tin nhắn riêng.
                                        </p>
                                    </div>

                                    <!-- Footer Return Link -->
                                    <div class="text-center pt-2">
                                        <p class="text-xs text-slate-400">
                                            Nhớ mật khẩu của bạn?
                                            <asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click" CssClass="font-semibold text-cyan-400 hover:text-cyan-300 transition-colors ml-1 inline-flex items-center gap-1">
                                                Đăng nhập ngay
                                                <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path d="M9 5l7 7-7 7" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                                                </svg>
                                            </asp:LinkButton>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <!-- Hotline Support -->
                    <div class="mt-4 px-4 flex items-center justify-between text-xs text-slate-500 font-mono">
                        <span class="flex items-center gap-1.5">
                            <span class="w-1.5 h-1.5 rounded-full bg-quantumGreen"></span>
                            Tổng đài hỗ trợ VIP 24/7
                        </span>
                        <a class="text-slate-400 hover:text-cyan-300 transition-colors" href="#">
                            Hotline khẩn cấp: <span class="text-cyan-400 font-bold">1900 8899 AI</span>
                        </a>
                    </div>
                </section>
            </div>
        </main>

        <!-- MainFooter -->
        <footer class="w-full border-t border-white/5 bg-obsidian-950/90 backdrop-blur-md py-4 text-xs font-mono text-slate-400">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col md:flex-row items-center justify-between gap-3">
                <div class="flex items-center gap-2">
                    <span class="w-2 h-2 rounded-full bg-cyan-400"></span>
                    <p class="text-[11px] sm:text-xs">
                        BẢN QUYỀN © 2026 EXPENSE AI CORPORATION. BẢO LƯU MỌI QUYỀN.
                    </p>
                </div>
                <div class="flex flex-wrap items-center justify-center gap-x-5 gap-y-2 text-[11px] sm:text-xs">
                    <a class="hover:text-cyan-300 transition-colors" href="#">Điều khoản dịch vụ</a>
                    <span class="text-slate-700">•</span>
                    <a class="hover:text-cyan-300 transition-colors" href="#">Chính sách bảo mật</a>
                    <span class="text-slate-700">•</span>
                    <a class="hover:text-cyan-300 transition-colors" href="#">Bảo mật ngân hàng</a>
                    <span class="text-slate-700">•</span>
                    <div class="flex items-center gap-1.5 text-emerald-400">
                        <span class="w-2 h-2 rounded-full bg-emerald-400 pulse-indicator"></span>
                        <span>Node Lượng tử: Operational</span>
                    </div>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>