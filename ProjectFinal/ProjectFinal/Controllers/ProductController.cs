using Newtonsoft.Json;
using ProjectFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectFinal.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        public ActionResult ProductDetail(String id)
        {
            int productid = Int32.Parse(id);
            ProductRespository proRes = new ProductRespository();
            ProductViewDetail product = proRes.getProductDetail(productid);
            ViewBag.product = product;
            String[] Image = product.IconImg.Split(',');
            ViewBag.Image = Image;
            return View();
        }
        public ActionResult GetListProduct(String id)
        {
            ProductRespository proRes = new ProductRespository();
            IEnumerable<ProductViewModel> product = null;
            if ("lastest".Equals(id))
            {
                product = proRes.getListProductNew();
            }
            else if ("hot".Equals(id))
            {
                product = proRes.getListProductHot();
            }
            else if ("mostview".Equals(id))
            {
                product = proRes.getListProductView();
            }
            else if ("sale".Equals(id))
            {
                product = proRes.getListProductSale();
            }
            ViewBag.product = product;
            return View();
        }
        //[HttpGet]
        //public string GetProduct(String id)
        //{
        //    ProductRespository proRes = new ProductRespository();
        //    IEnumerable<ProductViewModel> product=null;
        //    if ("lastest".Equals(id))
        //    {
        //         product = proRes.getListProductNew();
        //    }else if("hot".Equals(id))
        //    {
        //         product = proRes.getListProductHot();
        //    }else if ("mostview".Equals(id))
        //    {
        //        product = proRes.getListProductView();
        //    }
        //    else if ("sale".Equals(id))
        //    {
        //        product = proRes.getListProductSale();
        //    }
        //    String productJson= JsonConvert.SerializeObject(product);
        //    return productJson;
        //}
        //public PartialViewResult GetProduct(String id)
        //{
        //    ProductRespository proRes = new ProductRespository();
        //    List<ProductViewModel> product = null;
        //    if ("lastest".Equals(id))
        //    {
        //        product = proRes.getListProductNew();
        //    }
        //    else if ("hot".Equals(id))
        //    {
        //        product = proRes.getListProductHot();
        //    }
        //    else if ("mostview".Equals(id))
        //    {
        //        product = proRes.getListProductView();
        //    }
        //    else if ("sale".Equals(id))
        //    {
        //        product = proRes.getListProductSale();
        //    }
        //    return PartialView(@"~/Views/Provider/ListProvider.cshtml", product);
        //}
    }
}