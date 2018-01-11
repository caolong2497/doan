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
            
            ViewBag.id = id;
            return View();
        }

        [HttpGet]
        public String GetProduct(String id)
        {
            ProductRespository proRes = new ProductRespository();
            List<ProductViewModel> product = null;
            List<ProductViewModel> Listproduct = new List<ProductViewModel>();
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
            foreach(var item in product)
            {
                ProductViewModel pro = new ProductViewModel();
                pro.ProductId = item.ProductId;
                pro.IconImg = item.IconImg.Split(',')[0];
                pro.ProductName = item.ProductName;
                pro.PriceOut = item.PriceOut;
                pro.Discount = item.Discount;
                Listproduct.Add(pro);
            }
            return JsonConvert.SerializeObject(Listproduct);
        }
        //[HttpGet]
        //public String SearchProduct(String id)
        //{
        //    ProductRespository proRes = new ProductRespository();
        //    List<ProductViewModel> product = null;
        //    List<ProductViewModel> Listproduct = new List<ProductViewModel>();
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
        //    foreach (var item in product)
        //    {
        //        ProductViewModel pro = new ProductViewModel();
        //        pro.ProductId = item.ProductId;
        //        pro.IconImg = item.IconImg.Split(',')[0];
        //        pro.ProductName = item.ProductName;
        //        pro.PriceOut = item.PriceOut;
        //        pro.Discount = item.Discount;
        //        Listproduct.Add(pro);
        //    }
        //    return JsonConvert.SerializeObject(Listproduct);
        //}
        //[HttpGet]
        //public String GetAllProduct()
        //{
        //    ProductRespository proRes = new ProductRespository();
        //    List<ProductViewModel> product = proRes.GetAllProduct();
        //    List<ProductViewModel> Listproduct = new List<ProductViewModel>();
        //    foreach (var item in product)
        //    {
        //        ProductViewModel pro = new ProductViewModel();
        //        pro.ProductId = item.ProductId;
        //        pro.IconImg = item.IconImg.Split(',')[0];
        //        pro.ProductName = item.ProductName;
        //        pro.PriceOut = item.PriceOut;
        //        pro.Discount = item.Discount;
        //        Listproduct.Add(pro);
        //    }
        //    return JsonConvert.SerializeObject(Listproduct);
        //}
        [HttpGet]
        public String SearchProduct(String Listprovider, String ListPrice)
        {
            ProductRespository proRes = new ProductRespository();
            List<ProductViewModel> product = null;
            if ("all".Equals(Listprovider)&& "all".Equals(ListPrice))
            {
                product = proRes.GetAllProduct();
            }
            else if("all".Equals(Listprovider) && !"all".Equals(ListPrice))
            {
                product = proRes.GetProductByPrice(ListPrice);
            }
            else if(!"all".Equals(Listprovider) && "all".Equals(ListPrice))
            {
                product = proRes.GetProductByProvider(Listprovider);
            }
            else
            {
                product = proRes.SearchProduct(Listprovider, ListPrice);
            }
            List<ProductViewModel> Listproduct = new List<ProductViewModel>();
            foreach (var item in product)
            {
                ProductViewModel pro = new ProductViewModel();
                pro.ProductId = item.ProductId;
                pro.IconImg = item.IconImg.Split(',')[0];
                pro.ProductName = item.ProductName;
                pro.PriceOut = item.PriceOut;
                pro.Discount = item.Discount;
                Listproduct.Add(pro);
            }
            return JsonConvert.SerializeObject(Listproduct);
        }
        [HttpGet]
        public String GetProductByCategory(String Id)
        {
            ProductRespository proRes = new ProductRespository();
            List<ProductViewModel> product = proRes.GetProductByPrice(ListPrice);
            List<ProductViewModel> Listproduct = new List<ProductViewModel>();
            foreach (var item in product)
            {
                ProductViewModel pro = new ProductViewModel();
                pro.ProductId = item.ProductId;
                pro.IconImg = item.IconImg.Split(',')[0];
                pro.ProductName = item.ProductName;
                pro.PriceOut = item.PriceOut;
                pro.Discount = item.Discount;
                Listproduct.Add(pro);
            }
            return JsonConvert.SerializeObject(Listproduct);
        }
    }
}