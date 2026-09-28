using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data.SqlClient;

namespace QuanLyChiTieuThongMinh
{
    public partial class forgot : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                string email =
                    txtEmail.Text.Trim();

                if (string.IsNullOrEmpty(email))
                {
                    Response.Write(
                    "<script>alert('Vui lòng nhập email');</script>");
                    return;
                }

                db.conn.Open();

                string sql = @"
                SELECT COUNT(*)
                FROM NGUOIDUNG
                WHERE Email=@Email";

                SqlCommand cmd =
                    new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue(
                    "@Email",
                    email);

                int exists =
                    (int)cmd.ExecuteScalar();

                db.conn.Close();

                if (exists > 0)
                {
                    Response.Write(
                    "<script>alert('Đã gửi yêu cầu khôi phục mật khẩu');</script>");
                }
                else
                {
                    Response.Write(
                    "<script>alert('Email không tồn tại');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('" +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}