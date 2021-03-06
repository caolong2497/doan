﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectFinal.Models
{
    interface IOrderRespository
    {
        List<OrderInfor> getOrderByCustomer(int CustomerId);
        bool CreateOrderInfor(OrderInfor order);
        bool CreateOrderDetail(OrderDetail order);
        OrderInfor getOrderInfo(int orderId);
    }
}
