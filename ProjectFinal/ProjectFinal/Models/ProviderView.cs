using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class ProviderView
    {
        public int ProviderId { get; set; }
        public string ProviderName { get; set; }
        public string IconImg { get; set; }
        public string Description { get; set; }
        public byte Status { get; set; }
    }
}