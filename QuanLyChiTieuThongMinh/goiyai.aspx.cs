using QuanLyChiTieuThongMinh.Models;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyChiTieuThongMinh
{
    public partial class goiyai : System.Web.UI.Page
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
                if (Session["Khach"] != null)
                {
                    LoadGuestChat();
                    return;
                }

                LoadDanhSachChat();

                if (Session["MaChat"] != null)
                {
                    LoadTinNhan(Convert.ToInt32(Session["MaChat"]));
                }
                else
                {
                    ShowWelcome();
                }
            }
        }

        void ShowWelcome()
        {
            chatBox.InnerHtml =
            @"
            <div class='msg-row'>
                <div class='avatar'>🤖</div>
                <div class='msg ai'>
                    Xin chào 👋 Tôi là trợ lý tài chính AI. Tôi chỉ hỗ trợ các nội dung liên quan đến chi tiêu, thu nhập, tiết kiệm và quản lý tài chính cá nhân.
                </div>
            </div>";
        }

        void LoadGuestChat()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("MaChat", typeof(int));
            dt.Columns.Add("TenChat", typeof(string));
            dt.Columns.Add("NgayTao", typeof(DateTime));

            dt.Rows.Add(1, "Demo phân tích chi tiêu", DateTime.Now.AddMinutes(-20));
            dt.Rows.Add(2, "Demo kế hoạch tiết kiệm", DateTime.Now.AddMinutes(-10));

            rpChat.DataSource = dt;
            rpChat.DataBind();

            chatBox.InnerHtml =
            @"
            <div class='msg-row'>
                <div class='avatar'>🤖</div>
                <div class='msg ai'>
                    Bạn đang ở chế độ khách vãng lai. Đây là bản demo AI, dữ liệu sẽ không được lưu vào hệ thống.
                </div>
            </div>
            <div class='msg-row'>
                <div class='avatar'>🤖</div>
                <div class='msg ai'>
                    Dữ liệu demo: Thu nhập 25,000,000đ, chi tiêu 8,300,000đ, số dư 16,700,000đ.
                    Bạn có thể hỏi thử: Tôi nên tiết kiệm thế nào?
                </div>
            </div>";
        }

        void LoadDanhSachChat()
        {
            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql =
                @"SELECT *
                  FROM ChatAI
                  WHERE MaND=@MaND
                  ORDER BY NgayTao DESC";

                SqlCommand cmd = new SqlCommand(sql, db.conn);
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                rpChat.DataSource = dt;
                rpChat.DataBind();
            }
            catch (Exception ex)
            {
                Alert(ex.Message);
            }
            finally
            {
                if (db.conn.State == ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        protected void btnNewChat_Click(object sender, EventArgs e)
        {
            if (Session["Khach"] != null)
            {
                LoadGuestChat();
                return;
            }

            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql =
                @"INSERT INTO ChatAI
                (
                    MaND,
                    TenChat
                )
                OUTPUT INSERTED.MaChat
                VALUES
                (
                    @MaND,
                    @TenChat
                )";

                SqlCommand cmd = new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);
                cmd.Parameters.AddWithValue("@TenChat", "Đoạn chat mới");

                int maChat = Convert.ToInt32(cmd.ExecuteScalar());

                Session["MaChat"] = maChat;

                ShowWelcome();
                LoadDanhSachChat();
            }
            catch (Exception ex)
            {
                Alert(ex.Message);
            }
            finally
            {
                if (db.conn.State == ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        protected void btnOpen_Click(object sender, EventArgs e)
        {
            if (Session["Khach"] != null)
            {
                LoadGuestChat();
                return;
            }

            try
            {
                LinkButton btn = (LinkButton)sender;

                int maChat = Convert.ToInt32(btn.CommandArgument);

                Session["MaChat"] = maChat;

                LoadTinNhan(maChat);
                LoadDanhSachChat();
            }
            catch (Exception ex)
            {
                Alert(ex.Message);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (Session["Khach"] != null)
            {
                Alert("Khách vãng lai không thể xóa đoạn chat demo.");
                return;
            }

            try
            {
                LinkButton btn = (LinkButton)sender;

                int maChat = Convert.ToInt32(btn.CommandArgument);

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql1 =
                @"DELETE FROM TinNhanAI
                  WHERE MaChat=@MaChat";

                SqlCommand cmd1 = new SqlCommand(sql1, db.conn);
                cmd1.Parameters.AddWithValue("@MaChat", maChat);
                cmd1.ExecuteNonQuery();

                string sql2 =
                @"DELETE FROM ChatAI
                  WHERE MaChat=@MaChat
                  AND MaND=@MaND";

                SqlCommand cmd2 = new SqlCommand(sql2, db.conn);
                cmd2.Parameters.AddWithValue("@MaChat", maChat);
                cmd2.Parameters.AddWithValue("@MaND", Session["MaND"]);
                cmd2.ExecuteNonQuery();

                Session["MaChat"] = null;

                chatBox.InnerHtml =
                @"
                <div class='msg-row'>
                    <div class='avatar'>🤖</div>
                    <div class='msg ai'>
                        Đã xóa đoạn chat.
                    </div>
                </div>";

                LoadDanhSachChat();
            }
            catch (Exception ex)
            {
                Alert(ex.Message);
            }
            finally
            {
                if (db.conn.State == ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        void LoadTinNhan(int maChat)
        {
            try
            {
                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sql =
                @"SELECT tn.*
                  FROM TinNhanAI tn
                  INNER JOIN ChatAI c ON tn.MaChat = c.MaChat
                  WHERE tn.MaChat=@MaChat
                  AND c.MaND=@MaND
                  ORDER BY tn.NgayGui ASC";

                SqlCommand cmd = new SqlCommand(sql, db.conn);

                cmd.Parameters.AddWithValue("@MaChat", maChat);
                cmd.Parameters.AddWithValue("@MaND", Session["MaND"]);

                SqlDataReader rd = cmd.ExecuteReader();

                StringBuilder html = new StringBuilder();

                while (rd.Read())
                {
                    string cauHoi = Server.HtmlEncode(rd["CauHoi"].ToString());
                    string traLoi = FormatAIResponse(rd["TraLoi"].ToString());

                    html.Append(@"
                    <div class='msg-row user'>
                        <div class='msg user'>"
                        + cauHoi +
                    @"</div>
                    </div>");

                    html.Append(@"
                    <div class='msg-row'>
                        <div class='avatar'>🤖</div>
                        <div class='msg ai'>"
                        + traLoi +
                    @"</div>
                    </div>");
                }

                rd.Close();

                chatBox.InnerHtml = html.ToString();

                if (chatBox.InnerHtml.Trim() == "")
                {
                    ShowWelcome();
                }
            }
            catch (Exception ex)
            {
                Alert(ex.Message);
            }
            finally
            {
                if (db.conn.State == ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        bool IsExpenseQuestion(string question)
        {
            string q = question.ToLower();

            string[] keywords =
            {
                "chi tiêu",
                "chi phí",
                "tiền",
                "thu nhập",
                "lương",
                "ăn uống",
                "mua sắm",
                "di chuyển",
                "tiết kiệm",
                "ngân sách",
                "giao dịch",
                "tài chính",
                "số dư",
                "khoản chi",
                "khoản thu",
                "quản lý tiền",
                "phân tích",
                "thống kê",
                "tiêu",
                "thu",
                "chi"
            };

            foreach (string key in keywords)
            {
                if (q.Contains(key))
                {
                    return true;
                }
            }

            return false;
        }

        string FormatAIResponse(string raw)
        {
            if (string.IsNullOrEmpty(raw))
            {
                return "";
            }

            string safe = Server.HtmlEncode(raw);

            safe = Regex.Replace(
                safe,
                @"###\s*(.+)",
                "<br/><strong>$1</strong><br/>");

            safe = Regex.Replace(
                safe,
                @"##\s*(.+)",
                "<br/><strong>$1</strong><br/>");

            safe = Regex.Replace(
                safe,
                @"\*\*(.+?)\*\*",
                "<strong>$1</strong>");

            safe = Regex.Replace(
                safe,
                @"\*(.+?)\*",
                "<em>$1</em>");

            safe = safe.Replace("\n", "<br/>");

            return safe;
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["SendingAI"] != null)
                {
                    return;
                }

                Session["SendingAI"] = true;

                string userQuestion = "";

                if (hfMessage != null && hfMessage.Value.Trim() != "")
                {
                    userQuestion = hfMessage.Value.Trim();
                }
                else
                {
                    userQuestion = txtMsg.Text.Trim();
                }

                if (userQuestion == "")
                {
                    Session["SendingAI"] = null;
                    return;
                }

                if (!IsExpenseQuestion(userQuestion))
                {
                    string deny =
                        "Tôi chỉ hỗ trợ các vấn đề liên quan đến chi tiêu và tài chính cá nhân.";

                    AppendChat(userQuestion, deny);

                    txtMsg.Text = "";
                    hfMessage.Value = "";

                    Session["SendingAI"] = null;
                    return;
                }

                if (Session["Khach"] != null)
                {
                    SendGuestAI(userQuestion);

                    txtMsg.Text = "";
                    hfMessage.Value = "";

                    Session["SendingAI"] = null;
                    return;
                }

                if (Session["MaChat"] == null)
                {
                    btnNewChat_Click(null, null);
                }

                int maND = Convert.ToInt32(Session["MaND"]);

                DataTable dt = new DataTable();

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sqlGD =
                @"SELECT TOP 10
                    MoTa,
                    SoTien,
                    Loai,
                    NgayGiaoDich
                  FROM GiaoDich
                  WHERE MaND=@MaND
                  ORDER BY NgayGiaoDich DESC, MaGD DESC";

                SqlCommand cmdGD = new SqlCommand(sqlGD, db.conn);

                cmdGD.Parameters.AddWithValue("@MaND", maND);

                SqlDataAdapter da = new SqlDataAdapter(cmdGD);

                da.Fill(dt);

                db.conn.Close();

                StringBuilder prompt = new StringBuilder();

                prompt.AppendLine("Dữ liệu giao dịch gần đây của người dùng:");

                foreach (DataRow row in dt.Rows)
                {
                    prompt.AppendLine(
                        "- "
                        + row["Loai"]
                        + " | "
                        + row["MoTa"]
                        + " | "
                        + Convert.ToDecimal(row["SoTien"]).ToString("N0")
                        + "đ | "
                        + Convert.ToDateTime(row["NgayGiaoDich"]).ToString("dd/MM/yyyy"));
                }

                prompt.AppendLine();
                prompt.AppendLine("Câu hỏi người dùng: " + userQuestion);

                GeminiAI ai = new GeminiAI();

                string aiResult = ai.AskAI(prompt.ToString());

                if (string.IsNullOrEmpty(aiResult))
                {
                    aiResult = "AI chưa phản hồi.";
                }

                if (db.conn.State == ConnectionState.Closed)
                {
                    db.conn.Open();
                }

                string sqlInsert =
                @"INSERT INTO TinNhanAI
                (
                    MaChat,
                    CauHoi,
                    TraLoi,
                    NgayGui
                )
                VALUES
                (
                    @MaChat,
                    @CauHoi,
                    @TraLoi,
                    GETDATE()
                )";

                SqlCommand cmdInsert = new SqlCommand(sqlInsert, db.conn);

                cmdInsert.Parameters.AddWithValue("@MaChat", Session["MaChat"]);
                cmdInsert.Parameters.AddWithValue("@CauHoi", userQuestion);
                cmdInsert.Parameters.AddWithValue("@TraLoi", aiResult);

                cmdInsert.ExecuteNonQuery();

                db.conn.Close();

                AppendChat(userQuestion, aiResult);

                txtMsg.Text = "";
                hfMessage.Value = "";

                LoadDanhSachChat();

                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "scroll",
                    "scrollChat();",
                    true);

                Session["SendingAI"] = null;
            }
            catch (Exception ex)
            {
                Session["SendingAI"] = null;

                Alert(ex.Message);
            }
            finally
            {
                if (db.conn.State == ConnectionState.Open)
                {
                    db.conn.Close();
                }
            }
        }

        void SendGuestAI(string userQuestion)
        {
            string aiResult =
            @"Đây là phản hồi demo dành cho khách vãng lai.

            Dựa trên dữ liệu mẫu:
            - Thu nhập: 25,000,000đ
            - Chi tiêu: 8,300,000đ
            - Số dư: 16,700,000đ

            Nhận xét:
            Bạn đang kiểm soát chi tiêu khá tốt. Tỷ lệ chi tiêu khoảng 33% thu nhập.

            Gợi ý:
            Nên dành khoảng 20% thu nhập cho tiết kiệm, 10% cho quỹ dự phòng và tiếp tục theo dõi các khoản chi ăn uống, mua sắm.";

            AppendChat(userQuestion, aiResult);

            txtMsg.Text = "";
            hfMessage.Value = "";
        }

        void AppendChat(string userQuestion, string aiResult)
        {
            string userHtml =
            @"
            <div class='msg-row user'>
                <div class='msg user'>"
                + Server.HtmlEncode(userQuestion)
            + @"</div>
            </div>";

            string aiHtml =
            @"
            <div class='msg-row'>
                <div class='avatar'>🤖</div>
                <div class='msg ai'>"
                + FormatAIResponse(aiResult)
            + @"</div>
            </div>";

            chatBox.InnerHtml += userHtml + aiHtml;
        }

        void Alert(string msg)
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "alert",
                "alert('"
                + msg.Replace("'", "")
                + "');",
                true);
        }
    }
}