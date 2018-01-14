using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public interface IProductRespository
    {
        IEnumerable<ProductViewModel> getTopProductbyProvider(int providerid);
        List<ProductViewModel> getListProductNew();
        List<ProductViewModel> getListProductHot();

        List<ProductViewModel> getListProductView();

        List<ProductViewModel> getListProductSale();
        List<ProductViewModel> GetProductByProvider(string listprovider);
        List<ProductViewModel> GetAllProduct();
        List<ProductViewModel> GetProductByName(string name);
        ProductViewDetail getProductDetail(int productid);
        List<ProductViewModel> GetProductByCategory(string id);
    }
}