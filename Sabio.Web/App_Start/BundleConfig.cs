using System.Web.Optimization;

namespace Sabio.Web
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css"));

            //  Sabio application
            //  ------------------------------------------------------------
            bundles.Add(new ScriptBundle("~/sabio/base").Include(
                      "~/Scripts/sabio.js"));

            //  Sabio application
            //  ------------------------------------------------------------
            bundles.Add(new ScriptBundle("~/sabio/core").Include(

                      "~/Scripts/sabio/sabio.module.js",
                      "~/Scripts/sabio/core/controllers/*.js",
                      "~/Scripts/sabio/core/services/*.js"));

            bundles.Add(new ScriptBundle("~/sabio/angular").Include(
              "~/Scripts/angular.js",
              "~/Scripts/angular-animate.js",
              "~/Scripts/angular-ui/ui-bootstrap.js",
              "~/Scripts/angular-ui/ui-bootstrap-tpls.js",
              "~/Scripts/angular-route.js",
              "~/Scripts/angular-toastr.js",
              "~/Scripts/angular-toastr.tpls.js"));


            //  v2.0 / Bower versions
            //  ------------------------------------------------------------
            bundles.Add(new StyleBundle("~/bower/bootstrap/css").Include(
                      "~/Scripts/bower_components/bootstrap/dist/css/bootstrap.css",
                      "~/Scripts/bower_components/ngAnimate/css/ng-animation.css",
                      "~/Scripts/bower_components/angular-toastr/dist/angular-toastr.css"));

            bundles.Add(new StyleBundle("~/site/css").Include(
                      "~/Content/site.css"));

            bundles.Add(new ScriptBundle("~/bower/bootstrap/js").Include(
                      "~/Scripts/bower_components/bootstrap/dist/js/bootstrap.js"));

            bundles.Add(new ScriptBundle("~/bower/jquery").Include(
                      "~/Scripts/bower_components/jquery/dist/jquery.js"));

            // Admin theme bundles
            bundles.Add(new StyleBundle("~/bundles/adminThemeStyles/css").Include(
                "~/assets/admin/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css",
                "~/assets/admin/plugins/bootstrap/css/bootstrap.min.css",
                "~/assets/admin/plugins/bootstrap/css/bootstrap.min.css",
                "~/assets/admin/css/animate.min.css",
                "~/assets/admin/css/style.min.css",
                "~/assets/admin/css/style-responsive.min.css",
                "~/assets/admin/css/theme/default.css"));

            bundles.Add(new ScriptBundle("~/bundles/adminThemeScripts").Include(
                "~/assets/admin/plugins/jquery/jquery-1.9.1.js",
                "~/assets/admin/plugins/jquery/jquery-migrate-1.1.0.js",
                "~/assets/admin/plugins/jquery-ui/ui/minified/jquery-ui.js",
                "~/assets/admin/plugins/slimscroll/jquery.slimscroll.js",
                "~/assets/admin/plugins/jquery-cookie/jquery.cookie.js"
                ));
           
            // Commented out, to let web.config control whether optimizations are used
            //BundleTable.EnableOptimizations = false;
        }
    }
}