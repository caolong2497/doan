using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectFinal.Models
{
    interface ICustomerRepository
    {
        Boolean CreateCustomer(Customer customer);
        Boolean UpdateCustomer(CustomerRegister customer);
        Customer checkEmail(String mail);
        Customer GetCustomer(String email, String password);
        CustomerInfor getCustomerInforByEmail(String email);
        Boolean changPassword(string email, string encodePass);
    }
}
