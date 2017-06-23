sabio.services.jobTag = sabio.services.jobTag || {};

sabio.services.jobTag.post = function (data, onSuccess, onError) {
    var url = "/api/jobtags/";

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "POST",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobTag.put = function (id, data, onSuccess, onError) {
    var url = "/api/jobtags/" + id;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "PUT",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobTag.delete = function (id, onSuccess, onError) {
    var url = "/api/jobtags/" + id;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "DELETE",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobTag.getById = function (id, onSuccess, onError) {
    var url = "/api/jobtags/" + id;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobTag.getAll = function (onSuccess, onError) {
    var url = "/api/jobtags/";

    var settings = {
        async: false,
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}