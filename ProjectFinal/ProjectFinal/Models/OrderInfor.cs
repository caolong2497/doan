using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class OrderInfor
    {
        public int OrderId { get; set; }
        public string FullName { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public double Total { get; set; }
        public System.DateTime CreateDate { get; set; }
    }
    public class OrderDetailModel
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string IconImg { get; set; }
        public int Quantity { get; set; }
        public double Value { get; set; }
       
    }
}