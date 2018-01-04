using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectFinal.Models
{
    public interface IProviderRepository
    {

        List<Provider> getProvider();
        IEnumerable<usp_TopProvider_Result> getTopProvider();
    }
}