sabio.services.calendar = sabio.services.calendar || {};

sabio.services.calendar.squadEventGetAll = function (onSuccess, onError) {
    var url = "/api/calendar"

    var settings = {
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
};