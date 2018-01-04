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
        [Required(ErrorMessage = "FullName không được để trống")]
        [StringLength(16, MinimumLength = 8, ErrorMessage = "FullName phải có độ dài từ 8-20 kí tự")]
        public string FullName { get; set; }
        [DataType(DataType.Password)]
        [Required(ErrorMessage = "Mật Khẩu không được để trống")]
        [StringLength(20, MinimumLength = 8, ErrorMessage = "Mật khẩu có độ dài từ 8-20 kí tự")]
        public string PassWord { get; set; }
        [System.ComponentModel.DataAnnotations.Compare("PassWord", ErrorMessage ="Mật khẩu xác nhận sai")]
        [DataType(DataType.Password)]
        public string PassWordConfirm { get; set; }
        [Required(ErrorMessage = "Địa chỉ  không được để trống")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Số Điện Thoại  không được để trống")]
        [RegularExpression(@"(\+84|0)\d{9,10}", ErrorMessage = "Số điện thoại không đúng định dạng ")]

        public string Phone { get; set; }
        [Required(ErrorMessage = "Email không được để trống")]
        [RegularExpression(@"[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+.+.[A-Za-z]{2,4}", ErrorMessage = "Địa chỉ Email không đúng định dạng")]
        public string Email { get; set; }
    }
}