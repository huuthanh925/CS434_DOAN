<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="thongke.aspx.cs" Inherits="QuanLyChiTieuThongMinh.thongke" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Thống kê</title>

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
}

.container{
    display:flex;
    height:100vh;
}

/* ================= SIDEBAR ================= */
.sidebar{
    width:260px;
    background:linear-gradient(180deg,#5e7cff,#4d6ef5);
    color:#fff;
    padding:26px 18px;
    display:flex;
    flex-direction:column;
    box-shadow:5px 0 25px rgba(0,0,0,0.08);
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
    backdrop-filter:blur(6px);
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
    box-shadow:inset 0 0 0 1px rgba(255,255,255,.2);
}

.logout{
    margin-top:auto;
    display:flex;
    align-items:center;
    gap:10px;
    color:#ffdddd;
    padding:12px;
    border-radius:12px;
    cursor:pointer;
    background:rgba(255,0,0,0.12);
    transition:.2s;
}

.logout:hover{
    background:rgba(255,0,0,0.2);
}

/* ================= MAIN ================= */
.main{
    flex:1;
    padding:26px;
    overflow:auto;
}

.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:22px;
}

.header h2{
    color:#4d6ef5;
    font-size:22px;
    font-weight:700;
}

.header p{
    color:#6b7280;
    font-size:13px;
    margin-top:3px;
}

.guest-badge{
    background:#fff7ed;
    color:#c2410c;
    border:1px solid #fed7aa;
    padding:8px 14px;
    border-radius:999px;
    font-size:13px;
    font-weight:600;
}

