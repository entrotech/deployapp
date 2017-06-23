angular.module(APPNAME).component('personJob', {
    templateUrl: '/Scripts/app/personJob/personJob.html',
    controller: 'jobAppController as jaVm',
    bindings: {
        person: '<'
    }
})