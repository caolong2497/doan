using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class ProductRespository : IProductRespository
    {
        MobileStoreEntities db = new MobileStoreEntities();
        public IEnumerable<ProductViewModel> getTopProductbyProvider(int providerid)
        {
            var product = (from b in db.Products
                          where b.Status == 1 && b.ProviderId == providerid
                           orderby b.CoutBuy descending
                           select new ProductViewModel
                          {
                              ProductId = b.ProductId,
                              ProductName = b.ProductName,
                              Discount=b.Discount,
                              IconImg = b.IconImg,
                              PriceOut = b.PriceOut
                          }).Take(8);
            return product;
        }
        public ProductViewDetail getProductDetail(int productid)
        {
            var product = from p in db.Products
                          join i in db.Providers on p.ProviderId equals i.ProviderId
                          where p.ProductId == productid && p.Status == 1 && i.Status == 1
                          select new ProductViewDetail
                          {
                              ProductId = p.ProductId,
                              ProductName = p.ProductName,
                              IconImg = p.IconImg,
                              Screen = p.Screen,
                              Battery = p.Battery,
                              Description = p.Description,
                              CPU = p.CPU,
                              Ram = p.Ram,
                              Camera = p.Camera,
                              Color = p.Color,
                              Osystem = p.Osystem,
                              Discount = p.Discount,
                              PriceOut = p.PriceOut,
                              ProviderName = i.ProviderName
                          };
            //var product = db.usp_GetProductDetail(productid);
            return product.First();
        }

        public List<ProductViewModel> getListProductNew()
        {
            var product = (from b in db.Products
                           where b.Status == 1
                           orderby b.CreateDate descending              
                           select new ProductViewModel
                          {
                              ProductId = b.ProductId,
                              ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount = b.Discount,
                               PriceOut = b.PriceOut
                          }).Take(9).ToList();
            return product;
        }

        public List<ProductViewModel> getListProductHot()
        {

            var product = (from b in db.Products
                           where b.Status == 1
                           orderby b.CoutBuy descending
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount = b.Discount,
                               PriceOut = b.PriceOut
                           }).Take(9).ToList();
            return product;
        }

        public List<ProductViewModel> getListProductView()
        {
            var product = (from b in db.Products
                           where b.Status == 1
                           orderby b.CoutView descending
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount = b.Discount,
                               PriceOut = b.PriceOut
                           }).Take(9).ToList();
            return product;
        }

        public List<ProductViewModel> GetProductByName(string name)
        {
            var product = (from b in db.Products
                           where b.Status == 1
                           orderby b.CoutView descending
                           where b.ProductName.Contains(name)
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount = b.Discount,
                               PriceOut = b.PriceOut
                           }).ToList();
            return product;
        }

        public List<ProductViewModel> GetAllProduct()
        {
            var product = (from b in db.Products
                           where b.Status == 1
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount = b.Discount,
                               PriceOut = b.PriceOut
                           }).ToList();
            return product;
        }

        public List<ProductViewModel> GetProductByProvider(string listprovider)
        {
            String[] ListProviderId = listprovider.Split(',');
            var product = (from b in db.Products
                           where ListProviderId.Contains(b.ProviderId + "")
                           orderby b.PriceOut * (100 - b.Discount) / 100 descending
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount = b.Discount,
                               PriceOut = b.PriceOut
                           }).ToList();
            return product;
        }

        public List<ProductViewModel> getListProductSale()
        {
            var product = (from b in db.Products
                           orderby b.Discount descending
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount=b.Discount,
                               PriceOut = b.PriceOut
                           }).Take(9).ToList();
            return product;
        }

        public List<ProductViewModel> GetProductByCategory(string id)
        {
            int catId = Int32.Parse(id);
            var product = (from b in db.Products
                           where b.CategoryId.Equals(catId)
                           orderby b.PriceOut * (100 - b.Discount) / 100 descending
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               Discount = b.Discount,
                               PriceOut = b.PriceOut
                           }).ToList();
            return product;
        }

        public List<ProductViewModel> SearchProduct(String ListProvider,String ListPrice)
        {
            String[] ListProviderId = ListProvider.Split(',');
            String[] Price = ListPrice.Split(',');
            List<ProductViewModel> Listproduct = new List<ProductViewModel>();
            foreach (var item in Price)
            {
                int pricemin = 0;
                int pricemax = 0;
                if ("13".Equals(item))
                {
                    pricemax = 3000000;
                }
                else if ("36".Equals(item))
                {
                    pricemin = 3000000;
                    pricemax = 6000000;
                }
                else if ("610".Equals(item))
                {
                    pricemin = 6000000;
                    pricemax = 10000000;
                }
                else if ("1015".Equals(item))
                {
                    pricemin = 10000000;
                    pricemax = 15000000;
                }
                else
                {
                    pricemin = 15000000;
                    pricemax = 999999999;
                }
                List<ProductViewModel> product = (from b in db.Products
                                                  where b.PriceOut * (100 - b.Discount) / 100 >= pricemin && b.PriceOut * (100 - b.Discount) / 100 <= pricemax && ListProviderId.Contains(b.ProviderId + "")
                                                  orderby b.PriceOut * (100 - b.Discount) / 100 descending
                                                  select new ProductViewModel
                                                  {
                                                      ProductId = b.ProductId,
                                                      ProductName = b.ProductName,
                                                      IconImg = b.IconImg,
                                                      Discount = b.Discount,
                                                      PriceOut = b.PriceOut
                                                  }).ToList();
                Listproduct.AddRange(product);
            }
            return Listproduct;
        }

        public bool upProductView(String id)
        {
            try { 
            int productid = Int32.Parse(id);
            Product product = db.Products.FirstOrDefault(item => item.ProductId == productid);
            product.CoutView = product.CoutView + 1;
            db.SaveChanges();
                return true;
            }catch(Exception ex)
            {
                Console.Write("loi " + ex);
            }
            return false;
        }
        public bool upProductBuy(int id,int quantity)
        {
            try
            {
            Product product = db.Products.FirstOrDefault(item => item.ProductId == id);
            product.CoutBuy = product.CoutBuy + quantity;
            db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                Console.Write("loi " + ex);
            }
            return false;
        }
        public List<ProductViewModel> GetProductByPrice(String ListPrice)
        {
            String[] Price = ListPrice.Split(',');
            List<ProductViewModel> Listproduct = new List<ProductViewModel>();
            int pricemin = 0;
            int pricemax = 0; 
            foreach ( var item in Price)
            {   
                if ("13".Equals(item))
                {
                    pricemax = 3000000;
                }else if ("36".Equals(item))
                {
                    pricemin = 3000000;
                    pricemax = 6000000;
                }else if ("610".Equals(item))
                {
                    pricemin = 6000000;
                    pricemax = 10000000;
                }else if ("1015".Equals(item))
                {
                    pricemin = 10000000;
                    pricemax = 15000000;
                }else
                {
                    pricemin = 15000000;
                    pricemax = 999999999;
                }
                List<ProductViewModel> product = (from b in db.Products
                               where b.PriceOut*(100-b.Discount)/100 >= pricemin && b.PriceOut * (100 - b.Discount) / 100 <= pricemax
                                orderby b.PriceOut * (100 - b.Discount) / 100 descending
                                select new ProductViewModel
                               {
                                   ProductId = b.ProductId,
                                   ProductName = b.ProductName,
                                   IconImg = b.IconImg,
                                   Discount = b.Discount,
                                   PriceOut = b.PriceOut
                               }).ToList(); 
                Listproduct.AddRange(product);
            }
            return Listproduct;

        }
    }
}
