sabio.services.announcement = sabio.services.announcement || {};

sabio.services.announcement.post = function (announcement, onSuccess, onError) {
    var url = "/api/announcements/"

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(announcement),
        type: "POST"
    };

    $.ajax(url, settings);
};

sabio.services.announcement.put = function (id, announcement, onSuccess, onError) {
    var url = "/api/announcements/" + id

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(announcement),
        type: "PUT"
    };

    $.ajax(url, settings);
};

sabio.services.announcement.uploadImage = function (data, onSuccess, onError) {
    var url = "/api/announcements/" + data.id + "/image";

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(data),
        type: "PUT"
    };

    $.ajax(url, settings);
};

sabio.services.announcement.getById = function (id, onSuccess, onError) {
    var url = "/api/announcements/" + id;

    var settings = {
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
};

sabio.services.announcement.getAll = function (onSuccess, onError) {
    var url = "/api/announcements/"

    var settings = {
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
};

sabio.services.announcement.getAllWithCategories = function (onSuccess, onError) {
    var url = "/api/announcements/withCategories";

    var settings = {
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
};

sabio.services.announcement.deleteById = function (id, onSuccess, onError) {
    var url = "/api/announcements/" + id;

    var settings = {
        cache: false,
        dataType: "json",
        type: "DELETE",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
};

sabio.services.announcement.deleteImage = function (id, onSuccess, onError) {
    var url = "/api/announcements/" + id + "/deleteImage";

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        type: "PUT"
    };

    $.ajax(url, settings);
};