(function () {
    "use strict";
    angular.module(APPNAME)
        .factory('projectsService', ProjectsService);

    ProjectsService.$inject = ['$baseService', '$sabio'];

    function ProjectsService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.project;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }

})();