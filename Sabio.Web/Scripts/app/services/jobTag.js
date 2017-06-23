(function () {
    "use strict";
    angular.module(APPNAME)
        .factory('jobTagService', JobTagService);

    JobTagService.$inject = ['$baseService', '$sabio'];

    function JobTagService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.jobTag;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();