(function () {
    "use strict";
    angular.module(APPNAME)
         .factory('personService', PersonService);

    PersonService.$inject = ['$baseService', '$sabio'];

    function PersonService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.person;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();