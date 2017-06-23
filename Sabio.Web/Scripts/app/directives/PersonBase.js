(function () {

    angular.module(APPNAME)
        .directive('ocPersonBase', OcPersonBase);

    function OcPersonBase() {
        return {
            restrict: 'E',
            scope: {
                person: '=ocPerson'
            },
            templateUrl: '/Scripts/app/directives/PersonBase.html'
        };
    }

})();
