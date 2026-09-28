<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="goiyai.aspx.cs" Inherits="QuanLyChiTieuThongMinh.goiyai" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trợ lý AI</title>

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

/* ================= SIDEBAR ================= */

.sidebar{
    width:260px;
    background:linear-gradient(180deg,#5e7cff,#4d6ef5);
    color:white;
    padding:22px 18px;
    display:flex;
    flex-direction:column;
}

.logo{
    display:flex;
    align-items:center;
    gap:12px;
    margin-bottom:28px;
}

.logo-box{
    width:42px;
    height:42px;
    border-radius:12px;
    background:rgba(255,255,255,.18);
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
    opacity:.7;
    margin-bottom:8px;
}

.menu-group a{
    display:flex;
    align-items:center;
    gap:12px;
    padding:11px 12px;
    border-radius:12px;
    color:white;
    text-decoration:none;
    margin-bottom:6px;
    transition:.2s;
    font-size:14px;
}

.menu-group a:hover{
    background:rgba(255,255,255,.15);
}

.menu-group a.active{
    background:rgba(255,255,255,.22);
}

.logout{
    margin-top:auto;
    padding:12px;
    border-radius:12px;
    background:rgba(255,255,255,.12);
    color:white;
    text-decoration:none;
    display:flex;
    align-items:center;
    gap:10px;
}

/* ================= RIGHT ================= */

.right-layout{
    flex:1;
    display:flex;
    overflow:hidden;
}

/* ================= HISTORY ================= */

.chat-sidebar{
    width:320px;
    min-width:320px;
    background:rgba(255,255,255,.9);
    backdrop-filter:blur(18px);
    border-right:1px solid #e5e7eb;
    display:flex;
    flex-direction:column;
    transition:.28s ease;
    overflow:hidden;
}

.chat-sidebar.hide{
    width:0;
    min-width:0;
    opacity:0;
    border-right:none;
}

.chat-top{
    padding:22px;
    border-bottom:1px solid #eef2ff;
}

.ai-title{
    display:flex;
    align-items:center;
    gap:14px;
    margin-bottom:18px;
}

.ai-icon{
    width:50px;
    height:50px;
    border-radius:16px;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    display:flex;
    align-items:center;
    justify-content:center;
    color:white;
}

.new-chat-btn{
    width:100%;
    height:50px;
    border:none;
    border-radius:14px;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    color:white;
    font-weight:600;
    cursor:pointer;
}

.chat-list{
    flex:1;
    overflow:auto;
    padding:14px;
}

.chat-item{
    background:white;
    border:1px solid #edf2ff;
    border-radius:18px;
    padding:14px;
    margin-bottom:12px;
}

.chat-item.active{
    border:2px solid #5e7cff;
}

.chat-title{
    font-weight:600;
    margin-bottom:6px;
}

.chat-date{
    font-size:12px;
    color:#888;
}

.chat-actions{
    display:flex;
    gap:8px;
    margin-top:12px;
}

.action-btn{
    flex:1;
    border:none;
    border-radius:10px;
    padding:9px;
    text-decoration:none;
    text-align:center;
    cursor:pointer;
    font-size:13px;
}

.open-btn{
    background:#5e7cff;
    color:white;
}

.delete-btn{
    background:#ffe7e7;
    color:#ef4444;
}

/* ================= MAIN ================= */

.main{
    flex:1;
    display:flex;
    flex-direction:column;
}

.header{
    height:76px;
    background:rgba(255,255,255,.8);
    border-bottom:1px solid #edf2fb;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 24px;
}

.header-left{
    display:flex;
    align-items:center;
    gap:12px;
}

.header h2{
    color:#4d6ef5;
}

.online{
    color:#16a34a;
    font-weight:600;
    font-size:14px;
}

.toggle-history{
    width:42px;
    height:42px;
    border:none;
    border-radius:12px;
    background:#eef2ff;
    color:#4d6ef5;
    display:flex;
    align-items:center;
    justify-content:center;
    cursor:pointer;
    transition:.2s;
}

.toggle-history:hover{
    background:#dfe7ff;
    transform:translateY(-1px);
}

.toggle-history i{
    width:20px;
    height:20px;
}

/* ================= CHAT ================= */

.chat-box{
    flex:1;
    overflow-y:auto;
    padding:28px;
    display:flex;
    flex-direction:column;
    gap:14px;
}

.msg-row{
    display:flex;
    gap:10px;
    align-items:flex-end;
    animation:fadeIn .2s ease;
}

.msg-row.user{
    justify-content:flex-end;
}

.msg{
    max-width:65%;
    padding:13px 16px;
    border-radius:20px;
    line-height:1.55;
    font-size:14px;
    white-space:pre-wrap;
}

.msg.ai{
    background:white;
    border:1px solid #edf2fb;
    box-shadow:0 4px 12px rgba(0,0,0,.03);
}

.msg.user{
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    color:white;
}

.avatar{
    width:34px;
    height:34px;
    min-width:34px;
    border-radius:50%;
    background:white;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:15px;
}

/* FIX KHUNG GIỚI THIỆU ĐẦU */

.msg-row:first-child{
    align-items:flex-start;
    gap:8px;
}

.msg-row:first-child .avatar{
    margin-top:2px;
    width:34px;
    height:34px;
    min-width:34px;
    font-size:14px;
}

.msg-row:first-child .msg.ai{
    max-width:620px;
    width:auto;
    min-height:auto;
    padding:14px 18px;
    border-radius:18px;
    line-height:1.55;
    font-size:14px;
    color:#374151;
    background:#ffffff;
    box-shadow:0 6px 18px rgba(94,124,255,.05);
    border:1px solid #e8eeff;
    margin-left:0;
}

/* ================= INPUT ================= */

.chat-input{
    padding:20px 24px;
    background:white;
    border-top:1px solid #edf2fb;
}

.input-box{
    display:flex;
    align-items:center;
    gap:12px;
    background:#f8faff;
    border:1px solid #e5e7eb;
    border-radius:999px;
    padding:10px 12px 10px 22px;
}

.input-box input[type=text]{
    flex:1;
    border:none !important;
    background:transparent !important;
    outline:none !important;
    height:42px;
    font-size:15px;
}

.send-btn{
    width:46px;
    height:46px;
    border:none;
    border-radius:50%;
    background:#111827;
    color:white;
    display:flex;
    align-items:center;
    justify-content:center;
    cursor:pointer;
}

.send-btn i{
    width:20px;
    height:20px;
}

/* FIX LOADING KHÔNG BỊ TO */

#typingAI{
    align-items:flex-start;
}