/* ================= FILTER ================= */
.filter-box{
    background:linear-gradient(135deg,#ffffff,#f8faff);
    border-radius:22px;
    padding:20px;
    margin-bottom:20px;
    box-shadow:0 12px 30px rgba(0,0,0,.06);
    border:1px solid #e8edff;
    display:flex;
    justify-content:space-between;
    gap:18px;
    align-items:center;
}

.filter-title{
    display:flex;
    align-items:center;
    gap:14px;
}

.filter-icon{
    width:48px;
    height:48px;
    border-radius:16px;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    color:white;
    display:flex;
    align-items:center;
    justify-content:center;
    box-shadow:0 10px 25px rgba(94,124,255,.25);
}

.filter-title h3{
    color:#4d6ef5;
    font-size:17px;
    margin-bottom:3px;
}

.filter-title p{
    color:#6b7280;
    font-size:13px;
}

.filter-control{
    display:flex;
    align-items:center;
    gap:12px;
}

.date-group{
    display:flex;
    flex-direction:column;
    gap:6px;
}

.date-group label{
    font-size:12px;
    color:#6b7280;
    font-weight:600;
}

.date-group input{
    height:43px;
    border:1px solid #e3e7f0;
    border-radius:13px;
    padding:0 12px;
    outline:none;
    min-width:150px;
    background:white;
}

.date-group input:focus{
    border-color:#5e7cff;
    box-shadow:0 0 0 3px rgba(94,124,255,.12);
}

.btn-filter{
    height:43px;
    padding:0 20px;
    border:none;
    border-radius:13px;
    color:white;
    background:linear-gradient(135deg,#5e7cff,#6ad4f7);
    font-weight:600;
    cursor:pointer;
    margin-top:22px;
    box-shadow:0 10px 22px rgba(94,124,255,.22);
    transition:.2s;
}

.btn-filter:hover{
    transform:translateY(-2px);
}

/* ================= CARDS ================= */
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
}

.card:hover{
    transform:translateY(-3px);
    box-shadow:0 16px 35px rgba(0,0,0,.08);
}

.card-top{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:10px;
}

.card h4{
    font-size:13px;
    color:#6b7280;
}

.card h2{
    font-size:21px;
    margin-top:4px;
}

.card-icon{
    width:38px;
    height:38px;
    border-radius:12px;
    display:flex;
    align-items:center;
    justify-content:center;
    background:#eef3ff;
    color:#5e7cff;
}

.income{
    color:#16a34a;
    font-weight:700;
}

.expense{
    color:#ef4444;
    font-weight:700;
}

/* ================= RANGE SUMMARY ================= */
.range-cards{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:16px;
    margin-bottom:20px;
}

.range-card{
    background:linear-gradient(135deg,#ffffff,#f8faff);
    border-radius:20px;
    padding:18px;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    border:1px solid #edf2ff;
}

.range-card h4{
    color:#6b7280;
    font-size:13px;
    margin-bottom:8px;
}

.range-card h2{
    font-size:21px;
}

/* ================= CHARTS ================= */
.content{
    display:grid;
    grid-template-columns:2fr 1fr;
    gap:20px;
    margin-bottom:20px;
}

.box{
    background:white;
    border-radius:22px;
    padding:22px;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    border:1px solid #edf2ff;
    transition:.2s;
}

.box:hover{
    transform:translateY(-2px);
}

.box-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:14px;
}

.box h3{
    color:#4d6ef5;
    font-size:16px;
}

.box small{
    color:#6b7280;
}

.full-box{
    background:white;
    border-radius:22px;
    padding:22px;
    box-shadow:0 10px 25px rgba(0,0,0,.05);
    border:1px solid #edf2ff;
}

.full-box h3{
    margin-bottom:4px;
    color:#4d6ef5;
    font-size:16px;
}

.full-box p{
    color:#6b7280;
    font-size:13px;
    margin-bottom:14px;
}

/* ================= RESPONSIVE ================= */
@media(max-width:1050px){
    .cards{
        grid-template-columns:repeat(2,1fr);
    }

    .range-cards{
        grid-template-columns:1fr;
    }

    .content{
        grid-template-columns:1fr;
    }

    .filter-box{
        flex-direction:column;
        align-items:flex-start;
    }

    .filter-control{
        flex-wrap:wrap;
    }
}

@media(max-width:900px){
    .sidebar{
        display:none;
    }
}

@media(max-width:550px){
    .cards{
        grid-template-columns:1fr;
    }

    .filter-control{
        flex-direction:column;
        width:100%;
        align-items:stretch;
    }

    .date-group input{
        width:100%;
    }

    .btn-filter{
        width:100%;
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
                <span style="font-weight:600;">EXPENSE AI</span>
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
                <a class="active"><i data-lucide="bar-chart-3"></i> Thống kê</a>
                <a href="taikhoan.aspx"><i data-lucide="user"></i> Tài khoản</a>
            </div>

        </div>

        <div class="logout" onclick="location.href='login.aspx'">
            <i data-lucide="log-out"></i>
            <% if (Session["Khach"] != null) { %>
                Thoát demo
            <% } else { %>
                Đăng xuất
            <% } %>
        </div>

    </div>

    <!-- MAIN -->
    <div class="main">

        <div class="header">
            <div>
                <h2>Thống kê tài chính</h2>
                <p>Theo dõi thu chi, số dư và xu hướng tài chính của bạn</p>
            </div>

            <% if (Session["Khach"] != null) { %>
                <div class="guest-badge">Chế độ khách vãng lai</div>
            <% } %>
        </div>

        <!-- FILTER RANGE -->
        <div class="filter-box">

            <div class="filter-title">
                <div class="filter-icon">
                    <i data-lucide="calendar-range"></i>
                </div>

                <div>
                    <h3>Thống kê theo khoảng thời gian</h3>
                    <p>Chọn từ ngày đến ngày để xem tổng thu, tổng chi và xu hướng</p>
                </div>
            </div>

            <div class="filter-control">

                <div class="date-group">
                    <label>Từ ngày</label>
                    <asp:TextBox ID="txtTuNgay" runat="server" TextMode="Date"></asp:TextBox>
                </div>

                <div class="date-group">
                    <label>Đến ngày</label>
                    <asp:TextBox ID="txtDenNgay" runat="server" TextMode="Date"></asp:TextBox>
                </div>

                <asp:Button
                    ID="btnLocKhoangNgay"
                    runat="server"
                    Text="Xem thống kê"
                    CssClass="btn-filter"
                    OnClick="btnLocKhoangNgay_Click" />

            </div>

        </div>

        <!-- TOTAL CARDS -->
        <div class="cards">

            <div class="card">
                <div class="card-top">
                    <h4>Tổng thu</h4>
                    <div class="card-icon"><i data-lucide="trending-up"></i></div>
                </div>
                <h2 class="income"><asp:Label ID="lblIncome" runat="server"/></h2>
            </div>

            <div class="card">
                <div class="card-top">
                    <h4>Tổng chi</h4>
                    <div class="card-icon"><i data-lucide="trending-down"></i></div>
                </div>
                <h2 class="expense"><asp:Label ID="lblExpense" runat="server"/></h2>
            </div>

            <div class="card">
                <div class="card-top">
                    <h4>Số dư</h4>
                    <div class="card-icon"><i data-lucide="wallet"></i></div>
                </div>
                <h2><asp:Label ID="lblBalance" runat="server"/></h2>
            </div>

            <div class="card">
                <div class="card-top">
                    <h4>Tiết kiệm</h4>
                    <div class="card-icon"><i data-lucide="piggy-bank"></i></div>
                </div>
                <h2><asp:Label ID="lblRate" runat="server"/></h2>
            </div>

        </div>

        <!-- RANGE CARDS -->
        <div class="range-cards">

            <div class="range-card">
                <h4>Thu trong khoảng ngày</h4>
                <h2 class="income"><asp:Label ID="lblRangeIncome" runat="server"/></h2>
            </div>

            <div class="range-card">
                <h4>Chi trong khoảng ngày</h4>
                <h2 class="expense"><asp:Label ID="lblRangeExpense" runat="server"/></h2>
            </div>

            <div class="range-card">
                <h4>Số dư khoảng ngày</h4>
                <h2><asp:Label ID="lblRangeBalance" runat="server"/></h2>
            </div>

        </div>

        <!-- CHARTS -->
        <div class="content">

            <div class="box">
                <div class="box-header">
                    <div>
                        <h3>Thu vs Chi</h3>
                        <small>Tổng quan toàn bộ dữ liệu</small>
                    </div>
                </div>
                <canvas id="barChart"></canvas>
            </div>

            <div class="box">
                <div class="box-header">
                    <div>
                        <h3>Phân bổ</h3>
                        <small>Tỷ lệ thu và chi</small>
                    </div>
                </div>
                <canvas id="pieChart"></canvas>
            </div>

        </div>

        <div class="full-box">
            <h3>Xu hướng theo khoảng thời gian</h3>
            <p>Biểu đồ thể hiện tổng thu và tổng chi theo từng ngày trong khoảng đã chọn</p>
            <canvas id="rangeChart"></canvas>
        </div>

    </div>

</div>

<asp:Literal ID="litTotalIncome" runat="server" Visible="false"></asp:Literal>
<asp:Literal ID="litTotalExpense" runat="server" Visible="false"></asp:Literal>

<asp:Literal ID="litRangeLabels" runat="server" Visible="false"></asp:Literal>
<asp:Literal ID="litRangeIncomeData" runat="server" Visible="false"></asp:Literal>
<asp:Literal ID="litRangeExpenseData" runat="server" Visible="false"></asp:Literal>

</form>

<script>
    lucide.createIcons();

    const income = <%= litTotalIncome.Text %>;
    const expense = <%= litTotalExpense.Text %>;

    const rangeLabels = [<%= litRangeLabels.Text %>];
    const rangeIncomeData = [<%= litRangeIncomeData.Text %>];
    const rangeExpenseData = [<%= litRangeExpenseData.Text %>];

    new Chart(document.getElementById("barChart"), {
        type: "bar",
        data: {
            labels: ["Thu", "Chi"],
            datasets: [{
                data: [income, expense],
                backgroundColor: ["#16a34a", "#ef4444"],
                borderRadius: 12
            }]
        },
        options: {
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });

    new Chart(document.getElementById("pieChart"), {
        type: "doughnut",
        data: {
            labels: ["Thu", "Chi"],
            datasets: [{
                data: [income, expense],
                backgroundColor: ["#16a34a", "#ef4444"]
            }]
        },
        options: {
            cutout: "68%",
            plugins: {
                legend: {
                    position: "bottom"
                }
            }
        }
    });

    new Chart(document.getElementById("rangeChart"), {
        type: "line",
        data: {
            labels: rangeLabels,
            datasets: [
                {
                    label: "Thu",
                    data: rangeIncomeData,
                    borderWidth: 3,
                    tension: 0.4
                },
                {
                    label: "Chi",
                    data: rangeExpenseData,
                    borderWidth: 3,
                    tension: 0.4
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: "bottom"
                }
            },
            scales: {
                y: { beginAtZero: true }
            }
        }
    });
</script>

</body>
</html>