using ProjectFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectFinal.Controllers
{
    public class OrderController : Controller
    {
        // GET: Order
        public ActionResult CreateOrder()
        {
            return View();
        }
        //[HttpPost]
        // public bool CreateOrderInfor(OrderInfor order)
        //{
        //    order.CreateDate = System.DateTime.Now;
        //    OrderRespository orderRes = new OrderRespository();
        //    if (orderRes.CreateOrderInfor(order))
        //    {
        //        return true;
        //    }
        //    return false; 
        //}
        [HttpPost]
        public bool CreateOrderInfor(OrderInfor order)
        {
            order.CreateDate = System.DateTime.Now;
            OrderRespository orderRes = new OrderRespository();
            if (orderRes.CreateOrderInfor(order))
            {
                OrderDetail ord = new OrderDetail();
                List<ProductOrderModel> ListPro = (List<ProductOrderModel>)Session["myCart"];
                int orderId = orderRes.getLastInsertId();
                foreach (var item in ListPro)
                {
                    ord.ProductId = item.ProductId;
                    ord.Quantity = item.Quantity;
                    ord.Price = item.PriceOut;
                    ord.Value = item.PriceOut * item.Quantity*(100-item.Discount)/100;
                    ord.OrderId = orderId;
                    if (!orderRes.CreateOrderDetail(ord))
                    {
                        return false;
                    }
                }
                Session["myCart"] = null;
                return true;
            }
            return false;
        }
    }
}