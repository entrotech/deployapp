(function () {
    'use strict';
    angular.module(APPNAME)
        .controller('layoutController', LayoutController);
    LayoutController.$inject = ['$scope', '$window', '$baseController', 'timecardEntryService', '$sabio', '$location', '$timeout', '$anchorScroll'];

    function LayoutController($scope, $window, $baseController, timecardEntryService, $sabio, $location, $timeout, $anchorScroll) {
        // Administrative stuff
        var vm = this;
        vm.$scope = $scope;
        vm.$sabio = $sabio;
        // Simulate inheritance to add
        // $document, $log, $route, $routeParams, $systemEventService, $alertService, $sabio services
        // to our controller.
        vm.$location = $location;
        $baseController.merge(vm, $baseController);
        vm.timecardEntryService = timecardEntryService;
        vm.$window = $window;
        vm.logout = _logout;
        vm.item = null;
        vm.model = $sabio.model;
        vm.isAdmin = vm.model.isAdmin;
        
        _navBehavior();

        function _navBehavior() {
            $('ul.navbar-right>li.dropdown>a.dropdown-toggle').on('mouseenter', function () {
                $(this).click();
            });
        }

        //Logout Functions
        function _logout() {
            sabio.services.user.getLogout(_logoutSuccess, _logoutError);
        }

        function _logoutSuccess() {
            window.location.href = "/";
        }

        function _logoutError() {
            toastr.error("Failed to logout");
        }
    }

})();