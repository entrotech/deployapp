(function () {
    "use strict"
    angular.module(APPNAME)
        .factory('companyService', CompanyService);

    CompanyService.$inject = ['$baseService', '$sabio'];

    function CompanyService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.company;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }


})();