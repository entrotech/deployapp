(function () {
    angular.module(APPNAME)
        .controller('timecardController', TimecardController);
    TimecardController.$inject = ['$scope', '$window', '$baseController', 'timecardEntryService', '$sce'];

    function TimecardController($scope, $window, $baseController, timecardEntryService, $sce) {
        // Administrative stuff
        var vm = this;
        var sortReverse = false;
        vm.$scope = $scope;
        // Simulate inheritance to add
        // $document, $log, $route, $routeParams, $systemEventService, $alertService, $sabio services
        // to our controller.
        $baseController.merge(vm, $baseController);
        vm.timecardEntryService = timecardEntryService;
        vm.$window = $window;

        // ViewModel
        vm.goHome = _goHome;
        vm.model = $scope.$parent.exVm;
        vm.items = [];
        vm.item = null;  // copy of item being edited
        vm.itemIndex = -1; // index of item being edited
        vm.filteredItems = [];
        vm.currentPage = 1;
        vm.itemsPerPage = 10;
        vm.totalItems = 50;
        vm.select = _select;
        vm.save = _save;
        vm.cancel = _cancel;
        vm.add = _add;
        vm.delete = _delete;
        vm.pageChanged = _pageChanged;
        vm.filter = _filter;
        vm.sort = _sort;
        vm.approve = _approve;

        //MinMax date settings for datepicker
        vm.optionsFrom = { format: 'LLL', showClear: true };
        vm.optionsTo = { format: 'LLL', showClear: true };
        vm.update = function (startDateTimeUtc, endDateTimeUtc) {
            vm.optionsFrom.maxDate = endDateTimeUtc;
            vm.optionsTo.minDate = startDateTimeUtc;
        };

        // "The fold"

        _render();

        function _render() {
            var projectId = vm.model.id;
            vm.timecardEntryService.getByProjectId(projectId, _getAllSuccess, _getAllError);
        }

        function _pageChanged() {
            var begin = ((vm.currentPage - 1) * vm.itemsPerPage);
            var end = begin + vm.itemsPerPage;
            vm.filteredItems = vm.items.slice(begin, end);
        }

        function _pageReset() {
            vm.currentPage = 1;
        }

        function _pageRefresh() {
            $window.location.reload();
        }

        function _goHome() {
            vm.$window.location.href = '/';
        }

        function _sort(prop) {
            vm.items.sort(_generateSortFn(prop, sortReverse));
            _pageChanged()
            sortReverse = !sortReverse;
        }

        function _generateSortFn(prop, reverse) {
            if (reverse) {
                return function (a, b) {
                    if (a[prop] < b[prop]) return -1;
                    if (a[prop] > b[prop]) return 1;
                    return 0;
                };
            } else {
                return function (a, b) {
                    if (a[prop] < b[prop]) return 1;
                    if (a[prop] > b[prop]) return -1;
                    return 0;
                };
            }

        }

        function _toLocalTime() {
            vm.item.startDateTimeLocal = vm.item.startDateTimeUtc.format()
            vm.item.endDateTimeLocal = vm.item.endDateTimeUtc.format()

            vm.item.startDateTimeUtc = vm.item.startDateTimeUtc.toISOString()
            vm.item.endDateTimeUtc = vm.item.endDateTimeUtc.toISOString()
        }

        function _hoursWorked(items) {
            for (var i = 0; i < items.length; i++) {
                a = moment(items[i].endDateTimeUtc).diff(moment(items[i].startDateTimeUtc))
                items[i].hoursWorked = moment.duration(a).asHours().toFixed(1)
                items[i].hoursWorked = parseFloat(items[i].hoursWorked);
            }

            return items
        }

        function _filter(person, status) {          
            if (person) {
                var personId = person;
            } else {
                var personId = "";
            }
            if (status) {
                var timecardStatusId = status;
            } else {
                var timecardStatusId = "";
            }
            var projectId = vm.model.id;
            
            vm.timecardEntryService.search("", projectId, personId, timecardStatusId, _getAllSuccess, _getAllError)
        }

        function _getAllSuccess(data) {
            _pageReset()
            vm.$scope.$apply(function () {
                if (data.items) {
                    var items = _hoursWorked(data.items)
                    vm.totalItems = data.items.length;
                    vm.items = items;
                    for (var i = 0; i < items.length; i++) {
                        vm.items[i].fullName = items[i].firstName + " " + items[i].lastName;
                    }
                    vm.filteredItems = vm.items.slice(0, vm.itemsPerPage);
                } else {
                    vm.filteredItems = [];
                    vm.items = [];
                    vm.totalItems = 0;
                }
            });
            vm.$alertService.success("Retrieved all");
        }

        function _getAllError(jqXHR) {
            vm.$alertService.error(jqXHR.responseText, "GetAll failed");
        }

        function _select(data) {
            // Keep track of the position in vm.items of
            // the item we will be editing
            vm.itemIndex = vm.items.indexOf(data);
            // get a fresh copy of the object to be edited from the database.
            vm.timecardEntryService.search(data.id, "", "", "", _getByIdSuccess, _getByIdError)
        }

        function _getByIdSuccess(data) {
            if (data.items && data.items.length > 0) {
                vm.$scope.$apply(function () {
                    vm.item = data.items[0];
                });
            }
            vm.$alertService.success("Retrieved item for editing from database");
        }

        function _getByIdError(jqXHR) {
            vm.$alertService.error(jqXHR.responseText, "GetById failed");
        }

        // create a new empty item
        function _add() {
            vm.item = {};
            vm.itemIndex = -1;
        }

        function _cancel() {
            _endEdit();
        }

        function _endEdit() {
            vm.item = null;
            vm.itemIndex = -1;
        }

        //Save Functions
        function _save(person, status) {
            _toLocalTime()
            vm.item.projectId = vm.model.id;
            vm.item.timecardStatusId = status;
            if (vm.item.id) {
                vm.timecardEntryService.put(vm.item.id, vm.item, _putSuccess, _putError);
            }
            else {
                vm.item.personId = person;
                vm.item.projectId = vm.model.id;
                vm.item.timecardStatusId = 1
                vm.timecardEntryService.post(vm.item, _postSuccess, _postError);
            }
        }


        function _putSuccess(data) {
            vm.$scope.$apply(function () {
                // To update UI, replace with new version
                vm.items[vm.itemIndex] = vm.item;
                _pageRefresh();
            });
        }

        function _putError(jqXHR) {
            vm.$alertService.error(jqXHR.responseText, "Update failed");
        }

        function _postSuccess(data) {
            if (data.item) {
                vm.$scope.$apply(function () {
                    _pageRefresh()
                });
            }
        }

        function _postError(jqXHR) {
            vm.$alertService.error(jqXHR.responseText, "Insert failed");
        }

        //Delete Functions
        function _delete(item) {
            if (item.id) {
                sabio.ui.sweetalert.delete(item.id, vm.timecardEntryService.delete, _deleteSuccess, _deleteError)
            }
        }

        function _deleteSuccess(data) {
            vm.$scope.$apply(function () {
                // To update UI, replace with new version
                vm.items.splice(vm.itemIndex, 1);
                _render();
                vm.$alertService.success("Delete successful");
            });
        }

        function _deleteError(jqXHR) {
            vm.$alertService.error(jqXHR.responseText, "Delete failed");
        }

        function _approve(item) {
            //_toLocalTime()
            //vm.item.projectId = vm.model.id;
            item.timecardStatusId = 2;
            vm.timecardEntryService.put(item.id, item, _putSuccess, _putError);
        }
    }
})();