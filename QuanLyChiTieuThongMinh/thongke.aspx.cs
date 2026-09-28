using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Text;

namespace QuanLyChiTieuThongMinh
{
    public partial class thongke : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] == null && Session["Khach"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                txtTuNgay.Text = DateTime.Now.AddDays(-6).ToString("yyyy-MM-dd");
                txtDenNgay.Text = DateTime.Now.ToString("yyyy-MM-dd");

                LoadThongKe();
            }
        }

        protected void btnLocKhoangNgay_Click(object sender, EventArgs e)
        {
            LoadThongKe();
        }

        void LoadThongKe()
        {
            try
            {
                if (Session["Khach"] != null)
                {
                    LoadDemoData();
                    return;
                }

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                int maND = Convert.ToInt32(Session["MaND"]);

                decimal income = GetTotal(maND, "Thu");
                decimal expense = GetTotal(maND, "Chi");

                decimal balance = income - expense;
                decimal rate = income > 0 ? (balance / income) * 100 : 0;

                lblIncome.Text = income.ToString("N0") + " đ";
                lblExpense.Text = expense.ToString("N0") + " đ";
                lblBalance.Text = balance.ToString("N0") + " đ";
                lblRate.Text = rate.ToString("0") + "%";

                litTotalIncome.Text = income.ToString(CultureInfo.InvariantCulture);
                litTotalExpense.Text = expense.ToString(CultureInfo.InvariantCulture);

                LoadThongKeTheoKhoangNgay(maND);
                LoadChartTheoKhoangNgay(maND);
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('" +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
            finally
            {
                if (db.conn.State == ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        decimal GetTotal(int maND, string loai)
        {
            string sql =
            @"SELECT ISNULL(SUM(SoTien),0)
              FROM GiaoDich
              WHERE MaND=@MaND
              AND Loai=@Loai";

            SqlCommand cmd = new SqlCommand(sql, db.conn);

            cmd.Parameters.AddWithValue("@MaND", maND);
            cmd.Parameters.AddWithValue("@Loai", loai);

            return Convert.ToDecimal(cmd.ExecuteScalar());
        }

        void LoadThongKeTheoKhoangNgay(int maND)
        {
            DateTime tuNgay;
            DateTime denNgay;

            GetRangeDate(out tuNgay, out denNgay);

            string sql =
            @"SELECT
                ISNULL(SUM(CASE WHEN Loai=N'Thu' THEN SoTien ELSE 0 END),0) AS TongThu,
                ISNULL(SUM(CASE WHEN Loai=N'Chi' THEN SoTien ELSE 0 END),0) AS TongChi
              FROM GiaoDich
              WHERE MaND=@MaND
              AND CONVERT(date, NgayGiaoDich) >= @TuNgay
              AND CONVERT(date, NgayGiaoDich) <= @DenNgay";

            SqlCommand cmd = new SqlCommand(sql, db.conn);

            cmd.Parameters.AddWithValue("@MaND", maND);
            cmd.Parameters.AddWithValue("@TuNgay", tuNgay.Date);
            cmd.Parameters.AddWithValue("@DenNgay", denNgay.Date);

            SqlDataReader rd = cmd.ExecuteReader();

            decimal rangeIncome = 0;
            decimal rangeExpense = 0;

            if (rd.Read())
            {
                rangeIncome = Convert.ToDecimal(rd["TongThu"]);
                rangeExpense = Convert.ToDecimal(rd["TongChi"]);
            }

            rd.Close();

            lblRangeIncome.Text = rangeIncome.ToString("N0") + " đ";
            lblRangeExpense.Text = rangeExpense.ToString("N0") + " đ";
            lblRangeBalance.Text = (rangeIncome - rangeExpense).ToString("N0") + " đ";
        }

        void LoadChartTheoKhoangNgay(int maND)
        {
            DateTime tuNgay;
            DateTime denNgay;

            GetRangeDate(out tuNgay, out denNgay);

            string sql =
            @"SELECT
                CONVERT(date, NgayGiaoDich) AS Ngay,
                ISNULL(SUM(CASE WHEN Loai=N'Thu' THEN SoTien ELSE 0 END),0) AS TongThu,
                ISNULL(SUM(CASE WHEN Loai=N'Chi' THEN SoTien ELSE 0 END),0) AS TongChi
              FROM GiaoDich
              WHERE MaND=@MaND
              AND CONVERT(date, NgayGiaoDich) >= @TuNgay
              AND CONVERT(date, NgayGiaoDich) <= @DenNgay
              GROUP BY CONVERT(date, NgayGiaoDich)
              ORDER BY Ngay ASC";

            SqlCommand cmd = new SqlCommand(sql, db.conn);

            cmd.Parameters.AddWithValue("@MaND", maND);
            cmd.Parameters.AddWithValue("@TuNgay", tuNgay.Date);
            cmd.Parameters.AddWithValue("@DenNgay", denNgay.Date);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            StringBuilder labels = new StringBuilder();
            StringBuilder incomeData = new StringBuilder();
            StringBuilder expenseData = new StringBuilder();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow row = dt.Rows[i];

                labels.Append("'" + Convert.ToDateTime(row["Ngay"]).ToString("dd/MM") + "'");
                incomeData.Append(Convert.ToDecimal(row["TongThu"]).ToString(CultureInfo.InvariantCulture));
                expenseData.Append(Convert.ToDecimal(row["TongChi"]).ToString(CultureInfo.InvariantCulture));

                if (i < dt.Rows.Count - 1)
                {
                    labels.Append(",");
                    incomeData.Append(",");
                    expenseData.Append(",");
                }
            }

            if (dt.Rows.Count == 0)
            {
                labels.Append("'" + tuNgay.ToString("dd/MM") + "'");
                incomeData.Append("0");
                expenseData.Append("0");
            }

            litRangeLabels.Text = labels.ToString();
            litRangeIncomeData.Text = incomeData.ToString();
            litRangeExpenseData.Text = expenseData.ToString();
        }

        void GetRangeDate(out DateTime tuNgay, out DateTime denNgay)
        {
            if (!DateTime.TryParse(txtTuNgay.Text, out tuNgay))
            {
                tuNgay = DateTime.Now.AddDays(-6);
                txtTuNgay.Text = tuNgay.ToString("yyyy-MM-dd");
            }

            if (!DateTime.TryParse(txtDenNgay.Text, out denNgay))
            {
                denNgay = DateTime.Now;
                txtDenNgay.Text = denNgay.ToString("yyyy-MM-dd");
            }

            if (tuNgay > denNgay)
            {
                DateTime temp = tuNgay;
                tuNgay = denNgay;
                denNgay = temp;

                txtTuNgay.Text = tuNgay.ToString("yyyy-MM-dd");
                txtDenNgay.Text = denNgay.ToString("yyyy-MM-dd");
            }
        }

        void LoadDemoData()
        {
            decimal income = 25000000;
            decimal expense = 8300000;
            decimal balance = income - expense;
            decimal rate = (balance / income) * 100;

            lblIncome.Text = income.ToString("N0") + " đ";
            lblExpense.Text = expense.ToString("N0") + " đ";
            lblBalance.Text = balance.ToString("N0") + " đ";
            lblRate.Text = rate.ToString("0") + "%";

            lblRangeIncome.Text = "12,700,000 đ";
            lblRangeExpense.Text = "3,960,000 đ";
            lblRangeBalance.Text = "8,740,000 đ";

            litTotalIncome.Text = income.ToString(CultureInfo.InvariantCulture);
            litTotalExpense.Text = expense.ToString(CultureInfo.InvariantCulture);

            litRangeLabels.Text = "'T2','T3','T4','T5','T6','T7','CN'";
            litRangeIncomeData.Text = "3000000,1500000,0,4500000,0,2500000,1200000";
            litRangeExpenseData.Text = "350000,420000,1200000,180000,560000,900000,350000";
        }
    }
}