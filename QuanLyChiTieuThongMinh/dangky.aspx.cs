using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data.SqlClient;

namespace QuanLyChiTieuThongMinh
{
    public partial class dangky : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // =====================================
        // ĐĂNG KÝ
        // =====================================

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // =========================
                // KIỂM TRA RỖNG
                // =========================

                if (
                    txtEmail.Text.Trim() == "" ||
                    txtPassword.Text.Trim() == "" ||
                    txtConfirm.Text.Trim() == ""
                )
                {
                    Response.Write(
                    "<script>alert('Vui lòng nhập đầy đủ thông tin');</script>");

                    return;
                }

                // =========================
                // CHECK PASSWORD
                // =========================

                if (txtPassword.Text.Trim() !=
                    txtConfirm.Text.Trim())
                {
                    Response.Write(
                    "<script>alert('Mật khẩu không khớp');</script>");

                    return;
                }

                using (SqlConnection conn = db.conn)
                {
                    conn.Open();

                    string email =
                        txtEmail.Text.Trim();

                    string password =
                        txtPassword.Text.Trim();

                    string username =
                        email.Split('@')[0];

                    // =========================
                    // CHECK EMAIL
                    // =========================

                    string checkSql = @"
                    SELECT COUNT(*)
                    FROM NguoiDung
                    WHERE LTRIM(RTRIM(Email)) = @Email";

                    SqlCommand checkCmd =
                        new SqlCommand(checkSql, conn);

                    checkCmd.Parameters.AddWithValue(
                        "@Email",
                        email);

                    int exists =
                        Convert.ToInt32(
                        checkCmd.ExecuteScalar());

                    if (exists > 0)
                    {
                        Response.Write(
                        "<script>alert('Email đã tồn tại');</script>");

                        return;
                    }

                    // =========================
                    // INSERT USER
                    // =========================

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

                    SqlCommand cmd =
                        new SqlCommand(sql, conn);

                    cmd.Parameters.AddWithValue(
                        "@TenDangNhap",
                        username);

                    cmd.Parameters.AddWithValue(
                        "@MatKhau",
                        password);

                    cmd.Parameters.AddWithValue(
                        "@Email",
                        email);

                    cmd.Parameters.AddWithValue(
                        "@SoDienThoai",
                        "");

                    cmd.Parameters.AddWithValue(
                        "@HoTen",
                        "Người dùng");

                    cmd.Parameters.AddWithValue(
                        "@VaiTro",
                        "User");

                    cmd.Parameters.AddWithValue(
                        "@TrangThai",
                        "Hoạt động");

                    cmd.ExecuteNonQuery();

                    Response.Write(
                    "<script>alert('Đăng ký thành công');window.location='login.aspx';</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('"
                + ex.Message.Replace("'", "")
                + "');</script>");
            }
        }

        // =====================================
        // LOGIN
        // =====================================

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}