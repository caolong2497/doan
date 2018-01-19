using ProjectFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Mvc;
using ProjectFinal.Utils;
using System.Collections.Specialized;

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
                Session["UserName"] = customer.FullName;
                Session["User"] = customer;
                return true;
                }
            return false;

        }

        public ActionResult Login()
        {

            if (Session["UserID"] != null)
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
                    Session["UserID"] = Customer.CustomerId.ToString();
                    Session["UserName"] = Customer.FullName.ToString();
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

            if (customer == null)
            {
                return 1;
            }
            return 0;
        }

    }
}
