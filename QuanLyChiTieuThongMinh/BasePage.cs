using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuanLyChiTieuThongMinh
{
    public class BasePage : Page
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            ApplyGlobalLanguage();
        }

        public bool IsEnglish()
        {
            string lang = Session["Lang"] != null ? Session["Lang"].ToString() : "vi";
            return lang == "en" || lang == "English";
        }

        public void ApplyGlobalLanguage()
        {
            bool isEn = IsEnglish();

            // 1. Dịch Sidebar Menu
            SetText("lblGroupOverview", isEn ? "OVERVIEW" : "TỔNG QUAN");
            SetText("lblMenuHome", isEn ? "Home" : "Trang chủ");
            SetText("lblMenuTransaction", isEn ? "Transactions" : "Thu chi");
            SetText("lblGroupAnalysis", isEn ? "ANALYSIS" : "PHÂN TÍCH");
            SetText("lblMenuAI", isEn ? "AI Suggestions" : "Gợi ý AI");
            SetText("lblMenuHistory", isEn ? "History" : "Lịch sử");
            SetText("lblGroupSettings", isEn ? "SETTINGS" : "CÀI ĐẶT");
            SetText("lblMenuStats", isEn ? "Statistics" : "Thống kê");
            SetText("lblMenuAccount", isEn ? "Account" : "Tài khoản");

            string logoutText = Session["Khach"] != null
                ? (isEn ? "Exit Demo" : "Thoát demo")
                : (isEn ? "Logout" : "Đăng xuất");
            SetText("lblLogout", logoutText);
        }

        protected void SetText(string controlId, string text)
        {
            Control ctrl = FindControl(controlId);
            if (ctrl is Label lbl)
            {
                lbl.Text = text;
            }
            else if (ctrl is Button btn)
            {
                btn.Text = text;
            }
            else if (ctrl is HyperLink hl)
            {
                hl.Text = text;
            }
            else if (ctrl is LinkButton lb)
            {
                lb.Text = text;
            }
        }
    }
}