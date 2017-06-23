using System.Web.Mvc;

// ********** FYI: System Generated File

namespace Sabio.Web
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            // Disable HandleErrorFilter per http://benfoster.io/blog/aspnet-mvc-custom-error-pages
            //filters.Add(new HandleErrorAttribute());
            filters.Add(new RequireHttpsAttribute());
        }
    }
}