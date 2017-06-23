(function () {
    "use strict";
    angular.module(APPNAME)
         .factory('blogTagService', BlogTagService);

    BlogTagService.$inject = ['$baseService', '$sabio'];    //  $sabio is a reference to sabio.page object which is created in sabio.js

    function BlogTagService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.blogTag;
        // Simlates inheritance, giving access to $window and $location services and the getNotifier function
        // to our new service.
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }

})();