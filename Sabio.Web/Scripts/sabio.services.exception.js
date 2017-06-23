sabio.services.exception = sabio.services.exception || {};

sabio.services.exception.getAll = function (onSuccess, onError) {
    var url = "/api/exceptions";

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    }

    $.ajax(url, settings);
}

sabio.services.exception.search = function (searchString, onSuccess, onError) {
    var url = "/api/exceptions/search?" + searchString;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    }

    $.ajax(url, settings);
}