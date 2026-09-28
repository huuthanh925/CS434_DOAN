using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyChiTieuThongMinh
{
    public partial class admin : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["MaND"] == null || Session["VaiTro"] == null || Session["VaiTro"].ToString() != "Admin")
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblAdminName.Text = Session["HoTen"] == null ? "Admin" : Session["HoTen"].ToString();

                LoadDashboard();
                LoadUsers();
                LoadCategories();
                LoadReports();
                LoadActivity();

                SetActivePanel("dashboard");
            }
        }

        void SetActivePanel(string panel)
        {
            pDashboard.CssClass = "section";
            pUsers.CssClass = "section";
            pCategories.CssClass = "section";
            pReports.CssClass = "section";
            pActivity.CssClass = "section";

            btnDash.CssClass = "nav-btn";
            btnUsers.CssClass = "nav-btn";
            btnCategories.CssClass = "nav-btn";
            btnReports.CssClass = "nav-btn";
            btnActivity.CssClass = "nav-btn";

            if (panel == "dashboard") { pDashboard.CssClass = "section active"; btnDash.CssClass = "nav-btn active"; }
            if (panel == "users") { pUsers.CssClass = "section active"; btnUsers.CssClass = "nav-btn active"; }
            if (panel == "categories") { pCategories.CssClass = "section active"; btnCategories.CssClass = "nav-btn active"; }
            if (panel == "reports") { pReports.CssClass = "section active"; btnReports.CssClass = "nav-btn active"; }
            if (panel == "activity") { pActivity.CssClass = "section active"; btnActivity.CssClass = "nav-btn active"; }
        }

        protected void ShowDashboard(object sender, EventArgs e) { LoadDashboard(); SetActivePanel("dashboard"); }
        protected void ShowUsers(object sender, EventArgs e) { LoadUsers(); SetActivePanel("users"); }
        protected void ShowCategories(object sender, EventArgs e) { LoadCategories(); SetActivePanel("categories"); }
        protected void ShowReports(object sender, EventArgs e) { LoadReports(); SetActivePanel("reports"); }
        protected void ShowActivity(object sender, EventArgs e) { LoadActivity(); SetActivePanel("activity"); }

        void LoadDashboard()
        {
            try
            {
                Open();

                lblTotalUsers.Text = Scalar("SELECT COUNT(*) FROM NguoiDung").ToString();
                lblTotalTransactions.Text = Scalar("SELECT COUNT(*) FROM GiaoDich").ToString();

                decimal income = Convert.ToDecimal(Scalar("SELECT ISNULL(SUM(SoTien),0) FROM GiaoDich WHERE Loai=N'Thu'"));
                decimal expense = Convert.ToDecimal(Scalar("SELECT ISNULL(SUM(SoTien),0) FROM GiaoDich WHERE Loai=N'Chi'"));

                lblTotalIncome.Text = income.ToString("N0") + "đ";
                lblTotalExpense.Text = expense.ToString("N0") + "đ";

                Bind("SELECT TOP 5 HoTen, Email, VaiTro, NgayTao FROM NguoiDung ORDER BY NgayTao DESC", rpNewUsers);
                Bind("SELECT TOP 5 MoTa, Loai, SoTien FROM GiaoDich ORDER BY NgayTao DESC", rpRecentTransactions);
            }
            finally { Close(); }
        }

        void LoadUsers()
        {
            try
            {
                Open();

                string sql = @"
                SELECT MaND, TenDangNhap, HoTen, Email, SoDienThoai, VaiTro, TrangThai, NgayTao
                FROM NguoiDung
                ORDER BY MaND DESC";

                Bind(sql, rpUsers);
            }
            finally { Close(); }
        }

        void LoadCategories()
        {
            try
            {
                Open();

                string sql = @"
                SELECT 
                    MaDM,
                    TenDanhMuc,
                    Loai,
                    ISNULL(Icon,'circle-dollar-sign') AS Icon,
                    MoTa,
                    TrangThai
                FROM DanhMuc
                ORDER BY MaDM DESC";

                Bind(sql, rpCategories);
            }
            finally { Close(); }
        }

        void LoadReports()
        {
            try
            {
                Open();
                Bind("SELECT TOP 10 * FROM HoTro ORDER BY ThoiGian DESC", rpReports);
            }
            finally { Close(); }
        }

        void LoadActivity()
        {
            try
            {
                Open();

                string sql = @"
                SELECT TOP 50 
                    ls.HanhDong,
                    ls.ThoiGian,
                    nd.HoTen,
                    nd.Email
                FROM LichSu ls
                LEFT JOIN NguoiDung nd ON ls.MaND = nd.MaND
                ORDER BY ls.ThoiGian DESC";

                Bind(sql, rpActivity);
            }
            finally { Close(); }
        }

        protected void SaveUser_Click(object sender, EventArgs e)
        {
            try
            {
                Open();

                if (hdUserID.Value == "")
                {
                    string checkSql = "SELECT COUNT(*) FROM NguoiDung WHERE Email=@Email";
                    SqlCommand check = new SqlCommand(checkSql, db.conn);
                    check.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                    int exists = Convert.ToInt32(check.ExecuteScalar());

                    if (exists > 0)
                    {
                        Alert("Email đã tồn tại");
                        return;
                    }

                    string sql = @"
                    INSERT INTO NguoiDung
                    (
                        TenDangNhap,
                        MatKhau,
                        Email,
                        SoDienThoai,
                        HoTen,
                        VaiTro,
                        TrangThai
                    )
                    VALUES
                    (
                        @TenDangNhap,
                        @MatKhau,
                        @Email,
                        @SoDienThoai,
                        @HoTen,
                        @VaiTro,
                        @TrangThai
                    )";

                    SqlCommand cmd = new SqlCommand(sql, db.conn);
                    AddUserParams(cmd);
                    cmd.ExecuteNonQuery();

                    AddLog("Admin thêm người dùng: " + txtEmail.Text.Trim());
                }
                else
                {
                    string sql = @"
                    UPDATE NguoiDung
                    SET
                        TenDangNhap=@TenDangNhap,
                        Email=@Email,
                        SoDienThoai=@SoDienThoai,
                        HoTen=@HoTen,
                        VaiTro=@VaiTro,
                        TrangThai=@TrangThai"
                        + (txtPassword.Text.Trim() != "" ? ", MatKhau=@MatKhau " : " ")
                    + "WHERE MaND=@MaND";

                    SqlCommand cmd = new SqlCommand(sql, db.conn);

                    cmd.Parameters.AddWithValue("@MaND", hdUserID.Value);
                    cmd.Parameters.AddWithValue("@TenDangNhap", txtUserName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@SoDienThoai", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@HoTen", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@VaiTro", ddlRole.SelectedValue);
                    cmd.Parameters.AddWithValue("@TrangThai", ddlUserStatus.SelectedValue);

                    if (txtPassword.Text.Trim() != "")
                    {
                        cmd.Parameters.AddWithValue("@MatKhau", txtPassword.Text.Trim());
                    }

                    cmd.ExecuteNonQuery();

                    AddLog("Admin cập nhật người dùng: " + txtEmail.Text.Trim());
                }

                ClearUserForm();
                LoadUsers();
                SetActivePanel("users");
            }
            catch (Exception ex) { Alert(ex.Message); }
            finally { Close(); }
        }

        void AddUserParams(SqlCommand cmd)
        {
            cmd.Parameters.AddWithValue("@TenDangNhap", txtUserName.Text.Trim());
            cmd.Parameters.AddWithValue("@MatKhau", txtPassword.Text.Trim() == "" ? "123" : txtPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@SoDienThoai", txtPhone.Text.Trim());
            cmd.Parameters.AddWithValue("@HoTen", txtFullName.Text.Trim());
            cmd.Parameters.AddWithValue("@VaiTro", ddlRole.SelectedValue);
            cmd.Parameters.AddWithValue("@TrangThai", ddlUserStatus.SelectedValue);
        }

        protected void EditUser(object sender, CommandEventArgs e)
        {
            try
            {
                Open();

                string sql = "SELECT * FROM NguoiDung WHERE MaND=@ID";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@ID", e.CommandArgument.ToString());

                SqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    hdUserID.Value = rd["MaND"].ToString();
                    txtUserName.Text = rd["TenDangNhap"].ToString();
                    txtFullName.Text = rd["HoTen"].ToString();
                    txtEmail.Text = rd["Email"].ToString();
                    txtPhone.Text = rd["SoDienThoai"].ToString();
                    ddlRole.SelectedValue = rd["VaiTro"].ToString();
                    ddlUserStatus.SelectedValue = rd["TrangThai"].ToString();
                    txtPassword.Text = "";
                }

                rd.Close();
                SetActivePanel("users");
            }
            finally { Close(); }
        }

        protected void ToggleUser(object sender, CommandEventArgs e)
        {
            try
            {
                Open();

                string sql = @"
                UPDATE NguoiDung
                SET TrangThai = CASE WHEN TrangThai='Khoa' THEN 'HoatDong' ELSE 'Khoa' END
                WHERE MaND=@ID";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@ID", e.CommandArgument.ToString());
                cmd.ExecuteNonQuery();

                AddLog("Admin đổi trạng thái người dùng ID: " + e.CommandArgument.ToString());

                LoadUsers();
                SetActivePanel("users");
            }
            finally { Close(); }
        }

        protected void ClearUser_Click(object sender, EventArgs e)
        {
            ClearUserForm();
            SetActivePanel("users");
        }

        void ClearUserForm()
        {
            hdUserID.Value = "";
            txtUserName.Text = "";
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtPassword.Text = "";
            ddlRole.SelectedIndex = 0;
            ddlUserStatus.SelectedIndex = 0;
        }

        protected void SaveCategory_Click(object sender, EventArgs e)
        {
            try
            {
                Open();

                if (hdCategoryID.Value == "")
                {
                    string sql = @"
                    INSERT INTO DanhMuc
                    (
                        TenDanhMuc,
                        Loai,
                        Icon,
                        MoTa,
                        TrangThai
                    )
                    VALUES
                    (
                        @Ten,
                        @Loai,
                        @Icon,
                        @MoTa,
                        @TrangThai
                    )";

                    SqlCommand cmd = new SqlCommand(sql, db.conn);
                    AddCategoryParams(cmd);
                    cmd.ExecuteNonQuery();

                    AddLog("Admin thêm danh mục: " + txtCategoryName.Text.Trim());
                }
                else
                {
                    string sql = @"
                    UPDATE DanhMuc
                    SET
                        TenDanhMuc=@Ten,
                        Loai=@Loai,
                        Icon=@Icon,
                        MoTa=@MoTa,
                        TrangThai=@TrangThai
                    WHERE MaDM=@ID";

                    SqlCommand cmd = new SqlCommand(sql, db.conn);
                    cmd.Parameters.AddWithValue("@ID", hdCategoryID.Value);
                    AddCategoryParams(cmd);
                    cmd.ExecuteNonQuery();

                    AddLog("Admin cập nhật danh mục: " + txtCategoryName.Text.Trim());
                }

                ClearCategoryForm();
                LoadCategories();
                SetActivePanel("categories");
            }
            catch (Exception ex) { Alert(ex.Message); }
            finally { Close(); }
        }

        void AddCategoryParams(SqlCommand cmd)
        {
            string icon = txtCategoryIcon.Text.Trim();

            if (icon == "")
            {
                icon = CategoryIconHelper.GetIcon(txtCategoryName.Text.Trim());
            }

            cmd.Parameters.AddWithValue("@Ten", txtCategoryName.Text.Trim());
            cmd.Parameters.AddWithValue("@Loai", ddlCategoryType.SelectedValue);
            cmd.Parameters.AddWithValue("@Icon", icon);
            cmd.Parameters.AddWithValue("@MoTa", txtCategoryDesc.Text.Trim());
            cmd.Parameters.AddWithValue("@TrangThai", ddlCategoryStatus.SelectedValue);
        }

        protected void EditCategory(object sender, CommandEventArgs e)
        {
            try
            {
                Open();

                string sql = "SELECT * FROM DanhMuc WHERE MaDM=@ID";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@ID", e.CommandArgument.ToString());

                SqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    hdCategoryID.Value = rd["MaDM"].ToString();
                    txtCategoryName.Text = rd["TenDanhMuc"].ToString();
                    ddlCategoryType.SelectedValue = rd["Loai"].ToString();
                    txtCategoryIcon.Text = rd["Icon"].ToString();
                    txtCategoryDesc.Text = rd["MoTa"].ToString();
                    ddlCategoryStatus.SelectedValue = rd["TrangThai"].ToString();
                }

                rd.Close();
                SetActivePanel("categories");
            }
            finally { Close(); }
        }

        protected void DeleteCategory(object sender, CommandEventArgs e)
        {
            try
            {
                Open();

                string checkSql = "SELECT COUNT(*) FROM GiaoDich WHERE MaDM=@ID";
                SqlCommand check = new SqlCommand(checkSql, db.conn);
                check.Parameters.AddWithValue("@ID", e.CommandArgument.ToString());

                int exists = Convert.ToInt32(check.ExecuteScalar());

                if (exists > 0)
                {
                    Alert("Danh mục đã có giao dịch, không thể xóa.");
                    SetActivePanel("categories");
                    return;
                }

                string sql = "DELETE FROM DanhMuc WHERE MaDM=@ID";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@ID", e.CommandArgument.ToString());
                cmd.ExecuteNonQuery();

                AddLog("Admin xóa danh mục ID: " + e.CommandArgument.ToString());

                LoadCategories();
                SetActivePanel("categories");
            }
            finally { Close(); }
        }

        void ClearCategoryForm()
        {
            hdCategoryID.Value = "";
            txtCategoryName.Text = "";
            txtCategoryIcon.Text = "";
            txtCategoryDesc.Text = "";
            ddlCategoryType.SelectedIndex = 0;
            ddlCategoryStatus.SelectedIndex = 0;
        }

        protected void CreateReport_Click(object sender, EventArgs e)
        {
            try
            {
                Open();

                int totalUsers = Convert.ToInt32(Scalar("SELECT COUNT(*) FROM NguoiDung"));
                int totalGD = Convert.ToInt32(Scalar("SELECT COUNT(*) FROM GiaoDich"));
                decimal totalThu = Convert.ToDecimal(Scalar("SELECT ISNULL(SUM(SoTien),0) FROM GiaoDich WHERE Loai=N'Thu'"));
                decimal totalChi = Convert.ToDecimal(Scalar("SELECT ISNULL(SUM(SoTien),0) FROM GiaoDich WHERE Loai=N'Chi'"));

                string content =
                    "Báo cáo hệ thống tự động\n"
                    + "Tổng người dùng: " + totalUsers + "\n"
                    + "Tổng giao dịch: " + totalGD + "\n"
                    + "Tổng thu: " + totalThu.ToString("N0") + "đ\n"
                    + "Tổng chi: " + totalChi.ToString("N0") + "đ\n"
                    + "Số dư toàn hệ thống: " + (totalThu - totalChi).ToString("N0") + "đ\n"
                    + "Thời gian tạo: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm");

                string sql = @"
                INSERT INTO HoTro
                (
                    MaND,
                    NoiDung,
                    TongNguoiDung,
                    TongGiaoDich,
                    TongThu,
                    TongChi
                )
                VALUES
                (
                    @MaND,
                    @NoiDung,
                    @TongNguoiDung,
                    @TongGiaoDich,
                    @TongThu,
                    @TongChi
                )";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);
                cmd.Parameters.AddWithValue("@NoiDung", content);
                cmd.Parameters.AddWithValue("@TongNguoiDung", totalUsers);
                cmd.Parameters.AddWithValue("@TongGiaoDich", totalGD);
                cmd.Parameters.AddWithValue("@TongThu", totalThu);
                cmd.Parameters.AddWithValue("@TongChi", totalChi);
                cmd.ExecuteNonQuery();

                ltReport.Text = content.Replace("\n", "<br/>");

                AddLog("Admin tạo báo cáo hệ thống");

                LoadReports();
                SetActivePanel("reports");
            }
            catch (Exception ex) { Alert(ex.Message); }
            finally { Close(); }
        }

        void AddLog(string action)
        {
            string sql = @"
            INSERT INTO LichSu
            (
                MaND,
                HanhDong
            )
            VALUES
            (
                @MaND,
                @HanhDong
            )";

            SqlCommand cmd = new SqlCommand(sql, db.conn);
            cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);
            cmd.Parameters.AddWithValue("@HanhDong", action);
            cmd.ExecuteNonQuery();
        }

        object Scalar(string sql)
        {
            SqlCommand cmd = new SqlCommand(sql, db.conn);
            return cmd.ExecuteScalar();
        }

        void Bind(string sql, Repeater rp)
        {
            SqlDataAdapter da = new SqlDataAdapter(sql, db.conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rp.DataSource = dt;
            rp.DataBind();
        }

        void Open()
        {
            if (db.conn.State == ConnectionState.Closed)
            {
                db.conn.Open();
            }
        }

        void Close()
        {
            if (db.conn.State == ConnectionState.Open)
            {
                db.conn.Close();
            }
        }

        void Alert(string msg)
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "alert",
                "alert('" + msg.Replace("'", "") + "');",
                true);
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("login.aspx");
        }
    }
}