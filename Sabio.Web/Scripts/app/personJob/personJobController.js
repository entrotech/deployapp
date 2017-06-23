angular.module(APPNAME).controller('jobAppController', JobAppController);

JobAppController.$inject = ['$baseController', 'jobApplicationService', '$sabio', '$scope', '$window']
function JobAppController($baseController, jobApplicationService, $sabio, $scope, $window) {
    var vm = this;
    $baseController.merge(vm, $baseController);
    vm.$sabio = $sabio;
    vm.$scope = $scope;
    vm.$window = $window;
    vm.jobApplicationService = jobApplicationService;
    vm.person = null;
    vm.jobs = [];
    vm.toJob = _toJob;
    vm.currentPage = 1;
    vm.totalJobs = 0;
    vm.jobsPerPage = 5;
    vm.pageChanged = _pageChanged;
    vm.filteredJobs = [];

    vm.$onChanges = function (changes) {
        if (changes && changes.person && changes.person.currentValue) {
            _getJobApps();
        }
    }
    function _getJobApps() {
        vm.jobApplicationService.getByPersonId(vm.person.id, _getJobSuccess, _ajaxError);
    }
    function _getJobSuccess(data) {
        vm.$scope.$apply(function () {
            vm.jobs = data.items;
            vm.jobs.reverse();
            vm.totalJobs = data.items.length;
            vm.filteredJobs = vm.jobs.slice(0, vm.jobsPerPage);
        })
    }
    function _ajaxError() {
        alert("uh oh job");
    }
    function _toJob(id) {
        vm.$window.location.href = '/jobpostings/' + id;
    }
    function _pageChanged() {
        var begin = ((vm.currentPage - 1) * vm.jobsPerPage);
        var end = begin + vm.jobsPerPage;
        vm.filteredJobs = vm.jobs.slice(begin, end);
    }

}