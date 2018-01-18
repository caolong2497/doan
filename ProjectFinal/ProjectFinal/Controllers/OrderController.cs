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

        public ActionResult CheckOutOrder()
        {
            int cartId = (int)Session["CartId"];
            OrderRespository orderRes = new OrderRespository();
            OrderInfor order = orderRes.getOrderInfo(cartId);
            List<OrderDetailModel> orderDetail = orderRes.getOrderDetail(cartId);
            ViewBag.order = order;
            ViewBag.orderDetail = orderDetail;
            return View();
        }

        [HttpPost]
        public bool CreateOrderInfor(OrderInfor order)
        {
            order.CreateDate = System.DateTime.Now;
            OrderRespository orderRes = new OrderRespository();
            ProductRespository productRes = new ProductRespository();
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
                    ord.Status = 1;
                    if (!orderRes.CreateOrderDetail(ord) || !productRes.upProductBuy(ord.ProductId, ord.Quantity))
                    {
                        return false;
                    }
                }
                Session["CartId"] = orderId;
                Session["myCart"] = null;
                return true;
            }
            return false;
        }
    }
}