using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class ProviderRespository : IProviderRepository
    {
        MobileStoreEntities db = new MobileStoreEntities();


        public List<Provider> getProvider()
        {
            var pro = db.Providers.ToList();

            return pro;
        }
        public IEnumerable<usp_TopProvider_Result> getTopProvider()
        {
            var pro = db.usp_TopProvider();
            return pro;
        }
    }
}