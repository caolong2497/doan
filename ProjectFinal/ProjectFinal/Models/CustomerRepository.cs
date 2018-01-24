using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class CustomerRepository : ICustomerRepository
    {
        MobileStoreEntities db = new MobileStoreEntities();

        public bool CreateCustomer(Customer customer)
        {   
            try
            {
                customer.Status = 1;
                db.Customers.Add(customer);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex) {
                return false;
            }
        }

        public Customer checkEmail(string email)
        {
            Customer cus = (from e in db.Customers
                            where e.Email == email && e.Status==1
                            select e).FirstOrDefault();
            return cus;
        }
        public CustomerInfor getCustomerInforByEmail(String email)
        {
            CustomerInfor cus = (from e in db.Customers
                            where e.Email == email && e.Status == 1
                                 select  new CustomerInfor
                             {
                                 CustomerId = e.CustomerId,
                                 FullName = e.FullName,
                                 Email = e.Email,
                                 Phone = e.Phone,
                                 Address = e.Address,
                                 PassWord=e.PassWord
                             }).First();
            return cus;
        }
        public bool UpdateCustomer(CustomerRegister customer)
        {
            try { 
            Customer cus = db.Customers.FirstOrDefault(item => item.Email == customer.Email);
            cus.FullName = customer.FullName;
            cus.Address = customer.Address;
            cus.Phone = customer.Phone;
            db.SaveChanges();
                return true;
            } catch(Exception ex)
            {
                return false;
            }
        }

        public Customer GetCustomer(string email, string password)
        {
            Customer cus = (from e in db.Customers
                            where e.Email == email && e.PassWord==password && e.Status == 1
                            select e).FirstOrDefault();
            return cus;
        }

        public bool changPassword(string email, string encodePass)
        {
            try
            {
                Customer cus = db.Customers.FirstOrDefault(item => item.Email == email);
                cus.PassWord = encodePass;
                cus.CodeConfirm = "abcxyz123";
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool generateCodeConfirm(String email,String codeConfirm)
        {
            try
            {
                Customer cus = db.Customers.FirstOrDefault(item => item.Email == email);
                cus.CodeConfirm = codeConfirm;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public Customer checkCodeConfirm(String email, String codeConfirm)
        {
            Customer cus = (from e in db.Customers
                            where e.Email == email && e.Status == 1 && e.CodeConfirm==codeConfirm
                            select e).FirstOrDefault();
            return cus;
        }

    }
}