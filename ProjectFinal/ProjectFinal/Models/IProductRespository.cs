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
    }
}