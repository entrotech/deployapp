(function () {
    "use strict";

    angular.module(APPNAME)
        .factory("calendarService", CalendarService);

    CalendarService.$inject = ["$baseService", "$sabio"];

    function CalendarService($baseService, $sabio) {
        var calendarSvcObj = sabio.services.calendar;
        var calendarService = $baseService.merge(true, {}, calendarSvcObj, $baseService);
        return calendarService;
    }
})();