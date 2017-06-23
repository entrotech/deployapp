angular.module(APPNAME).controller('projController', ProjController);

ProjController.$inject = ['$scope', '$baseController', 'personService', 'timecardEntryService', '$sabio', '$window']
function ProjController($scope, $baseController, personService, timecardEntryService, $sabio, $window) {
    var vm = this;
    $baseController.merge(vm, $baseController);
    vm.$scope = $scope;
    vm.$sabio = $sabio;
    vm.$window = $window;
    vm.personService = personService;
    vm.person = null;
    vm.projects = [];
    vm.model = $sabio.model;
    vm.date = new Date();
    vm.clockIn = _clockIn;
    vm.clockOut = _clockOut;
    vm.timecardEntryService = timecardEntryService;

    vm.$onChanges = function (changes) {
        if (changes && changes.person && changes.person.currentValue) {
            _getProjects();
        }
    }
    function _getProjects() {
        vm.personService.getProjects(vm.person.id, _getProjectSuccess, _ajaxError);
    }
    function _getProjectSuccess(data) {
        vm.$scope.$apply(function () {            
            vm.projects = data.items;
            console.log(vm.projects);
            vm.projects.reverse();
        });
    }
    function _ajaxError() {
        alert("uh oh proj");
    }
    //Timecard Functions
    function _clockIn(projectId) {
        var post = {};
        post.personId = vm.person.id;
        post.timecardStatusId = 1;
        post.projectId = projectId;
        post.startDateTimeUtc = moment().toISOString();
        post.startDateTimeLocal = moment().format();
        vm.timecardEntryService.post(post, _postSuccess, _postError);
    }
    function _clockOut() {
        var put = {}
        put.id = vm.model.timecardEntry.id;
        put.timecardStatusId = 1;
        put.personId = vm.person.id;
        put.projectId = vm.model.timecardEntry.projectId;
        put.startDateTimeUtc = vm.model.timecardEntry.startDateTimeUtc;
        put.startDateTimeLocal = moment(put.startDateTimeUtc).format();
        put.endDateTimeUtc = moment().toISOString();
        put.endDateTimeLocal = moment().format();
        vm.timecardEntryService.put(put.id, put, _putSuccess, _putError);
    }
    function _putSuccess(data) {
        vm.$alertService.success("Clocked Out");
        $window.location.reload();
    }
    function _putError(jqXHR) {
        vm.$alertService.error(jqXHR.responseText, "Update failed");
    }
    function _postSuccess(data) {
        vm.$alertService.success("Clocked In");
        $window.location.reload();
    }
    function _postError(jqXHR) {
        vm.$alertService.error(jqXHR.responseText, "Insert failed");
    }
}