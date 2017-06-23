(function () {
    "use strict";

    angular.module(APPNAME)
        .factory("announcementService", AnnouncementService);

    AnnouncementService.$inject = ["$baseService", "$sabio"];

    function AnnouncementService($baseService, $sabio) {
        var announcementSvcObj = sabio.services.announcement;
        var announcementService = $baseService.merge(true, {}, announcementSvcObj, $baseService);
        return announcementService;
    }
})();