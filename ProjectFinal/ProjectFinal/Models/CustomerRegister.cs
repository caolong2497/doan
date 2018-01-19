using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectFinal.Models
{
    public class CustomerRegister
    {
        public int CustomerId { get; set; }
        public String FullName { get; set; }
        public String PassWord { get; set; }
        public String PassWordConfirm { get; set; }
        public String Address { get; set; }
        public String Phone { get; set; }
        public String Email { get; set; }
    }
}