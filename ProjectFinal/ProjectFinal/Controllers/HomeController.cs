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
            List<Provider> provider = providerRes.getProvider();
            IEnumerable<usp_TopProvider_Result> topProvider = providerRes.getTopProvider();
            ViewBag.TopProvider = topProvider;
            ViewBag.Provider = provider;
            ViewBag.Title = "Home Page";
            ProductRespository productRes = new ProductRespository();
            foreach(var c in topProvider)
            {
                int i = (int)c.ProviderId;
                productRes.getTopProductbyProvider(i);
            }
            return View();
        }
        //[HttpGet]
        //public IEnumerable<ProductViewModel> getTopProductByProvider(int providerid)
        //{
           
        //    return product;
        //}


    }
}
