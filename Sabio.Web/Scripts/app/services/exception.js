(function () {
    "use strict";
    angular.module(APPNAME)
        .factory('exceptionService', ExceptionService);

    ExceptionService.$inject = ['$baseService', '$sabio'];

    function ExceptionService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.exception;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();