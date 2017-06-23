(function () {
    "use strict";

    angular.module(APPNAME)
        .factory("globalEventService", GlobalEventService);

    GlobalEventService.$inject = ["$baseService", "$sabio"];

    function GlobalEventService($baseService, $sabio) {
        var globalEventSvcObj = sabio.services.globalEvent;
        var globalEventService = $baseService.merge(true, {}, globalEventSvcObj, $baseService);
        return globalEventService;
    }
})();