//////This is just a silly Billy example of a custom directive////

(function () {
    "use strict";
    angular.module(APPNAME)
        .directive('unorderedList', UnorderedList);

    function UnorderedList() {
        return function (scope, element, attrs) {
            var propertyExpression = attrs["unorderedList"];
            var displayExpression = attrs["unorderedListDisplay"];
            var data = scope.$eval(propertyExpression);
            if (angular.isArray(data)) {
                var listElem = angular.element("<ul>")
                for (var i = 0; i < data.length; i++) {  
                    var elementText = scope.$eval(displayExpression, data[i]);
                    listElem.append(angular.element("<li>").text(elementText));
                }
                element.append(listElem);
            }
        }
    }
})();