using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public interface IProviderRepository
    {

        IEnumerable<ProviderView> getProvider();
        IEnumerable<usp_TopProvider_Result> getTopProvider();
        IEnumerable<ProviderView> getProviderbyName(string name);
    }
}