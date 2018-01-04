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
    }
}