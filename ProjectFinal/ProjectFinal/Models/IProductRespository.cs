using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public interface IProductRespository
    {
        IEnumerable<ProductViewModel> getTopProductbyProvider(int providerid);
        IEnumerable<ProductViewModel> getListProductNew();
        IEnumerable<ProductViewModel> getListProductHot();

        IEnumerable<ProductViewModel> getListProductView();

        IEnumerable<ProductViewModel> getListProductSale();
    }
}