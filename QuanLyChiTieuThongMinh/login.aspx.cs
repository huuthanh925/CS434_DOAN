using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data.SqlClient;

namespace QuanLyChiTieuThongMinh
{
    public partial class login : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // =========================================
        // ĐĂNG NHẬP
        // =========================================

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();
                string matKhau = txtPassword.Text.Trim();

                if (email == "" || matKhau == "")
                {
                    Response.Write(
                    "<script>alert('Vui lòng nhập đầy đủ thông tin');</script>");
                    return;
                }

                using (SqlConnection conn = db.conn)
                {
                    conn.Open();

                    // =========================
                    // TÌM TÀI KHOẢN THEO EMAIL HOẶC TÊN ĐĂNG NHẬP
                    // =========================

                    string sql = @"
                    SELECT TOP 1 *
                    FROM NguoiDung
                    WHERE 
                        LTRIM(RTRIM(Email)) = @Email
                        OR LTRIM(RTRIM(TenDangNhap)) = @Email";

                    SqlCommand cmd = new SqlCommand(sql, conn);

                    cmd.Parameters.AddWithValue(
                        "@Email",
                        email);

                    SqlDataReader rd = cmd.ExecuteReader();

                    if (!rd.Read())
                    {
                        rd.Close();

                        Response.Write(
                        "<script>alert('Email hoặc tên đăng nhập chưa tồn tại');</script>");
                        return;
                    }

                    // =========================
                    // KIỂM TRA MẬT KHẨU
                    // =========================

                    string dbMatKhau =
                        rd["MatKhau"] == DBNull.Value
                        ? ""
                        : rd["MatKhau"].ToString().Trim();

                    if (dbMatKhau != matKhau)
                    {
                        rd.Close();

                        Response.Write(
                        "<script>alert('Sai mật khẩu');</script>");
                        return;
                    }

                    // =========================
                    // KIỂM TRA TRẠNG THÁI
                    // Chỉ chặn tài khoản bị khóa
                    // =========================

                    string trangThai =
                        rd["TrangThai"] == DBNull.Value
                        ? ""
                        : rd["TrangThai"].ToString().Trim();

                    string tt =
                        trangThai.ToLower();

                    if (
                        tt == "khoa" ||
                        tt == "khóa" ||
                        tt == "locked" ||
                        tt == "blocked" ||
                        tt == "ban" ||
                        tt == "banned"
                    )
                    {
                        rd.Close();

                        Response.Write(
                        "<script>alert('Tài khoản đang bị khóa');</script>");
                        return;
                    }

                    // =========================
                    // LOGIN THÀNH CÔNG
                    // =========================

                    Session.Clear();

                    Session["MaND"] =
                        rd["MaND"].ToString();

                    Session["HoTen"] =
                        rd["HoTen"] == DBNull.Value ||
                        rd["HoTen"].ToString().Trim() == ""
                        ? "Người dùng"
                        : rd["HoTen"].ToString();

                    Session["Email"] =
                        rd["Email"] == DBNull.Value
                        ? email
                        : rd["Email"].ToString();

                    string vaiTro =
                        rd["VaiTro"] == DBNull.Value ||
                        rd["VaiTro"].ToString().Trim() == ""
                        ? "User"
                        : rd["VaiTro"].ToString().Trim();

                    Session["VaiTro"] =
                        vaiTro;

                    Session.Remove("Khach");

                    rd.Close();

                    // =========================
                    // PHÂN QUYỀN
                    // =========================

                    if (vaiTro.ToLower() == "admin")
                    {
                        Response.Redirect("admin.aspx");
                    }
                    else
                    {
                        Response.Redirect("trangchu.aspx");
                    }
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

        // =========================================
        // KHÁCH VÃNG LAI
        // =========================================

        protected void btnGuest_Click(object sender, EventArgs e)
        {
            Session.Clear();

            Session["Khach"] = "true";

            Session["HoTen"] =
                "Khách vãng lai";

            Session["VaiTro"] =
                "Guest";

            Response.Redirect(
                "trangchu.aspx");
        }

        // =========================================
        // ĐĂNG KÝ
        // =========================================

        protected void lnkRegister_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "dangky.aspx");
        }

        // =========================================
        // QUÊN MẬT KHẨU
        // =========================================

        protected void lnkForgot_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "forgot.aspx");
        }
    }
}