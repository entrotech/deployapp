(function () {
    angular.module(APPNAME)
        .directive('ocCurrentTime', OcCurrentTime);

    OcCurrentTime.$inject = ['$interval', 'dateFilter'];
    
    function OcCurrentTime($interval, dateFilter) {
        return {
            link: link
        };

        function link(scope, element, attrs) {
            var format,
                timeoutId;

            function updateTime() {
                element.text(dateFilter(new Date(), format));
            }

            scope.$watch(attrs.ocCurrentTime, function (value) {
                format = value;
                updateTime();
            });

            element.on('$destroy', function () {
                $interval.cancel(timeoutId);
            });

            // start the UI update process; save the timeoutId for canceling
            timeoutId = $interval(function () {
                updateTime(); // update DOM
            }, 1000);
        }
    }
})();