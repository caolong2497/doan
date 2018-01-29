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
            UpProductView(id);
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
        public void getListProductByName(String name)
        {
            ProductRespository proRes = new ProductRespository();
            List<ProductViewModel> product = proRes.GetProductByName(name);

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
            Session["name"] = name;
            Session["Product"] = Listproduct;
            //return JsonConvert.SerializeObject(Listproduct);
        }
        [HttpGet]
        public String getProductNameFromSession()
        {
            return Session["name"].ToString();
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
            else if ("0".Equals(id))
            {
                product = Session["Product"] as List<ProductViewModel>;
                Session["Product"] = null;
            }
            else
            {
                product = proRes.GetProductByCategory(id);
            }
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
        public String getProductFilter(String Listprovider, String ListPrice, String ProductName, String page)
        {
            ProductRespository proRes = new ProductRespository();
            List<ProductViewModel> product = proRes.getProductFilter(Listprovider, ListPrice, ProductName, page);
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
        public String SearchProduct(String Listprovider, String ListPrice)
        {
            ProductRespository proRes = new ProductRespository();
            List<ProductViewModel> product = null;
            if ("all".Equals(Listprovider) && "all".Equals(ListPrice))
            {
                product = proRes.GetAllProduct();
            }
            else if ("all".Equals(Listprovider) && !"all".Equals(ListPrice))
            {
                product = proRes.GetProductByPrice(ListPrice);
            }
            else if (!"all".Equals(Listprovider) && "all".Equals(ListPrice))
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
        public String getProductByName(String name)
        {
            ProductRespository proRes = new ProductRespository();
            List<ProductViewModel> product = proRes.GetProductByName(name);

            List<ProductViewModel> Listproduct = new List<ProductViewModel>();
            int i= 0;
            foreach (var item in product)
            {
                i++;
                if (i == 5) { break;}
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
        public ActionResult addCart(String id)
        {
            int productid = Int32.Parse(id);

            List<ProductOrderModel> ListPro = null;

            if (Session["myCart"] != null)
            {
                ListPro = (List<ProductOrderModel>)Session["myCart"];
                foreach (var item in ListPro)
                {
                    if (item.ProductId == productid)
                    {
                        item.Quantity = item.Quantity + 1;
                        return Redirect("/Order/CreateOrder/");
                    }
                }
            }
            else
            {
                ListPro = new List<ProductOrderModel>();
            }
            ProductRespository proRes = new ProductRespository();
            ProductViewDetail product = proRes.getProductDetail(productid);
            ProductOrderModel pro = new ProductOrderModel();
            pro.ProductId = product.ProductId;
            pro.IconImg = product.IconImg.Split(',')[0];
            pro.ProductName = product.ProductName;
            pro.PriceOut = product.PriceOut;
            pro.Discount = product.Discount;
            pro.Quantity = 1;

            ListPro.Add(pro);
            Session["myCart"] = ListPro;
            return Redirect("/Order/CreateOrder/");
        }
        [HttpGet]
        public void UppdateQuantity(String id, String flag)
        {
            int productid = Int32.Parse(id);
            int flagId = Int32.Parse(flag);
            List<ProductOrderModel> ListPro = (List<ProductOrderModel>)Session["myCart"];
                foreach(var item in ListPro)
                {
                if (item.ProductId == productid)
                {
                    if (flagId == 1)
                    {
                        item.Quantity = item.Quantity-1;
                    }
                    else
                    {
                        item.Quantity = item.Quantity + 1;
                    }
                }
                }
            Session["myCart"] = ListPro;

        }
        [HttpGet]
        public String deleteCart(String id)
        {
            int productid = Int32.Parse(id);
            ProductRespository proRes = new ProductRespository();
            List<ProductOrderModel> ListPro = (List<ProductOrderModel>)Session["myCart"];
            ProductOrderModel prod = ListPro.Single(x => x.ProductId == productid);
            ListPro.Remove(prod);
            if (ListPro.Count() == 0)
            {
                Session["myCart"] = null;
            }
            else
            {
                Session["myCart"] = ListPro;
            }
            
            return JsonConvert.SerializeObject(ListPro);
        }
        [HttpGet]
        public int countProductinCart()
        {
            if (Session["myCart"] == null)
            {
                return 0;
            }
            List<ProductOrderModel> ListPro = (List<ProductOrderModel>)Session["myCart"];
            int count = 0;
            foreach(var item in ListPro)
            {
                count = count + item.Quantity;
            }
            return count; 
        }
        [HttpGet]
        public void UpProductView(String id)
        {
            ProductRespository proRes = new ProductRespository();
            proRes.upProductView(id);
            
        }

        [HttpGet]
        public String getProductInSession()
        {
            
            if (Session["myCart"] == null)
            {
                return "0";
            }
                List<ProductOrderModel> ListPro = (List<ProductOrderModel>)Session["myCart"];
                return JsonConvert.SerializeObject(ListPro);
        }
        [HttpGet]
        public double getTotal()
        {
            List<ProductOrderModel> ListPro = (List<ProductOrderModel>)Session["myCart"];
            double total = 0;
            foreach(var i in ListPro)
            {
                total = i.PriceOut * (100 - i.Discount) / 100 * i.Quantity + total;
            }
            return total;
        }
    }
}
