using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using ProjectFinal.Models;

namespace ProjectFinal.Controllers
{
    public class CategoriesController : ApiController
    {
        private MobileStoreEntities db = new MobileStoreEntities();

        // GET: api/Categories
        public IEnumerable<Category> GetCategories()
        {
            return db.Categories.ToList();
        }

        // GET: api/Categories/5
        [ResponseType(typeof(Category))]
        public IHttpActionResult GetCategory(int id)
        {
            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return NotFound();
            }

            return Ok(category);
        }

       
    }
}