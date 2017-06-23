angular.module(APPNAME).controller('userHomeController', UserHomeController);

UserHomeController.$inject = ['$baseController', '$rootScope', '$scope', '$window', '$sabio', 'userService', 'squadEventService', 'globalEventService']
function UserHomeController($baseController, $rootScope, $scope, $window, $sabio, userService, squadEventService, globalEventService) {
    var vm = this;
    $baseController.merge(vm, $baseController);
    vm.$scope = $scope;
    vm.$rootScope = $rootScope;
    vm.$window = $window;
    vm.$sabio = $sabio;
    vm.userService = userService;
    vm.squadEventService = squadEventService;
    vm.globalEventService = globalEventService;
    vm.item = null;
    vm.personId = 0;
    vm.getUser = _getUser;
    vm.getSquadEvents = _getSquadEvents;
    vm.getGlobalEvents = _getGlobalEvents;
    vm.squadEvents = [];
    vm.globalEvents = [];
    vm.calendarItems = [];
    vm.toSquad = _toSquad;

    _setCalendarOptions();
    _render();

    function _render() {
        _getUser();
    }
    function _getUser() {
        vm.userService.getCurrentUser(_getUserSuccess, _ajaxError);
    }
    function _getUserSuccess(data) {
        vm.$scope.$apply(function () {
            vm.item = data.item;
            console.log(vm.item);
            vm.personId = data.item.id;
            $rootScope.$broadcast('personLoad', vm.personId);
            for (var i = 0; i < vm.item.squads.length; i++) {
                vm.item.squads[i].members = [];
                _getSquadEvents(vm.item.squads[i].id);
            }
        })
        _getGlobalEvents();
    }   
    function _getSquadEvents(id) {
        vm.squadEventService.getBySquadId(id, _getSquadEventsSuccess, _ajaxError)
    }
    function _getSquadEventsSuccess(data) {
        vm.$scope.$apply(function () {
            vm.squadEvents = data.items;
            for (var i = 0; i < vm.squadEvents.length; i++) {
                vm.calendarItems.push({
                    events: [{
                        title: vm.squadEvents[i].name,
                        start: vm.squadEvents[i].eventStart,
                        end: vm.squadEvents[i].eventEnd,
                        description: vm.squadEvents[i].description,
                        url: "/squadEvents/eventDetails/" + vm.squadEvents[i].id
                    }],
                    color: "#2a72b5"
                });
            }
        })
    }
    function _getGlobalEvents() {
        vm.globalEventService.getAll(_getGlobalEventsSuccess, _ajaxError);
    }
    function _getGlobalEventsSuccess(data) {
        vm.$scope.$apply(function () {
            vm.globalEvents = data.items;
            for (var i = 0; i < vm.globalEvents.length; i++) {
                vm.calendarItems.push({
                    events: [{
                        title: vm.globalEvents[i].name,
                        start: vm.globalEvents[i].dateStart.slice(0, 10) + "T" + vm.globalEvents[i].startTime,
                        end: vm.globalEvents[i].dateEnd.slice(0, 10) + "T" + vm.globalEvents[i].endTime,
                        description: vm.globalEvents[i].description,
                        url: "/globalEvents/" + vm.globalEvents[i].id
                    }],
                    color: "orange"
                });
            }
        })
    }
    function _setCalendarOptions() {
        vm.calOptions = {
            editable: false,
            header: {
                left: "month basicWeek basicDay",
                center: "title",
                right: "today prev,next",
            },
            eventRender: function (event, element) {
                element.popover(
                    {
                        container: 'body',
                        title: "<strong>" + "Event: " + "</strong>" + event.title,
                        content: "<div>" + "<strong>" + "Start: " + "</strong>" + moment(event.start).format("LLLL") + "</div>" + "<div>" + "<strong>" + "End: " + "</strong>" + moment(event.end).format("LLLL") + "</div>" + "<div>" + "<strong>" + "Description: " + "</strong>" + event.description + "</div>" + "<div>" + "<strong>",
                        trigger: "hover",
                        html: true,
                        placement: "auto bottom"
                    });
            }
        };
    }
    function _toSquad(id) {
        vm.$window.location.href = '/squads/' + id + '/home';
    }
    function _ajaxError() {
        console.log("uh oh");
    }
    
}