sabio.services.contactUsers = sabio.services.contactUsers || {};

sabio.services.contactUsers.sendEmail = function (data, onSuccess, onError) {
    var url = "/api/contactusers/";

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "POST",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}

sabio.services.contactUsers.getUserRoles = function (onSuccess, onError) {
    var url = "/api/contactusers/";

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