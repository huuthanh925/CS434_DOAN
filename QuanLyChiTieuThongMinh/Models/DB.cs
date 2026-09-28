using System.Configuration;
using System.Data.SqlClient;

namespace QuanLyChiTieuThongMinh.Models
{
    public class DB
    {
        public SqlConnection conn;

        public DB()
        {
            conn = new SqlConnection(
                ConfigurationManager
                .ConnectionStrings["conn"]
                .ConnectionString
            );
        }
    }
}