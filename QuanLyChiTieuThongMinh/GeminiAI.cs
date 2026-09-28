using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Net;
using System.Text;

namespace QuanLyChiTieuThongMinh
{
    public class GeminiAI
    {
        private string apiKey =
            "AIzaSyATQYBZWyLGzRO7cz7X4a8c7d1rPzEjgAE";

        public string AskAI(string question)
        {
            ServicePointManager.SecurityProtocol =
                SecurityProtocolType.Tls12;

            try
            {
                string url =
                    "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key="
                    + apiKey;

                HttpWebRequest request =
                    (HttpWebRequest)WebRequest.Create(url);

                request.Method = "POST";
                request.ContentType = "application/json";
                request.Timeout = 180000;
                request.ReadWriteTimeout = 180000;
                request.KeepAlive = false;

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
                                    text =
                                    @"Bạn là AI chuyên phân tích chi tiêu cá nhân.
                                    CHỈ được trả lời các nội dung liên quan đến:
                                    - thu nhập
                                    - chi tiêu
                                    - giao dịch
                                    - tiết kiệm
                                    - ngân sách
                                    - số dư
                                    - phân tích tài chính cá nhân
                                    - kế hoạch quản lý tiền

                                    Nếu người dùng hỏi ngoài chủ đề này, hãy trả lời:
                                    'Tôi chỉ hỗ trợ các vấn đề liên quan đến chi tiêu và tài chính cá nhân.'

                                    Trả lời bằng tiếng Việt, rõ ràng, dễ hiểu, thực tế, không quá dài.

                                    Nội dung cần xử lý:
                                    " + question
                                }
                            }
                        }
                    },
                    generationConfig = new
                    {
                        temperature = 0.5,
                        maxOutputTokens = 1500
                    }
                };

                string json =
                    JsonConvert.SerializeObject(requestBody);

                byte[] data =
                    Encoding.UTF8.GetBytes(json);

                using (Stream stream =
                    request.GetRequestStream())
                {
                    stream.Write(data, 0, data.Length);
                }

                using (HttpWebResponse response =
                    (HttpWebResponse)request.GetResponse())
                using (StreamReader reader =
                    new StreamReader(response.GetResponseStream()))
                {
                    string result =
                        reader.ReadToEnd();

                    JObject obj =
                        JObject.Parse(result);

                    string text =
                        obj["candidates"]?[0]?["content"]?["parts"]?[0]?["text"]?.ToString();

                    if (string.IsNullOrEmpty(text))
                    {
                        return "AI chưa trả dữ liệu.";
                    }

                    return text.Trim();
                }
            }
            catch (WebException ex)
            {
                try
                {
                    if (ex.Response != null)
                    {
                        using (var reader =
                            new StreamReader(ex.Response.GetResponseStream()))
                        {
                            string error =
                                reader.ReadToEnd();

                            if (error.Contains("429"))
                            {
                                return "AI đang quá tải hoặc hết quota, vui lòng thử lại sau.";
                            }

                            JObject errObj =
                                JObject.Parse(error);

                            string errMsg =
                                errObj["error"]?["message"]?.ToString()
                                ?? "Lỗi AI.";

                            return "Lỗi AI: " + errMsg;
                        }
                    }

                    return "Không kết nối được AI.";
                }
                catch
                {
                    return "Không kết nối được AI.";
                }
            }
            catch (Exception ex)
            {
                return "Lỗi: " + ex.Message;
            }
        }
    }
}