sabio.services.squadtag = sabio.services.squadtag || {};

sabio.services.squadtag.post = function (squadtag, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(squadtag)
        , type: "POST"
    };
    $.ajax("/api/squadtags/", settings);
};

sabio.services.squadtag.put = function (id, squadtag, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(squadtag)
        , type: "PUT"
    };
    $.ajax("/api/squadtags/" + id, settings);
}

sabio.services.squadtag.getById = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "GET"
    };
    $.ajax("/api/squadtags/" + id, settings);
}

sabio.services.squadtag.getAll = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/squadtags/", settings);
}

sabio.services.squadtag.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "DELETE"
    };
    $.ajax("/api/squadtags/" + id, settings);
}