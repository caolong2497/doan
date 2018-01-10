using Newtonsoft.Json;
using ProjectFinal.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;

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
            var provider = proRes.getProvider();

            return PartialView(@"~/Views/Provider/ListProvider.cshtml", provider);
        }
        [HttpGet]
        public String getListProvider() {
            proRes = new ProviderRespository();
            var provider = proRes.getProvider();
            string text = JsonConvert.SerializeObject(provider);
            return text;
        }
        [HttpGet]
        public String getListProviderByName(string name)
        {
            proRes = new ProviderRespository();
            var provider = proRes.getProviderbyName(name);
            string text = JsonConvert.SerializeObject(provider);
            return text;
        }
    }
}
