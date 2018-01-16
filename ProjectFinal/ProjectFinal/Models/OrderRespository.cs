using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class OrderRespository : IOrderRespository
    {
        MobileStoreEntities db = new MobileStoreEntities();

        public bool CreateOrderDetail(OrderDetail order)
        {
            try
            {
                db.OrderDetails.Add(order);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("lỗi" + ex);
            }
            return false;
        }
        public int getLastInsertId()
        {

            var id = (from b in db.Orders orderby b.OrderId select b.OrderId).Max();
            return id;

        }

        public bool CreateOrderInfor(OrderInfor order)
        {
            Order or = new Order();
            or.FullName = order.FullName;
            or.OrderNo = "123";
            or.Phone = order.Phone;
            or.Email = order.Email;
            or.Address = order.Address;
            or.Status = 1;
            or.Total = order.Total;
            try
            {
                or.CreateDate = order.CreateDate;
                db.Orders.Add(or);
                db.SaveChanges();

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("lỗi" + ex);
            }
            return false;
        }
    }
}