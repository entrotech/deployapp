(function () {
    "use strict";
    angular.module(APPNAME)
        .factory('jobPostingService', JobPostingService);

    JobPostingService.$inject = ['$baseService', '$sabio'];

    function JobPostingService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.jobPosting;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();