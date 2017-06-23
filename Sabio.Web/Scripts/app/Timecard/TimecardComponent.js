(function () {
    angular
        .module(APPNAME)
        .component('timecard', {
            bindings: {
                timecard: "=",
                productId: "<"
            },
            templateUrl: "/Scripts/app/Timecard/TimecardTemplate.html",
            controller: "timecardController as tVm"
        })
})();