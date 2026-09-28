using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace QuanLyChiTieuThongMinh
{
    public partial class trangchu : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] == null && Session["Khach"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            bool isGuest = Session["Khach"] != null;

            pnGuest.Visible = isGuest;
            hlLogin.Visible = isGuest;
            plLogout.Visible = !isGuest;

            lblGuest.Text = isGuest
                ? "Chế độ xem trước dành cho khách vãng lai"
                : "Xin chào, " + (Session["HoTen"] != null ? Session["HoTen"].ToString() : "Người dùng");

            if (!IsPostBack)
            {
                LoadCategoryFilter();
                LoadDashboard();
                LoadRecentTransaction();
                LoadCategorySummary();
                LoadNotify();
                LoadChart();
            }
        }

        void LoadDashboard()
        {
            try
            {
                bool isGuest = Session["Khach"] != null;

                decimal income = 0;
                decimal expense = 0;

                if (isGuest)
                {
                    income = 25000000;
                    expense = 8300000;
                }
                else
                {
                    if (db.conn.State == ConnectionState.Closed)
                    {
                        db.conn.Open();
                    }

                    int maND = Convert.ToInt32(Session["MaND"]);

                    string sqlIncome =
                    @"SELECT ISNULL(SUM(SoTien),0)
                      FROM GiaoDich
                      WHERE Loai=N'Thu'
                      AND MaND=@MaND";

                    SqlCommand cmdIncome = new SqlCommand(sqlIncome, db.conn);
                    cmdIncome.Parameters.AddWithValue("@MaND", maND);
                    income = Convert.ToDecimal(cmdIncome.ExecuteScalar());

                    string sqlExpense =
                    @"SELECT ISNULL(SUM(SoTien),0)
                      FROM GiaoDich
                      WHERE Loai=N'Chi'
                      AND MaND=@MaND";

                    SqlCommand cmdExpense = new SqlCommand(sqlExpense, db.conn);
                    cmdExpense.Parameters.AddWithValue("@MaND", maND);
                    expense = Convert.ToDecimal(cmdExpense.ExecuteScalar());
                }

                decimal balance = income - expense;
                decimal rate = income > 0 ? (balance / income) * 100 : 0;

                lblIncome.Text = income.ToString("N0") + " đ";
                lblExpense.Text = expense.ToString("N0") + " đ";
                lblBalance.Text = balance.ToString("N0") + " đ";
                lblSavingRate.Text = rate.ToString("0") + "%";
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi dashboard: " +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
            finally
            {
                CloseConn();
            }
        }

        void LoadCategoryFilter()
        {
            ddlCategoryFilter.Items.Clear();
            ddlCategoryFilter.Items.Add(new System.Web.UI.WebControls.ListItem("Tất cả danh mục", ""));

            if (Session["Khach"] != null)
            {
                ddlCategoryFilter.Items.Add(new System.Web.UI.WebControls.ListItem("Ăn uống", "Ăn uống"));
                ddlCategoryFilter.Items.Add(new System.Web.UI.WebControls.ListItem("Mua sắm", "Mua sắm"));
                ddlCategoryFilter.Items.Add(new System.Web.UI.WebControls.ListItem("Lương", "Lương"));
                return;
            }

            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                SELECT TenDanhMuc
                FROM DanhMuc
                ORDER BY TenDanhMuc";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                SqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    string ten = rd["TenDanhMuc"].ToString();

                    ddlCategoryFilter.Items.Add(
                        new System.Web.UI.WebControls.ListItem(ten, ten));
                }

                rd.Close();
            }
            finally
            {
                CloseConn();
            }
        }

        void LoadRecentTransaction()
        {
            try
            {
                DataTable dt = CreateTransactionTable();

                bool isGuest = Session["Khach"] != null;
                string keyword = txtSearch.Text.Trim().ToLower();
                string category = ddlCategoryFilter.SelectedValue;

                if (isGuest)
                {
                    AddGuestTransaction(dt, "Lương tháng", "Lương", "+15,000,000 đ", true);
                    AddGuestTransaction(dt, "Ăn uống", "Ăn uống", "-350,000 đ", false);
                    AddGuestTransaction(dt, "Mua sắm", "Mua sắm", "-1,200,000 đ", false);
                    AddGuestTransaction(dt, "Freelance", "Thu nhập thêm", "+4,500,000 đ", true);
                    AddGuestTransaction(dt, "Di chuyển", "Đi lại", "-150,000 đ", false);

                    FilterMemoryTable(dt, keyword, category);

                    BindTransaction(dt);
                    return;
                }

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql =
                @"SELECT TOP 10
                        gd.MoTa,
                        gd.SoTien,
                        gd.Loai,
                        gd.NgayGiaoDich,
                        ISNULL(dm.TenDanhMuc,N'Khác') AS TenDanhMuc
                  FROM GiaoDich gd
                  LEFT JOIN DanhMuc dm ON gd.MaDM = dm.MaDM
                  WHERE gd.MaND=@MaND
                  AND
                  (
                    @Keyword = ''
                    OR gd.MoTa LIKE N'%' + @Keyword + N'%'
                    OR dm.TenDanhMuc LIKE N'%' + @Keyword + N'%'
                  )
                  AND
                  (
                    @Category = ''
                    OR dm.TenDanhMuc = @Category
                  )
                  ORDER BY gd.NgayGiaoDich DESC, gd.MaGD DESC";

                SqlCommand cmd = new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);
                cmd.Parameters.AddWithValue("@Keyword", keyword);
                cmd.Parameters.AddWithValue("@Category", category);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable raw = new DataTable();
                da.Fill(raw);

                foreach (DataRow row in raw.Rows)
                {
                    decimal money = Convert.ToDecimal(row["SoTien"]);
                    bool isIncome = row["Loai"].ToString() == "Thu";

                    DataRow r = dt.NewRow();
                    r["Desc"] = row["MoTa"].ToString();
                    r["Sub"] = row["TenDanhMuc"].ToString() + " • " +
                               Convert.ToDateTime(row["NgayGiaoDich"]).ToString("dd/MM/yyyy");
                    r["Amount"] = (isIncome ? "+" : "-") + money.ToString("N0") + " đ";
                    r["IsIncome"] = isIncome;
                    r["Category"] = row["TenDanhMuc"].ToString();

                    dt.Rows.Add(r);
                }

                BindTransaction(dt);
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi giao dịch: " +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
            finally
            {
                CloseConn();
            }
        }

        void LoadCategorySummary()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TenDanhMuc");
            dt.Columns.Add("Loai");
            dt.Columns.Add("TongTien");
            dt.Columns.Add("Icon");

            if (Session["Khach"] != null)
            {
                dt.Rows.Add("Lương", "Thu", "15,000,000 đ", "briefcase");
                dt.Rows.Add("Ăn uống", "Chi", "350,000 đ", "utensils");
                dt.Rows.Add("Mua sắm", "Chi", "1,200,000 đ", "shopping-bag");

                rpCategory.DataSource = dt;
                rpCategory.DataBind();
                return;
            }

            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                SELECT TOP 5
                    ISNULL(dm.TenDanhMuc,N'Khác') AS TenDanhMuc,
                    gd.Loai,
                    SUM(gd.SoTien) AS TongTien
                FROM GiaoDich gd
                LEFT JOIN DanhMuc dm ON gd.MaDM = dm.MaDM
                WHERE gd.MaND=@MaND
                GROUP BY dm.TenDanhMuc, gd.Loai
                ORDER BY SUM(gd.SoTien) DESC";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                SqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    string ten = rd["TenDanhMuc"].ToString();
                    string loai = rd["Loai"].ToString();
                    decimal total = Convert.ToDecimal(rd["TongTien"]);

                    dt.Rows.Add(
                        ten,
                        loai,
                        total.ToString("N0") + " đ",
                        GetCategoryIcon(ten)
                    );
                }

                rd.Close();

                rpCategory.DataSource = dt;
                rpCategory.DataBind();
            }
            finally
            {
                CloseConn();
            }
        }

        void LoadNotify()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Title");
            dt.Columns.Add("Message");
            dt.Columns.Add("Type");
            dt.Columns.Add("Icon");

            decimal income = ParseMoney(lblIncome.Text);
            decimal expense = ParseMoney(lblExpense.Text);
            decimal balance = income - expense;

            if (expense > income && income > 0)
            {
                dt.Rows.Add(
                    "Cảnh báo chi tiêu vượt thu nhập",
                    "Bạn đang chi nhiều hơn số tiền kiếm được. Hãy kiểm tra lại các khoản chi.",
                    "warn",
                    "triangle-alert");
            }
            else if (income > 0 && expense / income > 0.7m)
            {
                dt.Rows.Add(
                    "Chi tiêu đang khá cao",
                    "Chi tiêu đã vượt 70% thu nhập. Nên giảm các khoản không cần thiết.",
                    "warn",
                    "circle-alert");
            }
            else
            {
                dt.Rows.Add(
                    "Tài chính đang ổn định",
                    "Tỷ lệ chi tiêu hiện tại vẫn trong mức an toàn.",
                    "ok",
                    "check-circle");
            }

            if (balance > 0)
            {
                dt.Rows.Add(
                    "Gợi ý tiết kiệm",
                    "Bạn có thể trích một phần số dư vào quỹ dự phòng hoặc tiết kiệm.",
                    "info",
                    "piggy-bank");
            }

            dt.Rows.Add(
                "AI sẵn sàng hỗ trợ",
                "Vào mục Gợi ý AI để phân tích chi tiêu và nhận lời khuyên cá nhân hóa.",
                "info",
                "sparkles");

            rpNotify.DataSource = dt;
            rpNotify.DataBind();
        }

        void LoadChart()
        {
            if (Session["Khach"] != null)
            {
                hfChartLabels.Value = "T2|T3|T4|T5|T6|T7|CN";
                hfChartValues.Value = "120|200|150|300|250|220|180";
                return;
            }

            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                SELECT TOP 7
                    CONVERT(VARCHAR(10), NgayGiaoDich, 103) AS Ngay,
                    SUM(SoTien) AS TongChi
                FROM GiaoDich
                WHERE MaND=@MaND
                AND Loai=N'Chi'
                GROUP BY NgayGiaoDich
                ORDER BY NgayGiaoDich DESC";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                SqlDataReader rd = cmd.ExecuteReader();

                StringBuilder labels = new StringBuilder();
                StringBuilder values = new StringBuilder();

                while (rd.Read())
                {
                    if (labels.Length > 0)
                    {
                        labels.Append("|");
                        values.Append("|");
                    }

                    labels.Append(rd["Ngay"].ToString());
                    values.Append(Convert.ToDecimal(rd["TongChi"]).ToString("0"));
                }

                rd.Close();

                if (labels.Length == 0)
                {
                    hfChartLabels.Value = "T2|T3|T4|T5|T6|T7|CN";
                    hfChartValues.Value = "0|0|0|0|0|0|0";
                }
                else
                {
                    hfChartLabels.Value = labels.ToString();
                    hfChartValues.Value = values.ToString();
                }
            }
            finally
            {
                CloseConn();
            }
        }

        DataTable CreateTransactionTable()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("Desc");
            dt.Columns.Add("Sub");
            dt.Columns.Add("Amount");
            dt.Columns.Add("IsIncome", typeof(bool));
            dt.Columns.Add("Category");

            return dt;
        }

        void AddGuestTransaction(DataTable dt, string desc, string category, string amount, bool isIncome)
        {
            DataRow row = dt.NewRow();

            row["Desc"] = desc;
            row["Sub"] = category + " • Demo";
            row["Amount"] = amount;
            row["IsIncome"] = isIncome;
            row["Category"] = category;

            dt.Rows.Add(row);
        }

        void FilterMemoryTable(DataTable dt, string keyword, string category)
        {
            if (keyword == "" && category == "")
            {
                return;
            }

            for (int i = dt.Rows.Count - 1; i >= 0; i--)
            {
                string desc = dt.Rows[i]["Desc"].ToString().ToLower();
                string cat = dt.Rows[i]["Category"].ToString();

                bool okKeyword = keyword == "" || desc.Contains(keyword) || cat.ToLower().Contains(keyword);
                bool okCategory = category == "" || cat == category;

                if (!okKeyword || !okCategory)
                {
                    dt.Rows.RemoveAt(i);
                }
            }
        }

        void BindTransaction(DataTable dt)
        {
            rpTransaction.DataSource = dt;
            rpTransaction.DataBind();

            pnEmpty.Visible = dt.Rows.Count == 0;
        }

        decimal ParseMoney(string text)
        {
            string s = text
                .Replace("đ", "")
                .Replace(" ", "")
                .Replace(",", "")
                .Replace(".", "");

            decimal result = 0;
            decimal.TryParse(s, out result);

            return result;
        }

        string GetCategoryIcon(string name)
        {
            string n = name.ToLower();

            if (n.Contains("ăn") || n.Contains("uong") || n.Contains("uống"))
                return "utensils";

            if (n.Contains("mua") || n.Contains("sắm"))
                return "shopping-bag";

            if (n.Contains("di") || n.Contains("xe"))
                return "car";

            if (n.Contains("lương") || n.Contains("thu"))
                return "briefcase";

            if (n.Contains("học"))
                return "book-open";

            return "folder";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadRecentTransaction();
        }

        protected void FilterChanged(object sender, EventArgs e)
        {
            LoadRecentTransaction();
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Redirect("login.aspx");
        }

        void CloseConn()
        {
            if (db.conn.State == ConnectionState.Open)
            {
                db.conn.Close();
            }
        }
    }
}