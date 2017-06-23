angular.module(APPNAME).component('personProject', {
    templateUrl: '/Scripts/app/personProject/personProject.html',
    controller: 'projController as pjVm',
    bindings: {
        person: '<'
    }
})