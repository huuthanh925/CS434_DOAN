using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.IO;
using System.Net;
using System.Text;

namespace QuanLyChiTieuThongMinh
{
    public class GeminiAI
    {
        private string apiKey = ConfigurationManager.AppSettings["GeminiApiKey"];

        public string AskAI(string question)
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;

            if (string.IsNullOrEmpty(apiKey))
            {
                return "Lỗi: Chưa cấu hình GeminiApiKey trong file Web.config.";
            }

            try
            {
                // Cập nhật endpoint chính xác theo thông báo: gemini-3.6-flash
                string url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent?key=" + apiKey;

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "POST";
                request.ContentType = "application/json";
                request.Timeout = 60000;

                var requestBody = new
                {
                    contents = new[]
                    {
                        new
                        {
                            parts = new[]
                            {
                                new
                                {
                                    text = @"Bạn là AI chuyên phân tích chi tiêu cá nhân.
CHỈ được trả lời các nội dung liên quan đến: thu nhập, chi tiêu, giao dịch, tiết kiệm, ngân sách, số dư, kế hoạch tài chính.
Nếu người dùng hỏi ngoài chủ đề này, hãy trả lời: 'Tôi chỉ hỗ trợ các vấn đề liên quan đến chi tiêu và tài chính cá nhân.'
Trả lời bằng tiếng Việt ngắn gọn, dễ hiểu.

Nội dung cần xử lý: " + question
                                }
                            }
                        }
                    },
                    generationConfig = new
                    {
                        temperature = 0.5,
                        maxOutputTokens = 1000
                    }
                };

                string json = JsonConvert.SerializeObject(requestBody);
                byte[] data = Encoding.UTF8.GetBytes(json);

                using (Stream stream = request.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }

                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    string result = reader.ReadToEnd();
                    JObject obj = JObject.Parse(result);
                    string text = obj["candidates"]?[0]?["content"]?["parts"]?[0]?["text"]?.ToString();

                    return string.IsNullOrEmpty(text) ? "AI không trả về kết quả." : text.Trim();
                }
            }
            catch (WebException ex)
            {
                if (ex.Response != null)
                {
                    using (var reader = new StreamReader(ex.Response.GetResponseStream()))
                    {
                        string error = reader.ReadToEnd();
                        try
                        {
                            JObject errObj = JObject.Parse(error);
                            string errMsg = errObj["error"]?["message"]?.ToString();
                            return "Lỗi AI: " + (errMsg ?? "Không xác định");
                        }
                        catch
                        {
                            return "Lỗi kết nối API Google.";
                        }
                    }
                }
                return "Không thể kết nối đến máy chủ AI.";
            }
            catch (Exception ex)
            {
                return "Lỗi hệ thống: " + ex.Message;
            }
        }
    }
}