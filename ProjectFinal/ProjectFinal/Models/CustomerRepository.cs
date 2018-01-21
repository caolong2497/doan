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
                            where e.Email == email
                            select e).FirstOrDefault();
            return cus;
        }
        public CustomerInfor getCustomerInforByEmail(String email)
        {
            CustomerInfor cus = (from e in db.Customers
                            where e.Email == email
                            select  new CustomerInfor
                             {
                                 CustomerId = e.CustomerId,
                                 FullName = e.FullName,
                                 Email = e.FullName,
                                 Phone = e.Phone,
                                 Address = e.Address,
                                 PassWord=e.PassWord
                             }).First();
            return cus;
        }
        public IEnumerable<Customer> GetListCustomer()
        {
            throw new NotImplementedException();
        }

        public bool UpdateCustomer(Customer customer)
        {
            throw new NotImplementedException();
        }

        public Customer GetCustomer(string email, string password)
        {
            Customer cus = (from e in db.Customers
                            where e.Email == email && e.PassWord==password
                            select e).FirstOrDefault();
            return cus;
        }
    }
}