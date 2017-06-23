sabio.services.militaryBase = sabio.services.militaryBase || {};

sabio.services.militaryBase.post = function (militaryBase, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: militaryBase
        , type: "POST"
    };
    $.ajax("/api/militarybases/", settings);
}

sabio.services.militaryBase.put = function (id, militaryBase, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: militaryBase
        , type: "PUT"
    };
    $.ajax("/api/militarybases/" + id, settings);
}

sabio.services.militaryBase.getById = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "GET"
    };
    $.ajax("/api/militarybases/" + id, settings);
}

sabio.services.militaryBase.getAll = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax("/api/militarybases/", settings);
}

sabio.services.militaryBase.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "DELETE"
    };
    $.ajax("/api/militarybases/" + id, settings);
}


//============ServiceBranch GetAll===========

sabio.services.militaryBase.getAllServiceBranches = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax("/api/ServiceBranches/", settings);
}