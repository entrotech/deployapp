﻿


(function () {
    "use strict";
    angular.module(APPNAME)
        .directive('googlePlace', GooglePlace);

    GooglePlace.$inject = ['$rootScope'];

    function GooglePlace($rootScope) {
        return {
            require: 'ngModel'
            , scope: {
                ngModel: '='
                , details: '=?'
            },
            link: function (scope, element, attrs, model) {
                var options = {
                    types: []
                    , componentRestrictions: {}
                };
                scope.gPlace = new google.maps.places.Autocomplete(element[0], options);
                google.maps.event.addListener(scope.gPlace, 'place_changed', function () {
                    scope.$apply(function () {
                        scope.details = scope.gPlace.getPlace();
                        model.$setViewValue(element.val());
                        $rootScope.$broadcast('place_changed', scope.details);
                    });
                });
            }
        };
    }
})();



