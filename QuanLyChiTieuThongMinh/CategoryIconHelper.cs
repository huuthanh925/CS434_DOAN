namespace QuanLyChiTieuThongMinh
{
    public class CategoryIconHelper
    {
        public static string GetIcon(string tenDanhMuc)
        {
            if (string.IsNullOrEmpty(tenDanhMuc))
                return "circle-dollar-sign";

            string name = tenDanhMuc.ToLower();

            if (name.Contains("ăn") || name.Contains("uống"))
                return "utensils-crossed";

            if (name.Contains("lương") || name.Contains("thu"))
                return "wallet";

            if (name.Contains("mua") || name.Contains("sắm"))
                return "shopping-bag";

            if (name.Contains("di chuyển") || name.Contains("đi lại") || name.Contains("xe"))
                return "car";

            if (name.Contains("điện"))
                return "zap";

            if (name.Contains("nước"))
                return "droplets";

            if (name.Contains("game") || name.Contains("giải trí"))
                return "gamepad-2";

            if (name.Contains("y tế") || name.Contains("sức khỏe"))
                return "heart-pulse";

            if (name.Contains("học") || name.Contains("giáo dục"))
                return "book-open";

            return "circle-dollar-sign";
        }
    }
}