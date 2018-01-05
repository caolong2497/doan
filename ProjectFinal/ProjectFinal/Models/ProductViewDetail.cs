using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class ProductViewDetail
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string IconImg { get; set; }
        public string Screen { get; set; }
        public string Battery { get; set; }
        public string CPU { get; set; }
        public string Ram { get; set; }
        public string Camera { get; set; }
        public string Color { get; set; }
        public string Osystem { get; set; }
        public string Description { get; set; }
        public int Discount { get; set; }
        public double PriceOut { get; set; }
        public String ProviderName { get; set; }
    }
    public class ProductViewModel
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public string IconImg { get; set; }
        public double PriceOut { get; set; }
    }
}