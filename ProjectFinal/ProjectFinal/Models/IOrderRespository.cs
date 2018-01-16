using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectFinal.Models
{
    interface IOrderRespository
    {
        bool CreateOrderInfor(OrderInfor order);
        bool CreateOrderDetail(OrderDetail order);
        bool getOrderInfo(int orderId);
    }
}
