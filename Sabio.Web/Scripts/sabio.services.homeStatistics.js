sabio.services.homeStatistics = sabio.services.homeStatistics || {}

sabio.services.homeStatistics.update = function (data, onSuccess, onError) {
    var url = "/api/homestatistics";

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "PUT",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}

sabio.services.homeStatistics.getAll = function (onSuccess, onError) {
    var url = "/api/homestatistics";

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}