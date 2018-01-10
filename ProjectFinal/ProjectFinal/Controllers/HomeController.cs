using ProjectFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectFinal.Controllers
{
    public class HomeController : Controller
    {
        
        public ActionResult Index()
        {
            ProviderRespository providerRes = new ProviderRespository();
            var provider = providerRes.getProvider();

            List<usp_TopProvider_Result> listpro = providerRes.getTopProvider().ToList();
            ViewBag.Provider = provider;
            ViewBag.Title = "Home Page";
            ProductRespository productRes = new ProductRespository();
            List<IEnumerable<ProductViewModel>> listProduct = new List<IEnumerable<ProductViewModel>>();
            foreach (var c in listpro)
            {
                int i = (int)c.ProviderId;
                listProduct.Add(productRes.getTopProductbyProvider(i));
            }
            ViewBag.TopProvider = listpro;
            ViewBag.listProduct = listProduct;
            return View();
        }


    }
}
