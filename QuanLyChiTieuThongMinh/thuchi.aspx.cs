using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace QuanLyChiTieuThongMinh
{
    public partial class thuchi : System.Web.UI.Page
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
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                if (Session["Khach"] != null)
                {
                    btnSave.Enabled = false;
                    btnSave.Text = "Chỉ xem demo";
                    btnSave.Style["opacity"] = ".6";
                    btnSave.Style["cursor"] = "not-allowed";
                }

                LoadDanhMuc();
                LoadData();
            }
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadDanhMuc();
        }

        void LoadDanhMuc()
        {
            ddlDanhMuc.Items.Clear();

            if (Session["Khach"] != null)
            {
                if (ddlType.SelectedValue == "Thu")
                {
                    ddlDanhMuc.Items.Add(new ListItem("Lương", "1"));
                    ddlDanhMuc.Items.Add(new ListItem("Freelance", "2"));
                    ddlDanhMuc.Items.Add(new ListItem("Thưởng", "3"));
                }
                else
                {
                    ddlDanhMuc.Items.Add(new ListItem("Ăn uống", "4"));
                    ddlDanhMuc.Items.Add(new ListItem("Mua sắm", "5"));
                    ddlDanhMuc.Items.Add(new ListItem("Di chuyển", "6"));
                }

                return;
            }

            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                SELECT 
                    MaDM,
                    TenDanhMuc,
                    ISNULL(Icon,'circle-dollar-sign') AS Icon
                FROM DanhMuc
                WHERE Loai=@Loai
                AND
                (
                    TrangThai IS NULL
                    OR TrangThai=''
                    OR TrangThai=N'Hoạt động'
                    OR TrangThai=N'HoatDong'
                    OR TrangThai=N'HoanThanh'
                )
                ORDER BY TenDanhMuc";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@Loai", ddlType.SelectedValue);

                SqlDataReader rd = cmd.ExecuteReader();

                while (rd.Read())
                {
                    string text =
                        rd["TenDanhMuc"].ToString();

                    string value =
                        rd["MaDM"].ToString();

                    ddlDanhMuc.Items.Add(
                        new ListItem(text, value));
                }

                rd.Close();

                if (ddlDanhMuc.Items.Count == 0)
                {
                    ddlDanhMuc.Items.Add(
                        new ListItem("Chưa có danh mục phù hợp", ""));
                }
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi tải danh mục: "
                + ex.Message.Replace("'", "")
                + "');</script>");
            }
            finally
            {
                CloseConn();
            }
        }

        void LoadData()
        {
            try
            {
                DataTable dt = new DataTable();

                if (Session["Khach"] != null)
                {
                    dt.Columns.Add("MaGD", typeof(int));
                    dt.Columns.Add("MoTa", typeof(string));
                    dt.Columns.Add("SoTien", typeof(decimal));
                    dt.Columns.Add("Loai", typeof(string));
                    dt.Columns.Add("NgayGiaoDich", typeof(DateTime));
                    dt.Columns.Add("Icon", typeof(string));
                    dt.Columns.Add("TenDanhMuc", typeof(string));

                    dt.Rows.Add(1, "Lương tháng", 15000000, "Thu", DateTime.Now.AddDays(-1), "wallet", "Lương");
                    dt.Rows.Add(2, "Ăn uống", 350000, "Chi", DateTime.Now.AddDays(-2), "utensils-crossed", "Ăn uống");
                    dt.Rows.Add(3, "Mua sắm", 1200000, "Chi", DateTime.Now.AddDays(-3), "shopping-bag", "Mua sắm");
                    dt.Rows.Add(4, "Freelance", 4500000, "Thu", DateTime.Now.AddDays(-4), "briefcase", "Freelance");
                    dt.Rows.Add(5, "Di chuyển", 150000, "Chi", DateTime.Now.AddDays(-5), "car", "Di chuyển");

                    rpList.DataSource = dt;
                    rpList.DataBind();

                    pnlEmpty.Visible = false;
                    return;
                }

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                SELECT 
                    gd.MaGD,
                    gd.MaND,
                    gd.MaDM,
                    gd.SoTien,
                    gd.Loai,
                    gd.MoTa,
                    gd.NgayGiaoDich,
                    gd.TrangThai,
                    ISNULL(dm.TenDanhMuc,N'Khác') AS TenDanhMuc,
                    ISNULL(dm.Icon,'circle-dollar-sign') AS Icon
                FROM GiaoDich gd
                LEFT JOIN DanhMuc dm
                    ON gd.MaDM = dm.MaDM
                WHERE gd.MaND = @MaND
                ORDER BY gd.NgayGiaoDich DESC, gd.MaGD DESC";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                rpList.DataSource = dt;
                rpList.DataBind();

                pnlEmpty.Visible = dt.Rows.Count == 0;
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi tải dữ liệu: " +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
            finally
            {
                CloseConn();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Session["Khach"] != null)
            {
                Response.Write(
                "<script>alert('Khách vãng lai chỉ được xem demo');</script>");
                return;
            }

            try
            {
                if (txtAmount.Text.Trim() == "")
                {
                    Response.Write("<script>alert('Nhập số tiền');</script>");
                    return;
                }

                if (txtDesc.Text.Trim() == "")
                {
                    Response.Write("<script>alert('Nhập mô tả');</script>");
                    return;
                }

                if (ddlDanhMuc.SelectedValue == "")
                {
                    Response.Write("<script>alert('Vui lòng chọn danh mục');</script>");
                    return;
                }

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                if (hdID.Value == "")
                {
                    string sql = @"
                    INSERT INTO GiaoDich
                    (
                        MaND,
                        MaDM,
                        SoTien,
                        Loai,
                        MoTa,
                        NgayGiaoDich,
                        TrangThai,
                        NgayTao
                    )
                    VALUES
                    (
                        @MaND,
                        @MaDM,
                        @SoTien,
                        @Loai,
                        @MoTa,
                        @NgayGiaoDich,
                        N'HoanThanh',
                        GETDATE()
                    )";

                    SqlCommand cmd = new SqlCommand(sql, db.conn);

                    cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);
                    cmd.Parameters.AddWithValue("@MaDM", ddlDanhMuc.SelectedValue);
                    cmd.Parameters.AddWithValue("@SoTien", txtAmount.Text.Trim());
                    cmd.Parameters.AddWithValue("@Loai", ddlType.SelectedValue);
                    cmd.Parameters.AddWithValue("@MoTa", txtDesc.Text.Trim());
                    cmd.Parameters.AddWithValue("@NgayGiaoDich", txtDate.Text);

                    cmd.ExecuteNonQuery();
                }
                else
                {
                    string sql = @"
                    UPDATE GiaoDich
                    SET
                        MaDM=@MaDM,
                        SoTien=@SoTien,
                        Loai=@Loai,
                        MoTa=@MoTa,
                        NgayGiaoDich=@NgayGiaoDich
                    WHERE MaGD=@MaGD
                    AND MaND=@MaND";

                    SqlCommand cmd = new SqlCommand(sql, db.conn);

                    cmd.Parameters.AddWithValue("@MaDM", ddlDanhMuc.SelectedValue);
                    cmd.Parameters.AddWithValue("@SoTien", txtAmount.Text.Trim());
                    cmd.Parameters.AddWithValue("@Loai", ddlType.SelectedValue);
                    cmd.Parameters.AddWithValue("@MoTa", txtDesc.Text.Trim());
                    cmd.Parameters.AddWithValue("@NgayGiaoDich", txtDate.Text);
                    cmd.Parameters.AddWithValue("@MaGD", hdID.Value);
                    cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                    cmd.ExecuteNonQuery();
                }

                ClearForm();
                LoadDanhMuc();
                LoadData();

                Response.Write("<script>alert('Lưu thành công');</script>");
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi lưu: " +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
            finally
            {
                CloseConn();
            }
        }

        protected void EditItem(object sender, CommandEventArgs e)
        {
            if (Session["Khach"] != null)
            {
                Response.Write("<script>alert('Khách vãng lai không thể sửa');</script>");
                return;
            }

            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                SELECT *
                FROM GiaoDich
                WHERE MaGD=@MaGD
                AND MaND=@MaND";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@MaGD", e.CommandArgument.ToString());
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                SqlDataReader rd = cmd.ExecuteReader();

                if (rd.Read())
                {
                    hdID.Value = rd["MaGD"].ToString();
                    txtAmount.Text = rd["SoTien"].ToString();
                    txtDesc.Text = rd["MoTa"].ToString();

                    ddlType.SelectedValue = rd["Loai"].ToString();

                    rd.Close();

                    LoadDanhMuc();

                    string maDM = "";

                    if (db.conn.State == ConnectionState.Closed)
                    {
                        db.conn.Open();
                    }

                    string sqlDM = @"
                    SELECT MaDM
                    FROM GiaoDich
                    WHERE MaGD=@MaGD
                    AND MaND=@MaND";

                    SqlCommand cmdDM = new SqlCommand(sqlDM, db.conn);
                    cmdDM.Parameters.AddWithValue("@MaGD", e.CommandArgument.ToString());
                    cmdDM.Parameters.AddWithValue("@MaND", Session["MaND"]);

                    object result = cmdDM.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        maDM = result.ToString();
                    }

                    if (maDM != "" && ddlDanhMuc.Items.FindByValue(maDM) != null)
                    {
                        ddlDanhMuc.SelectedValue = maDM;
                    }

                    if (db.conn.State == ConnectionState.Open)
                    {
                        db.conn.Close();
                    }

                    if (db.conn.State == ConnectionState.Closed)
                    {
                        db.conn.Open();
                    }

                    string sqlDate = @"
                    SELECT NgayGiaoDich
                    FROM GiaoDich
                    WHERE MaGD=@MaGD
                    AND MaND=@MaND";

                    SqlCommand cmdDate = new SqlCommand(sqlDate, db.conn);
                    cmdDate.Parameters.AddWithValue("@MaGD", e.CommandArgument.ToString());
                    cmdDate.Parameters.AddWithValue("@MaND", Session["MaND"]);

                    object ngay = cmdDate.ExecuteScalar();

                    if (ngay != null && ngay != DBNull.Value)
                    {
                        txtDate.Text =
                            Convert.ToDateTime(ngay)
                            .ToString("yyyy-MM-dd");
                    }
                }
                else
                {
                    rd.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi sửa: " +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
            finally
            {
                CloseConn();
            }
        }

        protected void DeleteItem(object sender, CommandEventArgs e)
        {
            if (Session["Khach"] != null)
            {
                Response.Write("<script>alert('Khách vãng lai không thể xóa');</script>");
                return;
            }

            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql = @"
                DELETE FROM GiaoDich
                WHERE MaGD=@MaGD
                AND MaND=@MaND";

                SqlCommand cmd = new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue("@MaGD", e.CommandArgument.ToString());
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                cmd.ExecuteNonQuery();

                LoadData();
            }
            catch (Exception ex)
            {
                Response.Write(
                "<script>alert('Lỗi xóa: " +
                ex.Message.Replace("'", "") +
                "');</script>");
            }
            finally
            {
                CloseConn();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
            LoadDanhMuc();
        }

        void ClearForm()
        {
            hdID.Value = "";
            txtAmount.Text = "";
            txtDesc.Text = "";
            ddlType.SelectedIndex = 0;
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
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