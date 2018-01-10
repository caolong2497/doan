using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public class ProviderRespository : IProviderRepository
    {
        MobileStoreEntities db = new MobileStoreEntities();


        public IEnumerable<ProviderView> getProvider()
        {
            var pro = from b in db.Providers
                      where b.Status==1
                    select new ProviderView
                    {
                        ProviderId = b.ProviderId,
                        ProviderName = b.ProviderName,
                        IconImg = b.IconImg
                    };

            return pro;
        }
        public IEnumerable<ProviderView> getProviderbyName(string name)
        {
            var pro = from b in db.Providers
                            where b.ProviderName.Contains(name) && b.Status == 1
                            select new ProviderView
                            {
                                ProviderId = b.ProviderId,
                                ProviderName = b.ProviderName,
                                IconImg = b.IconImg
                            };

            return pro;
        }
        public IEnumerable<usp_TopProvider_Result> getTopProvider()
        {
            var pro = db.usp_TopProvider();
            return pro;
        }
    }
}