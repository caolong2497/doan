using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class OrderRespository : IOrderRespository
    {
        MobileStoreEntities db = new MobileStoreEntities();
        public List<OrderInfor> getOrderByCustomer(int CustomerId)
        {
            var order = (from b in db.Orders
                         where b.Status == 1 && b.CustomerId == CustomerId
                         orderby b.CreateDate descending
                         select new OrderInfor
                         {
                             OrderId=b.OrderId,
                             FullName = b.FullName,
                             Phone = b.Phone,
                             Email = b.Email,
                             Address = b.Address,
                             CreateDate=b.CreateDate,
                             Total = (double)b.Total
                         }).ToList();
            return order;
        }
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
            if (order.CustomerId != 0)
            {
                or.CustomerId = order.CustomerId;
            }
            or.FullName = order.FullName;
            or.OrderNo = "123";
            or.Phone = order.Phone;
            or.Email = order.Email;
            or.Address = order.Address;
            or.Status = 1;
            or.Total = order.Total;
            or.CreateDate = DateTime.Today;
            try
            {
                
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

        public OrderInfor getOrderInfo(int orderId)
        {
            var order = (from b in db.Orders
                   where b.Status == 1 && b.OrderId == orderId
                   select new OrderInfor
                   {
                       FullName = b.FullName,
                       Phone = b.Phone,
                       Email = b.Email,
                       Address = b.Address,
                       Total = (double)b.Total
                   }).First();
            return order;
        }
        public List<OrderDetailModel> getOrderDetail(int orderId)
        {
            var order = (from t1 in db.Products
                        join t2 in db.OrderDetails on t1.ProductId equals t2.ProductId
                        where t2.OrderId == orderId
                        select new OrderDetailModel
                        {
                            ProductId = t1.ProductId,
                            IconImg = t1.IconImg,
                            Quantity = t2.Quantity,
                            ProductName = t1.ProductName,
                            Value = t2.Value
                        }).ToList();
            return order;
        }

    }
}