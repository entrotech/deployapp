(function () {
    "use strict";
    angular.module('SabioApp')
         .factory('languageService', LanguageService);

    function LanguageService() {
        var aSabioServiceObject = sabio.services.language;
        return aSabioServiceObject;
    }

})();