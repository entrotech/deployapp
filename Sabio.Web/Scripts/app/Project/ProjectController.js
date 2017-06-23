(function () {
    angular.module(APPNAME)
        .controller('projectController', ProjectController)

    ProjectController.$inject = ['$scope', '$window', '$baseController', 'projectsService', '$sabio', '$sce']

    function ProjectController($scope, $window, $baseController, projectsService, $sabio, $sce) {
        // Administrative stuff
        var vm = this;
        vm.$scope = $scope;
        // Simulate inheritance to add
        // $document, $log, $route, $routeParams, $systemEventService, $alertService, $sabio services
        // to our controller.
        $baseController.merge(vm, $baseController);
        vm.projectsService = projectsService;
        vm.$window = $window;

        // ViewModel
        vm.item = null;  // copy of item being edited
        vm.sanitize = _sanitize;

        // "The fold"
        //vm.$onInit = function () {
        //    $http.get('/api/projects/' + sabio.page.model.projects[0].id).then(function (data) {
        //        vm.item = data;
        //    });

        _render();

        function _render() {
            vm.projectsService.getById(sabio.page.model.projects[0].id, _getByIdSuccess, _getByIdError);
        }

        function _sanitize(html_code) {
            return $sce.trustAsHtml(html_code);
        }

        function _toLocal(item) {
                item.deadline = moment(item.deadline).format("DD MMM YYYY")
                item.dateCreated = moment(item.deadline).format("DD MMM YYYY")
            return item
        }

        function _getByIdSuccess(data) {
            vm.$scope.$apply(function () {
                if (data.item) {
                    data.item = _toLocal(data.item);
                }
                vm.item = data.item;
            });
            vm.$alertService.success("Retrieved Project");
        }

        function _getByIdError(jqXHR) {
            vm.$alertService.error(jqXHR.responseText, "GetById failed");
        }
    }
})();