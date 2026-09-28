using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QuanLyChiTieuThongMinh
{
    public class Transaction
    {
        public string Desc { get; set; }
        public decimal Amount { get; set; }
        public bool IsIncome { get; set; }
        public DateTime Date { get; set; }
    }
}