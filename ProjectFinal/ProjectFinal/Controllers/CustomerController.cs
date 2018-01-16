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
        public ActionResult CreateCustomer(CustomerRegister customer)
        {

            if (ModelState.IsValid)
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
                    return RedirectToAction("Index", "Home");
                }

            }
            return View(customer);

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
        [AllowAnonymous]
        public ActionResult Login(String email, String password) {

            if (!"".Equals(email) && !"".Equals(password))
            {
                if (!checkEmail(email))
                {
                    cusRes = new CustomerRepository();
                    String encodePass = Common.EncodeMd5(password);
                    var Customer = cusRes.GetCustomer(email, encodePass);
                    if (Customer != null)
                    {
                        Session["UserID"] = Customer.CustomerId.ToString();
                        Session["UserName"] = Customer.FullName.ToString();
                        Session["User"] = Customer;
                        return RedirectToAction("Index", "Home");
                    }
                  
                }
                ViewBag.Error = "Email hoặc Mật khẩu sai";
            }
            else
            {
                ViewBag.Error="Email và mật khẩu  không được để trống";
            }
            ViewBag.email = email;
            ViewBag.password = password;
                return View();

        }
        public bool checkEmail(string email)
        {
            cusRes = new CustomerRepository();
            Customer customer = cusRes.checkEmail(email);

            if (customer == null)
            {
                return true;
            }
            return false;
        }

    }
}
