(function () {
            "use strict";
            angular.module(APPNAME)
                .factory('timecardEntryService', TimecardEntryService);

            TimecardEntryService.$inject = ['$baseService', '$sabio'];    //  $sabio is a reference to sabio.page object which is created in sabio.js

            function TimecardEntryService($baseService, $sabio) {
                var aSabioServiceObject = sabio.services.timecardEntry;
                // Simlates inheritance, giving access to $window and $location services and the getNotifier function
                // to our new service.
                var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
                return newService;
            }
        })();