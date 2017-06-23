(function () {
    "use strict";
    angular.module(APPNAME)
        .factory('aspNetUserRoleService', AspNetUserRoleService);

    AspNetUserRoleService.$inject = ['$baseService', '$sabio'];

    function AspNetUserRoleService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.AspNetUserRole;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();