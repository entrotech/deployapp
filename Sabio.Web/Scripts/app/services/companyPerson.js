(function () {
    angular.module(APPNAME)
        .factory('companyPersonService', CompanyPersonService);

    CompanyPersonService.$inject = ['$baseService', '$sabio'];

    function CompanyPersonService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.companyperson;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();