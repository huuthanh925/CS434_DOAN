<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="trangchu.aspx.cs" Inherits="QuanLyChiTieuThongMinh.trangchu" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang chủ</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

/* SIDEBAR */
.sidebar{
    width:260px;
    background:linear-gradient(180deg,#5e7cff,#4d6ef5);
    color:#fff;
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
    transition:.25s ease;
    font-size:14px;
}

.menu-group a:hover{
    background:rgba(255,255,255,.18);
    transform:translateX(5px);
}

.menu-group a.active{
    background:rgba(255,255,255,.28);
    box-shadow:inset 0 0 0 1px rgba(255,255,255,.15);
}

.logout{
    margin-top:auto;
    color:#ffdddd;
    display:flex;
    gap:10px;
    align-items:center;
    padding:12px;
    border-radius:12px;
    background:rgba(255,0,0,.12);
    cursor:pointer;
    transition:.2s;
    font-weight:500;
    border:none;
    width:100%;
    text-decoration:none;
}

.logout:hover{
    background:rgba(255,0,0,.2);
}

/* MAIN */
.main{
    flex:1;
    padding:24px 30px;
    overflow:auto;
}

/* TOPBAR */
.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    gap:18px;
    margin-bottom:22px;
}

.title h2{
    color:#4d6ef5;
    font-size:24px;
    font-weight:700;
}

.title span{
    color:#6b7280;
    font-size:13px;
}

.top-actions{
    display:flex;
    align-items:center;
    gap:12px;
}

.search-box{
    width:320px;
    height:46px;
    background:white;
    border:1px solid #e5eaff;
    border-radius:999px;
    display:flex;
    align-items:center;
    gap:10px;
    padding:0 16px;
    box-shadow:0 10px 25px rgba(0,0,0,.04);
}

.search-box input{
    flex:1;
    border:none;
    outline:none;
    font-size:14px;
}

.search-btn{
    width:38px;
    height:38px;
    border:none;
    border-radius:50%;
    background:#111827;
    color:white;
    cursor:pointer;
    display:flex;
    align-items:center;
    justify-content:center;
}

.icon-btn{
    width:46px;
    height:46px;
    border:none;
    border-radius:15px;
    background:white;
    color:#4d6ef5;
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    position:relative;
}

.notify-dot{
    position:absolute;
    right:10px;
    top:9px;
    width:9px;
    height:9px;
    border-radius:50%;
    background:#ef4444;
    border:2px solid white;
}

.login-btn{
    background:#5e7cff;
    color:white;
    padding:12px 18px;
    border-radius:14px;
    text-decoration:none;
    font-size:14px;
    font-weight:600;
    box-shadow:0 10px 25px rgba(94,124,255,.22);
}

/* GUEST */
.guest-box{
    margin-bottom:20px;
    background:linear-gradient(135deg,#fff7ed,#ffffff);
    border:1px solid #fed7aa;
    color:#9a3412;
    padding:16px 18px;
    border-radius:18px;
    display:flex;
    align-items:center;
    gap:12px;
    box-shadow:0 10px 25px rgba(251,146,60,.08);
}

/* CARDS */
.cards{
    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:16px;
    margin-bottom:20px;
}

.card{
    background:white;
    padding:20px;
    border-radius:20px;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    border:1px solid #edf2ff;
    transition:.2s;
    position:relative;
    overflow:hidden;
}

.card:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 30px rgba(0,0,0,.08);
}

.card::after{
    content:"";
    position:absolute;
    width:90px;
    height:90px;
    right:-35px;
    top:-35px;
    background:rgba(94,124,255,.08);
    border-radius:50%;
}

.card-top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:10px;
}

.card-icon{
    width:42px;
    height:42px;
    border-radius:14px;
    display:flex;
    align-items:center;
    justify-content:center;
    background:#eef3ff;
    color:#4d6ef5;
}

.card h4{
    font-size:13px;
    color:#6b7280;
    font-weight:500;
}

.card h2{
    font-size:22px;
    margin-top:6px;
}

.income{
    color:#16a34a;
    font-weight:700;
}

.expense{
    color:#ef4444;
    font-weight:700;
}

.blue{
    color:#4d6ef5;
}

/* ALERTS */
.alert-grid{
    display:grid;
    grid-template-columns:2fr 1fr;
    gap:18px;
    margin-bottom:20px;
}

