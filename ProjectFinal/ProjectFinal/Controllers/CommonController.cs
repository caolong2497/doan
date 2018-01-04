using ProjectFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProjectFinal.Controllers
{
    public class CommonController : Controller
    {
        // GET: Common
        public PartialViewResult header()
        {
            CategoryRespository cate = new CategoryRespository();
            List<Category> categories = cate.ListCategory();
            return PartialView(categories);
        }
        public PartialViewResult footer()
        {
            return PartialView();
        }
    }
}