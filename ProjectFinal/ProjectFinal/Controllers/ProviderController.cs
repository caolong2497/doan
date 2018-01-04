using ProjectFinal.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;

namespace ProjectFinal.Controllers
{
    public class ProviderController : Controller
    {
        MobileStoreEntities db = new MobileStoreEntities();
        ProviderRespository proRes;
        public PartialViewResult getProvider()
        {
            proRes = new ProviderRespository();
            List<Provider> provider = proRes.getProvider();

            return PartialView(@"~/Views/Provider/ListProvider.cshtml", provider);
        }
    }
}
