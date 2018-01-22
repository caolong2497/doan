using ProjectFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Mvc;
using ProjectFinal.Utils;
using System.Collections.Specialized;
using Newtonsoft.Json;
using System.Net.Mail;

namespace ProjectFinal.Controllers
{
    public class CustomerController : Controller
    {
        CustomerRepository cusRes;

        [AllowAnonymous]
        public ActionResult CreateCustomer()
        {
            return View();
        }
        [HttpPost]
        [AllowAnonymous]
        public bool CreateCustomer(CustomerRegister customer)
        {
                Customer cus = new Customer();
                cus.FullName = customer.FullName;
                cus.Email = customer.Email;
                cus.PassWord = Common.EncodeMd5(customer.PassWord);
                cus.Phone = customer.Phone;
                cus.Address = customer.Address;

                //String date= System.DateTime.Now.ToString("yyyy.MM.dd");
                cus.CreateDate = System.DateTime.Now;
                Random rnd = new Random();
                int code = rnd.Next(1000, 10000);

                cus.CodeConfirm = code + "";
                cusRes = new CustomerRepository();
                Boolean result = cusRes.CreateCustomer(cus);
                if (result)
                {
                Session["Email"] = customer.Email;
                Session["UserName"] = customer.FullName;
                Session["User"] = customer;
                return true;
                }
            return false;

        }
        public ActionResult getCustomerInfor(String email)
        {
            CustomerRepository cusRes = new CustomerRepository();
            CustomerInfor customer = cusRes.getCustomerInforByEmail(email);
            ViewBag.CustomerInfor = customer;
                return View();
        }
        [HttpGet]
        public String getCustomer(String email)
        {
            CustomerRepository cusRes = new CustomerRepository();
            CustomerInfor customer = cusRes.getCustomerInforByEmail(email);
            return JsonConvert.SerializeObject(customer);
        }
        public ActionResult UpdateCustomer(String email)
        {
            ViewBag.email = email;
            return View();
        }
        public bool editCustomer(CustomerRegister customer)
        {
            CustomerRepository cusRes = new CustomerRepository();
            if (cusRes.UpdateCustomer(customer))
            {
                return true;
            }
            return false;
        }
        public ActionResult Login()
        {

            if (Session["Email"] != null)
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                return View();
            }
        }
        public ActionResult Logout()
        {
            Session.RemoveAll();
            return RedirectToAction("Login", "Customer");
        }

        [HttpPost]
        public int Login(String email, String password) {
            if (checkEmail(email)==0)
            {
                cusRes = new CustomerRepository();
                String encodePass = Common.EncodeMd5(password);
                var Customer = cusRes.GetCustomer(email, encodePass);
                if (Customer != null)
                {
                    Session["Email"] = Customer.Email;
                    Session["UserName"] = Customer.FullName;
                    Session["User"] = Customer;
                    return 1;
                }
                return 0;
            }
            return 0;
        }
        [HttpGet]
        public int checkEmail(string email)
        {
            cusRes = new CustomerRepository();
            Customer customer = cusRes.checkEmail(email);
            //return 1 => email chua ton tai
            //    return 0=> email da ton tai
            if (customer == null)
            {
                return 1;
            }
            return 0;
        }
        public ActionResult changePassword()
        {
            return View();
        }
        [HttpGet]
        public int changePass(String newPassword)
        {
            String email = Session["Email"].ToString();
            String encodePass = Common.EncodeMd5(newPassword);
            cusRes = new CustomerRepository();
            if (cusRes.changPassword(email, encodePass)) {
                return 1;
            }
            return 0;
        }
        [HttpGet]
        public int checkPass(String oldPassword)
        {

            String email = Session["Email"].ToString();
            String encodePass = Common.EncodeMd5(oldPassword);
            cusRes = new CustomerRepository();
            var Customer = cusRes.GetCustomer(email, encodePass);
            if (Customer == null)
            {
                return 0;
            }
            return 1;
        }
        public ActionResult forgetPassword()
        {

            return View();
        }
        public int resetPassWord(String email)
        {
            String mailto = email;
            String subject = "Reset Password Account IZShop";
            String Content = "Bạn Vừa Yêu Cầu Lấy Lại Mật Khẩu\n Mật Khẩu Mới Của Bạn là:";
            SmtpClient smtp = new SmtpClient();
            try
            {
                //ĐỊA CHỈ SMTP Server
                smtp.Host = "smtp.gmail.com";
                //Cổng SMTP
                smtp.Port = 587;
                //SMTP yêu cầu mã hóa dữ liệu theo SSL
                smtp.EnableSsl = true;
                //UserName và Password của mail
                smtp.Credentials = new NetworkCredential("botizshop@gmail.com", "botiz123");

                //Tham số lần lượt là địa chỉ người gửi, người nhận, tiêu đề và nội dung thư
                smtp.Send("botizshop@gmail.com", mailto, subject, Content);
                return 1;
            }
            catch (Exception ex)
            {
                return 0;
            }
        }
    }
}
