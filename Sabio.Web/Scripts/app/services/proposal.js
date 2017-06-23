(function () {
    "use strict";
    angular.module(APPNAME)
         .factory('proposalService', ProposalService);

    ProposalService.$inject = ['$baseService', '$sabio'];

    function ProposalService($baseService, $sabio) {
        var aSabioServiceObject = sabio.services.proposal;
        var newService = $baseService.merge(true, {}, aSabioServiceObject, $baseService);
        return newService;
    }
})();
