using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data.SqlClient;
using System.IO;

namespace QuanLyChiTieuThongMinh
{
    public partial class taikhoan : System.Web.UI.Page
    {
        DB db = new DB();

        protected void Page_Load(object sender, EventArgs e)
        {
            // KHÁCH VÃNG LAI
            if (Session["MaND"] == null &&
                Session["Khach"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // DEMO KHÁCH
                if (Session["Khach"] != null)
                {
                    LoadGuestDemo();
                }
                else
                {
                    LoadUser();
                }
            }
        }

        // ======================
        // DEMO KHÁCH VÃNG LAI
        // ======================

        void LoadGuestDemo()
        {
            lblName.Text = "Khách vãng lai";

            txtName.Text = "Khách trải nghiệm";

            txtEmail.Text = "guest@demo.com";

            txtPhone.Text = "0123456789";

            ddlLang.SelectedIndex = 0;

            imgAvatar.Visible = false;

            lblAvatar.Visible = true;

            lblAvatar.Text = "G";
        }

        // ======================
        // LOAD USER
        // ======================

        void LoadUser()
        {
            try
            {
                if (db.conn.State ==
                    System.Data.ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql =
                @"SELECT
                    HoTen,
                    Email,
                    SoDienThoai,
                    Avatar
                  FROM NguoiDung
                  WHERE MaND=@id";

                SqlCommand cmd =
                    new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue(
                    "@id",
                    Session["MaND"]);

                SqlDataReader dr =
                    cmd.ExecuteReader();

                if (dr.Read())
                {
                    string hoTen =
                        dr["HoTen"].ToString();

                    string email =
                        dr["Email"].ToString();

                    string phone =
                        dr["SoDienThoai"] == DBNull.Value
                        ? ""
                        : dr["SoDienThoai"].ToString();

                    string avatar =
                        dr["Avatar"] == DBNull.Value
                        ? ""
                        : dr["Avatar"].ToString();

                    lblName.Text = hoTen;

                    txtName.Text = hoTen;

                    txtEmail.Text = email;

                    txtPhone.Text = phone;

                    // ======================
                    // AVATAR
                    // ======================

                    if (!string.IsNullOrEmpty(avatar))
                    {
                        imgAvatar.ImageUrl = avatar;

                        imgAvatar.Visible = true;

                        lblAvatar.Visible = false;
                    }
                    else
                    {
                        imgAvatar.Visible = false;

                        lblAvatar.Visible = true;

                        lblAvatar.Text =
                            hoTen.Length > 0
                            ? hoTen.Substring(0, 1).ToUpper()
                            : "U";
                    }
                }

                dr.Close();
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
                if (db.conn.State ==
                    System.Data.ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        // ======================
        // UPLOAD AVATAR
        // ======================

        protected void UploadAvatar(
            object sender,
            EventArgs e)
        {
            // KHÁCH KHÔNG CHO UPLOAD
            if (Session["Khach"] != null)
            {
                Response.Write(
                "<script>alert('Khách vãng lai không thể cập nhật ảnh');</script>");

                return;
            }

            if (!fileAvatar.HasFile)
            {
                Response.Write(
                "<script>alert('Vui lòng chọn ảnh');</script>");

                return;
            }

            try
            {
                string folder = "/images/";

                string fileName =
                    Guid.NewGuid().ToString()
                    + Path.GetExtension(
                        fileAvatar.FileName);

                string filePath =
                    folder + fileName;

                string physicalPath =
                    Server.MapPath(filePath);

                fileAvatar.SaveAs(physicalPath);

                if (db.conn.State ==
                    System.Data.ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql =
                @"UPDATE NguoiDung
                  SET Avatar=@Avatar
                  WHERE MaND=@id";

                SqlCommand cmd =
                    new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue(
                    "@Avatar",
                    filePath);

                cmd.Parameters.AddWithValue(
                    "@id",
                    Session["MaND"]);

                cmd.ExecuteNonQuery();

                Response.Write(
                "<script>alert('Cập nhật ảnh thành công');</script>");
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
                if (db.conn.State ==
                    System.Data.ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }

            LoadUser();
        }

        // ======================
        // LƯU THÔNG TIN
        // ======================

        protected void Save_Click(
            object sender,
            EventArgs e)
        {
            // KHÁCH DEMO
            if (Session["Khach"] != null)
            {
                Response.Write(
                "<script>alert('Chế độ khách không thể lưu dữ liệu');</script>");

                return;
            }

            try
            {
                if (db.conn.State ==
                    System.Data.ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql =
                @"UPDATE NguoiDung
                  SET
                    HoTen=@name,
                    SoDienThoai=@phone
                  WHERE MaND=@id";

                SqlCommand cmd =
                    new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue(
                    "@name",
                    txtName.Text.Trim());

                cmd.Parameters.AddWithValue(
                    "@phone",
                    txtPhone.Text.Trim());

                cmd.Parameters.AddWithValue(
                    "@id",
                    Session["MaND"]);

                cmd.ExecuteNonQuery();

                Response.Write(
                "<script>alert('Lưu thành công');</script>");
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
                if (db.conn.State ==
                    System.Data.ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }

            LoadUser();
        }

        // ======================
        // LOGOUT
        // ======================

        protected void Logout_Click(
            object sender,
            EventArgs e)
        {
            Session.Clear();

            Session.Abandon();

            Response.Redirect("login.aspx");
        }
    }
}