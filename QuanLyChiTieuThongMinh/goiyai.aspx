<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="goiyai.aspx.cs" Inherits="QuanLyChiTieuThongMinh.goiyai" %>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head runat="server">
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>EXPENSE AI - Trợ lý AI Tài chính</title>

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
                "on-primary-fixed": "#001f26",
                "surface-bright": "#353943",
                "error": "#ffb4ab",
                "on-tertiary": "#003824",
                "primary": "#4cd7f6",
                "tertiary": "#4edea3",
                "on-primary-fixed-variant": "#004e5c",
                "secondary-fixed": "#e1e0ff",
                "outline-variant": "#3d494c",
                "surface-container-high": "#262a34",
                "primary-fixed": "#acedff",
                "on-secondary-fixed-variant": "#2f2ebe",
                "on-tertiary-container": "#00452e",
                "on-surface-variant": "#bcc9cd",
                "on-secondary-fixed": "#07006c",
                "on-error": "#690005",
                "on-secondary-container": "#b0b2ff",
                "error-container": "#93000a",
                "tertiary-fixed": "#6ffbbe",
                "secondary-container": "#3131c0",
                "secondary": "#c0c1ff",
                "on-primary-container": "#00424f",
                "outline": "#869397",
                "on-tertiary-fixed-variant": "#005236",
                "surface-variant": "#31353f",
                "primary-fixed-dim": "#4cd7f6",
                "primary-container": "#06b6d4",
                "surface-tint": "#4cd7f6",
                "on-surface": "#dfe2ef",
                "on-tertiary-fixed": "#002113",
                "surface-dim": "#0f131c",
                "secondary-fixed-dim": "#c0c1ff",
                "inverse-surface": "#dfe2ef",
                "tertiary-container": "#1bbd85",
                "inverse-on-surface": "#2c303a",
                "surface-container-lowest": "#0a0e17",
                "surface-container": "#1c1f29",
                "tertiary-fixed-dim": "#4edea3",
                "on-error-container": "#ffdad6",
                "on-primary": "#003640",
                "on-secondary": "#1000a9",
                "inverse-primary": "#00687a",
                "surface-container-highest": "#31353f",
                "surface-container-low": "#181b25"
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
        .msg-row { display: flex; gap: 12px; align-items: flex-end; animation: fadeIn .2s ease; }
        .msg-row.user { justify-content: flex-end; }
        .msg { max-width: 75%; padding: 12px 16px; border-radius: 16px; font-size: 14px; line-height: 1.5; white-space: pre-wrap; }
        .msg.ai { background: #262a34; color: #dfe2ef; border: 1px solid rgba(61,73,76,0.3); border-bottom-left-radius: 4px; }
        .msg.user { background: #06b6d4; color: #001f26; font-weight: 600; border-bottom-right-radius: 4px; }
        .avatar { width: 36px; height: 36px; min-width: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 16px; }
        .chat-sidebar { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        .chat-sidebar.hide { width: 0 !important; min-width: 0 !important; opacity: 0; padding: 0; overflow: hidden; margin: 0; }
        
        .typing { display: flex; gap: 4px; padding: 6px; align-items: center; }
        .typing span { width: 6px; height: 6px; background: #4cd7f6; border-radius: 50%; animation: bounce 1s infinite; }
        .typing span:nth-child(2) { animation-delay: .15s; }
        .typing span:nth-child(3) { animation-delay: .3s; }
        @keyframes bounce { 0%,80%,100% { transform:scale(0); } 40% { transform:scale(1); } }
        @keyframes fadeIn { from { opacity:0; transform:translateY(8px); } to { opacity:1; transform:translateY(0); } }
    </style>
</head>

<body class="bg-background font-sans text-on-surface antialiased selection:bg-primary-container selection:text-on-primary-container">
<form id="form1" runat="server">
<asp:HiddenField ID="hfMessage" runat="server" />

    <!-- SIDEBAR NAVIGATION -->
    <aside class="fixed left-0 top-0 h-full w-64 bg-surface-container-low/90 backdrop-blur-2xl z-50 flex flex-col justify-between py-6 shadow-2xl border-r border-outline-variant/20">
        <div class="flex flex-col gap-6">
            <!-- Brand Logo -->
            <div class="px-6 flex items-center gap-3">
                <div class="w-9 h-9 rounded-lg bg-surface-container-high flex items-center justify-center shadow-[0_0_20px_rgba(6,182,212,0.35)]">
                    <span class="material-symbols-outlined text-primary text-[22px]">token</span>
                </div>
                <div class="flex flex-col">
                    <span class="text-base font-bold tracking-tight text-on-surface">EXPENSE <span class="text-primary">AI</span></span>
                    <span class="font-mono text-[10px] text-on-surface-variant uppercase tracking-widest">Smart Finance OS</span>
                </div>
            </div>

            <!-- Menu Navigation Links -->
            <nav class="flex flex-col gap-1 px-4">
                <a href="trangchu.aspx" class="flex items-center gap-3 px-4 py-2.5 rounded-lg text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface transition-all">
                    <span class="material-symbols-outlined text-[20px]">grid_view</span>
                    <span class="text-sm"><asp:Label ID="lblMenuHome" runat="server" Text="Trang chủ" /></span>
                </a>
                <a href="thuchi.aspx" class="flex items-center gap-3 px-4 py-2.5 rounded-lg text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface transition-all">
                    <span class="material-symbols-outlined text-[20px]">swap_horiz</span>
                    <span class="text-sm"><asp:Label ID="lblMenuTransaction" runat="server" Text="Thu chi" /></span>
                </a>
                <a href="goiyai.aspx" class="flex items-center justify-between px-4 py-2.5 rounded-lg bg-primary-container text-on-primary-container font-semibold transition-all">
                    <div class="flex items-center gap-3">
                        <span class="material-symbols-outlined text-[20px] text-secondary">auto_awesome</span>
                        <span class="text-sm"><asp:Label ID="lblMenuAI" runat="server" Text="Gợi ý AI" /></span>
                    </div>
                    <span class="font-mono text-[10px] px-2 py-0.5 rounded bg-secondary-container text-secondary font-bold">PRO</span>
                </a>
                <a href="lichsu.aspx" class="flex items-center gap-3 px-4 py-2.5 rounded-lg text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface transition-all">
                    <span class="material-symbols-outlined text-[20px]">receipt_long</span>
                    <span class="text-sm"><asp:Label ID="lblMenuHistory" runat="server" Text="Lịch sử" /></span>
                </a>
                <a href="thongke.aspx" class="flex items-center gap-3 px-4 py-2.5 rounded-lg text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface transition-all">
                    <span class="material-symbols-outlined text-[20px]">monitoring</span>
                    <span class="text-sm"><asp:Label ID="lblMenuStats" runat="server" Text="Thống kê" /></span>
                </a>
                <a href="taikhoan.aspx" class="flex items-center gap-3 px-4 py-2.5 rounded-lg text-on-surface-variant hover:bg-surface-container-high hover:text-on-surface transition-all">
                    <span class="material-symbols-outlined text-[20px]">account_balance_wallet</span>
                    <span class="text-sm"><asp:Label ID="lblMenuAccount" runat="server" Text="Tài khoản" /></span>
                </a>
            </nav>
        </div>

        <!-- System Neural Info & Logout Button -->
        <div class="px-4 flex flex-col gap-4">
            <a href="login.aspx" class="w-full flex items-center justify-between px-4 py-2.5 rounded-lg bg-error/10 text-error hover:bg-error/20 transition-all text-sm font-semibold">
                <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined text-[20px]">logout</span>
                    <span><asp:Label ID="lblLogout" runat="server" Text="Đăng xuất" /></span>
                </div>
            </a>
        </div>
    </aside>

    <!-- MAIN WORKSPACE LAYOUT -->
    <div class="pl-64 h-screen flex flex-col overflow-hidden bg-background">
        
        <!-- TOP HEADER BAR -->
        <header class="h-16 bg-surface-container-lowest/80 backdrop-blur-xl border-b border-outline-variant/20 z-40 flex items-center justify-between px-6 shrink-0">
            <div class="flex items-center gap-3">
                <button type="button" onclick="toggleHistory()" class="w-9 h-9 rounded-lg bg-surface-container hover:bg-surface-container-high text-primary flex items-center justify-center transition-colors cursor-pointer">
                    <span class="material-symbols-outlined text-[20px]">side_navigation</span>
                </button>
                <div class="flex items-center gap-2">
                    <span class="material-symbols-outlined text-primary text-[22px]">smart_toy</span>
                    <h2 class="text-base font-bold text-on-surface">
                        <asp:Label ID="lblAITitle" runat="server" Text="Trợ lý AI tài chính" />
                    </h2>
                </div>
            </div>

            <div class="flex items-center gap-3">
                <div class="flex items-center gap-2 px-3 py-1 rounded-full bg-surface-container/70 border border-outline-variant/30">
                    <span class="relative flex h-2 w-2">
                        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-tertiary opacity-75"></span>
                        <span class="relative inline-flex rounded-full h-2 w-2 bg-tertiary"></span>
                    </span>
                    <span class="font-mono text-xs text-tertiary uppercase tracking-wider font-semibold">
                        <asp:Label ID="lblAIOnline" runat="server" Text="AI đang hoạt động" />
                    </span>
                </div>
            </div>
        </header>

        <!-- CHAT WORKSPACE BODY -->
        <div class="flex flex-1 overflow-hidden">
            
            <!-- HISTORY SIDEBAR -->
            <div id="historySidebar" class="chat-sidebar w-80 bg-surface-container-low/90 backdrop-blur-xl border-r border-outline-variant/20 flex flex-col shrink-0">
                <div class="p-4 border-b border-outline-variant/20 flex flex-col gap-3">
                    <div class="flex items-center gap-3">
                        <div class="w-10 h-10 rounded-xl bg-primary-container/20 text-primary flex items-center justify-center shrink-0">
                            <span class="material-symbols-outlined text-[24px]">psychology</span>
                        </div>
                        <div class="flex flex-col">
                            <h3 class="text-sm font-bold text-on-surface">Expense AI</h3>
                            <span class="text-xs text-on-surface-variant">
                                <asp:Label ID="lblAISub" runat="server" Text="AI tài chính cá nhân" />
                            </span>
                        </div>
                    </div>

                    <asp:Button
                        ID="btnNewChat"
                        runat="server"
                        Text="+ Cuộc trò chuyện mới"
                        CssClass="w-full h-11 rounded-xl bg-gradient-to-r from-primary-container to-primary text-on-primary-container font-bold text-xs tracking-wide shadow-md hover:brightness-110 transition-all cursor-pointer"
                        OnClick="btnNewChat_Click" />
                </div>

                <!-- Chat Sessions List -->
                <div class="flex-1 overflow-y-auto p-3 flex flex-col gap-2">
                    <asp:Repeater ID="rpChat" runat="server">
                        <ItemTemplate>
                            <div class='p-3 rounded-xl bg-surface-container/60 border border-outline-variant/15 flex flex-col gap-1.5 <%# Session["MaChat"] != null && Convert.ToInt32(Eval("MaChat")) == Convert.ToInt32(Session["MaChat"]) ? "border-primary bg-surface-container" : "" %>'>
                                <div class="font-semibold text-xs text-on-surface truncate">
                                    <%# Eval("TenChat") %>
                                </div>
                                <div class="font-mono text-[10px] text-on-surface-variant">
                                    <%# Convert.ToDateTime(Eval("NgayTao")).ToString("dd/MM/yyyy HH:mm") %>
                                </div>
                                <div class="flex items-center gap-2 mt-1">
                                    <asp:LinkButton
                                        ID="btnOpen"
                                        runat="server"
                                        CssClass="flex-1 py-1 rounded-lg bg-primary/10 hover:bg-primary/20 text-primary text-[11px] font-semibold text-center transition-colors"
                                        CommandArgument='<%# Eval("MaChat") %>'
                                        OnClick="btnOpen_Click">
                                        <asp:Label ID="lblOpen" runat="server" Text="Mở" />
                                    </asp:LinkButton>

                                    <asp:LinkButton
                                        ID="btnDelete"
                                        runat="server"
                                        CssClass="flex-1 py-1 rounded-lg bg-error/10 hover:bg-error/20 text-error text-[11px] font-semibold text-center transition-colors"
                                        CommandArgument='<%# Eval("MaChat") %>'
                                        OnClick="btnDelete_Click">
                                        <asp:Label ID="lblDelete" runat="server" Text="Xóa" />
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- MAIN CHAT STREAM -->
            <div class="flex-1 flex flex-col justify-between bg-surface/50 overflow-hidden">
                
                <!-- Chat Messages Scroll Container -->
                <div id="chatBox" runat="server" class="flex-1 overflow-y-auto p-6 flex flex-col gap-4">
                </div>

                <!-- Bottom Sticky Input Box -->
                <div class="p-4 bg-surface-container-low/90 backdrop-blur-2xl border-t border-outline-variant/20">
                    <div class="flex items-center gap-3 bg-surface-container px-4 py-1.5 rounded-2xl border border-outline-variant/30 focus-within:border-primary transition-all shadow-inner">
                        <asp:TextBox
                            ID="txtMsg"
                            runat="server"
                            CssClass="flex-1 bg-transparent border-none text-on-surface text-sm placeholder:text-on-surface-variant/60 focus:outline-none py-2"
                            placeholder="Hỏi AI về chi tiêu, tiết kiệm, quản lý tài chính..."
                            onkeypress="handleEnter(event)" />

                        <button type="button" onclick="sendMessage()" class="w-10 h-10 rounded-xl bg-primary text-on-primary flex items-center justify-center hover:brightness-110 transition-all cursor-pointer shrink-0 shadow-md">
                            <span class="material-symbols-outlined text-[20px]">arrow_upward</span>
                        </button>

                        <asp:Button
                            ID="btnSend"
                            runat="server"
                            Style="display:none;"
                            OnClick="btnSend_Click" />
                    </div>
                </div>

            </div>

        </div>

    </div>

</form>

<script>
    function handleEnter(e) {
        if(e.key === "Enter") {
            e.preventDefault();
            sendMessage();
        }
    }

    function sendMessage() {
        let txt = document.getElementById('<%= txtMsg.ClientID %>');
        let hf = document.getElementById('<%= hfMessage.ClientID %>');
        let value = txt.value.trim();

        if(value === "") return;

        hf.value = value;
        let box = document.getElementById('<%= chatBox.ClientID %>');

        box.innerHTML += `
            <div class="msg-row user">
                <div class="msg user">${value}</div>
            </div>

            <div class="msg-row" id="typingAI">
                <div class="avatar bg-primary/20 text-primary">
                    <span class="material-symbols-outlined text-[20px]">smart_toy</span>
                </div>
                <div class="msg ai">
                    <div class="typing">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
            </div>
        `;

        scrollChat();
        txt.value = "";
        document.getElementById('<%= btnSend.ClientID %>').click();
    }

    function scrollChat() {
        let box = document.getElementById('<%= chatBox.ClientID %>');
        if (box) {
            box.scrollTop = box.scrollHeight;
        }
    }

    function toggleHistory() {
        let sidebar = document.getElementById("historySidebar");
        if (sidebar) {
            sidebar.classList.toggle("hide");
        }
    }

    setTimeout(scrollChat, 100);
</script>
</body>
</html>