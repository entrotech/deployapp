(function () {
    "use strict";
    angular.module(APPNAME)
        .factory('userService', UserService);

    UserService.$inject = ['$baseService', '$sabio'];

    function UserService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.user;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();