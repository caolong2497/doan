using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ProjectFinal
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "get-list-provider",
                url: "get-list-provider",
                defaults: new { controller = "Provider", action = "getListProvider"}
            );
            routes.MapRoute(
                name: "get-list-provider-by-name",
                url: "get-list-provider-by-name",
                defaults: new { controller = "Provider", action = "getListProviderByName" }
            );
            routes.MapRoute(
                name: "a",
                url: "{controller}/{action}",
                defaults: new { controller = "Home", action = "Index" }
            );
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
