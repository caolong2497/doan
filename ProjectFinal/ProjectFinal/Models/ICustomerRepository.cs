using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectFinal.Models
{
    interface ICustomerRepository
    {
        IEnumerable<Customer> GetListCustomer();
        Boolean CreateCustomer(Customer customer);
        Boolean UpdateCustomer(Customer customer);
        Customer checkEmail(String mail);
        Customer GetCustomer(String email, String password);
    }
}
