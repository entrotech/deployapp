(function () {
    "use strict";
    angular.module(APPNAME)
        .factory('jobApplicationService', JobApplicationService);

    JobApplicationService.$inject = ['$baseService', '$sabio'];

    function JobApplicationService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.jobApplication;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();