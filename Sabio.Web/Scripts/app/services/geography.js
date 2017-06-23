(function () {
    angular.module(APPNAME)
        .factory('geographyService', GeographyService);

    GeographyService.$inject = ['$baseService', '$sabio'];

    function GeographyService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.geography;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();