(function () {
    "use strict";
    angular.module(APPNAME)
         .factory('squadEventService', SquadEventService);

    SquadEventService.$inject = ['$baseService', '$sabio'];

    function SquadEventService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.squadEvent;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();