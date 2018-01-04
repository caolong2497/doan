using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class CategoryRespository : ICategoryRespository
    {
        MobileStoreEntities db = new MobileStoreEntities();
        public List<Category> ListCategory()
        {
            return db.Categories.ToList();
        }
    }
}