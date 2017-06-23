(function () {   
    angular
        .module(APPNAME)
        .component('project', {
            bindings: {
                project: "<"
            },
            templateUrl: "/Scripts/app/Project/ProjectTemplate.html",
            controller: "projectController as pVm"
        })
})();