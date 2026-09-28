using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data;
using System.Data.SqlClient;

namespace QuanLyChiTieuThongMinh
{
    public partial class lichsu : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] == null &&
                Session["Khach"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                txtFrom.Text =
                    DateTime.Now
                    .AddMonths(-1)
                    .ToString("yyyy-MM-dd");

                txtTo.Text =
                    DateTime.Now
                    .ToString("yyyy-MM-dd");

                LoadData();
            }
        }

        void LoadData()
        {
            try
            {
                if (Session["Khach"] != null)
                {
                    LoadGuestData();
                    return;
                }

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                SELECT
                    gd.MaGD,
                    gd.SoTien,
                    gd.Loai,
                    gd.NgayGiaoDich,
                    gd.MoTa,
                    ISNULL(gd.TrangThai,N'Hoàn thành') AS TrangThai,
                    ISNULL(dm.TenDanhMuc,N'Khác') AS TenDanhMuc,
                    ISNULL(dm.Icon,'wallet') AS Icon
                FROM GiaoDich gd
                LEFT JOIN DanhMuc dm
                    ON gd.MaDM = dm.MaDM
                WHERE gd.MaND = @MaND";

                if (!string.IsNullOrEmpty(txtFrom.Text))
                {
                    sql += " AND gd.NgayGiaoDich >= @TuNgay";
                }

                if (!string.IsNullOrEmpty(txtTo.Text))
                {
                    sql += " AND gd.NgayGiaoDich <= @DenNgay";
                }

                if (!string.IsNullOrEmpty(ddlType.SelectedValue))
                {
                    sql += " AND gd.Loai = @Loai";
                }

                sql += " ORDER BY gd.NgayGiaoDich DESC, gd.MaGD DESC";

                SqlCommand cmd = new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue(
                    "@MaND",
                    Session["MaND"]);

                if (!string.IsNullOrEmpty(txtFrom.Text))
                {
                    cmd.Parameters.AddWithValue(
                        "@TuNgay",
                        txtFrom.Text);
                }

                if (!string.IsNullOrEmpty(txtTo.Text))
                {
                    cmd.Parameters.AddWithValue(
                        "@DenNgay",
                        txtTo.Text);
                }

                if (!string.IsNullOrEmpty(ddlType.SelectedValue))
                {
                    cmd.Parameters.AddWithValue(
                        "@Loai",
                        ddlType.SelectedValue);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                DataTable dt = new DataTable();

                da.Fill(dt);

                rpList.DataSource = dt;
                rpList.DataBind();

                pnlEmpty.Visible = dt.Rows.Count == 0;
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi lịch sử: "
                + ex.Message.Replace("'", "")
                + "');</script>");
            }
            finally
            {
                if (db.conn.State == ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        void LoadGuestData()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("MaGD", typeof(int));
            dt.Columns.Add("SoTien", typeof(decimal));
            dt.Columns.Add("Loai", typeof(string));
            dt.Columns.Add("NgayGiaoDich", typeof(DateTime));
            dt.Columns.Add("MoTa", typeof(string));
            dt.Columns.Add("TrangThai", typeof(string));
            dt.Columns.Add("TenDanhMuc", typeof(string));
            dt.Columns.Add("Icon", typeof(string));

            dt.Rows.Add(
                1,
                15000000,
                "Thu",
                DateTime.Now.AddDays(-1),
                "Lương tháng",
                "Hoàn thành",
                "Lương",
                "briefcase");

            dt.Rows.Add(
                2,
                350000,
                "Chi",
                DateTime.Now.AddDays(-2),
                "Ăn uống",
                "Hoàn thành",
                "Ăn uống",
                "utensils-crossed");

            dt.Rows.Add(
                3,
                1200000,
                "Chi",
                DateTime.Now.AddDays(-3),
                "Mua sắm",
                "Hoàn thành",
                "Mua sắm",
                "shopping-bag");

            dt.Rows.Add(
                4,
                4500000,
                "Thu",
                DateTime.Now.AddDays(-4),
                "Freelance",
                "Hoàn thành",
                "Freelance",
                "badge-dollar-sign");

            dt.Rows.Add(
                5,
                180000,
                "Chi",
                DateTime.Now.AddDays(-5),
                "Di chuyển",
                "Hoàn thành",
                "Di chuyển",
                "car");

            if (!string.IsNullOrEmpty(ddlType.SelectedValue))
            {
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    if (dt.Rows[i]["Loai"].ToString()
                        != ddlType.SelectedValue)
                    {
                        dt.Rows.RemoveAt(i);
                    }
                }
            }

            rpList.DataSource = dt;
            rpList.DataBind();

            pnlEmpty.Visible = dt.Rows.Count == 0;
        }

        protected void FilterData(object sender, EventArgs e)
        {
            LoadData();
        }
    }
}