#typingAI .avatar{
    width:34px;
    height:34px;
    min-width:34px;
    font-size:14px;
    margin-top:2px;
}

#typingAI .msg.ai{
    max-width:78px;
    min-width:78px;
    width:78px;
    height:46px;
    min-height:46px;
    padding:0;
    border-radius:18px;
    display:flex;
    align-items:center;
    justify-content:center;
}

.typing{
    display:flex;
    gap:5px;
    padding:0;
    align-items:center;
    justify-content:center;
}

.typing span{
    width:7px;
    height:7px;
    background:#94a3b8;
    border-radius:50%;
    animation:bounce 1s infinite;
}

.typing span:nth-child(2){
    animation-delay:.15s;
}

.typing span:nth-child(3){
    animation-delay:.3s;
}

@keyframes bounce{
    0%,80%,100%{
        transform:scale(0);
    }
    40%{
        transform:scale(1);
    }
}

@keyframes fadeIn{
    from{
        opacity:0;
        transform:translateY(8px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

</style>

</head>

<body>

<form id="form1" runat="server">

<asp:HiddenField ID="hfMessage" runat="server" />

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

                <a href="thuchi.aspx">
                    <i data-lucide="wallet"></i>
                    Thu chi
                </a>

            </div>

            <div class="menu-group">

                <p>PHÂN TÍCH</p>

                <a class="active" href="goiyai.aspx">
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

        <a class="logout" href="login.aspx">
            <i data-lucide="log-out"></i>
            Đăng xuất
        </a>

    </div>

    <!-- RIGHT -->
    <div class="right-layout">

        <!-- HISTORY -->
        <div class="chat-sidebar" id="historySidebar">

            <div class="chat-top">

                <div class="ai-title">

                    <div class="ai-icon">
                        <i data-lucide="bot"></i>
                    </div>

                    <div>
                        <h3>Expense AI</h3>
                        <small>AI tài chính cá nhân</small>
                    </div>

                </div>

                <asp:Button
                    ID="btnNewChat"
                    runat="server"
                    Text="+ Cuộc trò chuyện mới"
                    CssClass="new-chat-btn"
                    OnClick="btnNewChat_Click" />

            </div>

            <div class="chat-list">

                <asp:Repeater ID="rpChat" runat="server">

                    <ItemTemplate>

                        <div class='chat-item <%# Session["MaChat"] != null && Convert.ToInt32(Eval("MaChat")) == Convert.ToInt32(Session["MaChat"]) ? "active" : "" %>'>

                            <div class="chat-title">
                                <%# Eval("TenChat") %>
                            </div>

                            <div class="chat-date">
                                <%# Convert.ToDateTime(Eval("NgayTao")).ToString("dd/MM/yyyy HH:mm") %>
                            </div>

                            <div class="chat-actions">

                                <asp:LinkButton
                                    ID="btnOpen"
                                    runat="server"
                                    CssClass="action-btn open-btn"
                                    CommandArgument='<%# Eval("MaChat") %>'
                                    OnClick="btnOpen_Click">

                                    Mở

                                </asp:LinkButton>

                                <asp:LinkButton
                                    ID="btnDelete"
                                    runat="server"
                                    CssClass="action-btn delete-btn"
                                    CommandArgument='<%# Eval("MaChat") %>'
                                    OnClick="btnDelete_Click">

                                    Xóa

                                </asp:LinkButton>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </div>

        <!-- MAIN -->
        <div class="main">

            <div class="header">

                <div class="header-left">

                    <button type="button"
                            class="toggle-history"
                            onclick="toggleHistory()">

                        <i data-lucide="panel-left-close"></i>

                    </button>

                    <h2>🤖 Trợ lý AI tài chính</h2>

                </div>

                <div class="online">
                    AI đang hoạt động
                </div>

            </div>

            <!-- CHAT -->
            <div class="chat-box"
                 id="chatBox"
                 runat="server">

            </div>

            <!-- INPUT -->
            <div class="chat-input">

                <div class="input-box">

                    <asp:TextBox
                        ID="txtMsg"
                        runat="server"
                        placeholder="Hỏi AI về chi tiêu, tiết kiệm, quản lý tài chính..."
                        onkeypress="handleEnter(event)" />

                    <button type="button"
                            class="send-btn"
                            onclick="sendMessage()">

                        <i data-lucide="arrow-up"></i>

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

    lucide.createIcons();

    function handleEnter(e){

        if(e.key==="Enter"){

            e.preventDefault();

            sendMessage();
        }
    }

    function sendMessage(){

        let txt =
            document.getElementById(
                '<%= txtMsg.ClientID %>');

        let hf =
            document.getElementById(
                '<%= hfMessage.ClientID %>');

        let value = txt.value.trim();

        if(value==="") return;

        hf.value = value;

        let box =
            document.getElementById(
                '<%= chatBox.ClientID %>');

        box.innerHTML += `
            <div class="msg-row user">
                <div class="msg user">${value}</div>
            </div>

            <div class="msg-row" id="typingAI">
                <div class="avatar">
                    🤖
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

        document.getElementById(
            '<%= btnSend.ClientID %>'
        ).click();
    }

    function scrollChat(){

        let box =
            document.getElementById(
                '<%= chatBox.ClientID %>');

        box.scrollTop =
            box.scrollHeight;
    }

    function toggleHistory() {

        let sidebar =
            document.getElementById("historySidebar");

        sidebar.classList.toggle("hide");

        lucide.createIcons();
    }

    setTimeout(scrollChat, 100);

</script>

</body>
</html>