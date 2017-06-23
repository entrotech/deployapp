(function () {
    angular.module(APPNAME)
        .factory('sweetAlertService', SweetAlertService);

    SweetAlertService.$inject = ['$baseService', '$sabio'];

    function SweetAlertService($baseService, $sabio) {
        var aSabioServiceObject = sabio.ui.sweetalert;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();