.alert-box{
    background:linear-gradient(135deg,#ffffff,#f8faff);
    border:1px solid #e6ebff;
    border-radius:20px;
    padding:18px;
    box-shadow:0 10px 25px rgba(0,0,0,.04);
}

.alert-head{
    display:flex;
    align-items:center;
    justify-content:space-between;
    margin-bottom:12px;
}

.alert-head h3{
    color:#374151;
    font-size:16px;
}

.alert-item{
    display:flex;
    gap:12px;
    padding:12px;
    border-radius:14px;
    background:#f8faff;
    border:1px solid #edf2ff;
    margin-bottom:10px;
}

.alert-item:last-child{
    margin-bottom:0;
}

.alert-icon{
    width:36px;
    height:36px;
    min-width:36px;
    border-radius:12px;
    display:flex;
    align-items:center;
    justify-content:center;
}

.warn{
    background:#fff7ed;
    color:#ea580c;
}

.ok{
    background:#dcfce7;
    color:#16a34a;
}

.info{
    background:#eef3ff;
    color:#4d6ef5;
}

.alert-text b{
    display:block;
    font-size:14px;
}

.alert-text span{
    color:#6b7280;
    font-size:12px;
}

/* CATEGORY */
.category-list{
    display:grid;
    gap:10px;
}

.category-item{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:12px;
    border-radius:14px;
    background:#f8faff;
    border:1px solid #edf2ff;
}

.category-left{
    display:flex;
    align-items:center;
    gap:10px;
}

.category-icon{
    width:36px;
    height:36px;
    border-radius:12px;
    background:#eef3ff;
    color:#4d6ef5;
    display:flex;
    align-items:center;
    justify-content:center;
}

.category-name b{
    display:block;
    font-size:13px;
}

.category-name small{
    color:#6b7280;
    font-size:11px;
}

/* CONTENT */
.content{
    display:grid;
    grid-template-columns:2fr 1fr;
    gap:18px;
}

.box{
    background:white;
    padding:20px;
    border-radius:20px;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    border:1px solid #edf2ff;
}

.box-head{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:15px;
}

.box h3{
    color:#374151;
    font-size:16px;
}

.filter-row{
    display:flex;
    gap:10px;
    margin-bottom:14px;
}

.filter-row select{
    height:42px;
    border-radius:12px;
    border:1px solid #e5e7eb;
    padding:0 12px;
    outline:none;
}

.item{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:13px 0;
    border-bottom:1px solid #f1f5ff;
}

.item:last-child{
    border-bottom:none;
}

.item-left b{
    font-size:14px;
}

.item-left small{
    color:#6b7280;
    font-size:12px;
}

.empty{
    padding:18px;
    text-align:center;
    color:#6b7280;
    background:#f8faff;
    border-radius:14px;
}

/* RESPONSIVE */
@media(max-width:1100px){
    .cards{
        grid-template-columns:repeat(2,1fr);
    }

    .alert-grid,
    .content{
        grid-template-columns:1fr;
    }

    .search-box{
        width:240px;
    }
}

@media(max-width:900px){
    .sidebar{
        display:none;
    }

    .main{
        padding:20px;
    }

    .topbar{
        flex-direction:column;
        align-items:flex-start;
    }

    .top-actions{
        width:100%;
    }

    .search-box{
        width:100%;
    }

    .cards{
        grid-template-columns:1fr;
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
                    <img src="images/logo.png" />
                </div>
                <span style="font-weight:700;">EXPENSE AI</span>
            </div>

            <div class="menu-group">
                <p>TỔNG QUAN</p>
                <a class="active" href="trangchu.aspx"><i data-lucide="home"></i> Trang chủ</a>
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
                <a href="taikhoan.aspx"><i data-lucide="user"></i> Tài khoản</a>
            </div>

        </div>

        <asp:PlaceHolder ID="plLogout" runat="server">
            <asp:LinkButton ID="lnkLogout" runat="server" CssClass="logout" OnClick="lnkLogout_Click">
                <i data-lucide="log-out"></i> Đăng xuất
            </asp:LinkButton>
        </asp:PlaceHolder>

    </div>

    <!-- MAIN -->
    <div class="main">

        <!-- TOPBAR -->
        <div class="topbar">

            <div class="title">
                <h2>Dashboard</h2>
                <asp:Label ID="lblGuest" runat="server"></asp:Label>
            </div>

            <div class="top-actions">

                <div class="search-box">
                    <i data-lucide="search"></i>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm giao dịch, danh mục..." />
                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="search-btn" OnClick="btnSearch_Click">
                        <i data-lucide="arrow-right"></i>
                    </asp:LinkButton>
                </div>

                <button type="button" class="icon-btn" onclick="scrollToAlerts()">
                    <i data-lucide="bell"></i>
                    <span class="notify-dot"></span>
                </button>

                <asp:HyperLink ID="hlLogin" runat="server" NavigateUrl="login.aspx" CssClass="login-btn">
                    Đăng nhập
                </asp:HyperLink>

            </div>

        </div>

        <asp:Panel ID="pnGuest" runat="server" CssClass="guest-box">
            <i data-lucide="eye"></i>
            Đây là chế độ xem trước dành cho khách vãng lai. Đăng nhập để quản lý thu chi và sử dụng AI đầy đủ.
        </asp:Panel>

        <!-- CARDS -->
        <div class="cards">

            <div class="card">
                <div class="card-top">
                    <h4>Số dư hiện tại</h4>
                    <div class="card-icon"><i data-lucide="wallet"></i></div>
                </div>
                <h2 class="blue"><asp:Label ID="lblBalance" runat="server" Text="0đ"></asp:Label></h2>
            </div>

            <div class="card">
                <div class="card-top">
                    <h4>Tổng thu nhập</h4>
                    <div class="card-icon"><i data-lucide="trending-up"></i></div>
                </div>
                <h2 class="income"><asp:Label ID="lblIncome" runat="server" Text="0đ"></asp:Label></h2>
            </div>

            <div class="card">
                <div class="card-top">
                    <h4>Tổng chi tiêu</h4>
                    <div class="card-icon"><i data-lucide="trending-down"></i></div>
                </div>
                <h2 class="expense"><asp:Label ID="lblExpense" runat="server" Text="0đ"></asp:Label></h2>
            </div>

            <div class="card">
                <div class="card-top">
                    <h4>Tỷ lệ tiết kiệm</h4>
                    <div class="card-icon"><i data-lucide="piggy-bank"></i></div>
                </div>
                <h2><asp:Label ID="lblSavingRate" runat="server" Text="0%"></asp:Label></h2>
            </div>

        </div>

        <!-- ALERT + CATEGORY -->
        <div class="alert-grid" id="alerts">

            <div class="alert-box">
                <div class="alert-head">
                    <h3>Thông báo & cảnh báo</h3>
                    <i data-lucide="shield-alert"></i>
                </div>

                <asp:Repeater ID="rpNotify" runat="server">
                    <ItemTemplate>
                        <div class="alert-item">
                            <div class='alert-icon <%# Eval("Type") %>'>
                                <i data-lucide='<%# Eval("Icon") %>'></i>
                            </div>
                            <div class="alert-text">
                                <b><%# Eval("Title") %></b>
                                <span><%# Eval("Message") %></span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="alert-box">
                <div class="alert-head">
                    <h3>Danh mục nổi bật</h3>
                    <i data-lucide="folder-heart"></i>
                </div>

                <div class="category-list">
                    <asp:Repeater ID="rpCategory" runat="server">
                        <ItemTemplate>
                            <div class="category-item">
                                <div class="category-left">
                                    <div class="category-icon">
                                        <i data-lucide='<%# Eval("Icon") %>'></i>
                                    </div>
                                    <div class="category-name">
                                        <b><%# Eval("TenDanhMuc") %></b>
                                        <small><%# Eval("Loai") %></small>
                                    </div>
                                </div>

                                <span class='<%# Eval("Loai").ToString()=="Thu" ? "income" : "expense" %>'>
                                    <%# Eval("TongTien") %>
                                </span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

        </div>

        <!-- CONTENT -->
        <div class="content">

            <div class="box">
                <div class="box-head">
                    <h3>Biểu đồ chi tiêu</h3>
                    <i data-lucide="line-chart"></i>
                </div>

                <canvas id="myChart"></canvas>

                <asp:HiddenField ID="hfChartLabels" runat="server" />
                <asp:HiddenField ID="hfChartValues" runat="server" />
            </div>

            <div class="box">
                <div class="box-head">
                    <h3>Giao dịch gần đây</h3>
                    <i data-lucide="receipt-text"></i>
                </div>

                <div class="filter-row">
                    <asp:DropDownList ID="ddlCategoryFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="FilterChanged">
                    </asp:DropDownList>
                </div>

                <asp:Repeater ID="rpTransaction" runat="server">
                    <ItemTemplate>
                        <div class="item">
                            <div class="item-left">
                                <b><%# Eval("Desc") %></b><br />
                                <small><%# Eval("Sub") %></small>
                            </div>

                            <span class='<%# (bool)Eval("IsIncome") ? "income" : "expense" %>'>
                                <%# Eval("Amount") %>
                            </span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnEmpty" runat="server" CssClass="empty" Visible="false">
                    Không tìm thấy giao dịch phù hợp.
                </asp:Panel>

            </div>

        </div>

    </div>

</div>

</form>

<script>
    lucide.createIcons();

    function scrollToAlerts(){
        document.getElementById("alerts").scrollIntoView({
            behavior:"smooth",
            block:"start"
        });
    }

    const labels = document.getElementById('<%= hfChartLabels.ClientID %>').value.split('|');
    const values = document.getElementById('<%= hfChartValues.ClientID %>').value.split('|').map(Number);

    new Chart(document.getElementById('myChart'), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Chi tiêu',
                data: values,
                borderWidth: 3,
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>

</body>
</html>