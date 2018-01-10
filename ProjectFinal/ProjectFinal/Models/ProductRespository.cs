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
            var product = from b in db.Products
                          where b.ProviderId == providerid
                          select new ProductViewModel
                          {
                              ProductId = b.ProductId,
                              ProductName = b.ProductName,
                              IconImg = b.IconImg,
                              PriceOut = b.PriceOut
                          };
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
                          orderby b.CreateDate descending
                           select new ProductViewModel
                          {
                              ProductId = b.ProductId,
                              ProductName = b.ProductName,
                              IconImg = b.IconImg,
                              PriceOut = b.PriceOut
                          }).Take(9).ToList();
            return product;
        }

        public List<ProductViewModel> getListProductHot()
        {

            var product = (from b in db.Products
                           orderby b.CoutBuy descending
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               PriceOut = b.PriceOut
                           }).Take(9).ToList();
            return product;
        }

        public List<ProductViewModel> getListProductView()
        {
            var product = (from b in db.Products
                           orderby b.CoutView descending
                           select new ProductViewModel
                           {
                               ProductId = b.ProductId,
                               ProductName = b.ProductName,
                               IconImg = b.IconImg,
                               PriceOut = b.PriceOut
                           }).Take(9).ToList();
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
                               PriceOut = b.PriceOut
                           }).Take(9).ToList();
            return product;
        }
    }
}
