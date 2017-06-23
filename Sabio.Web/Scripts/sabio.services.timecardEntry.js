sabio.services.timecardEntry = sabio.services.timecardEntry || {};

sabio.services.timecardEntry.post = function (timecardEntry, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(timecardEntry)
        , type: "POST"
    };
    $.ajax("/api/timecardEntry/", settings);
}

sabio.services.timecardEntry.put = function (id, timecardEntry, onSuccess, onError) {
    timecardEntry.id = id;
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(timecardEntry)
        , type: "PUT"
    };
    $.ajax("/api/timecardEntry/" + id, settings);
}

sabio.services.timecardEntry.search = function (id, projectId, personId, timecardStatus, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/timecardEntry/search?id=" + id + "&projectId=" + projectId + "&personId=" + personId + "&timecardStatusId=" + timecardStatus, settings);
}

sabio.services.timecardEntry.getByProjectId = function (projectId, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/timecardEntry/search?projectId=" + projectId, settings);
}

sabio.services.timecardEntry.getAll = function (onSuccess, onError) {
    var url = "/api/timecardEntry/"
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax(url, settings);
}

sabio.services.timecardEntry.getById = function (id, onSuccess, onError) {
    var url = "/api/timecardEntry/" + Id
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax(url, settings);
}

sabio.services.timecardEntry.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "DELETE"
    };
    $.ajax("/api/timecardEntry/" + id, settings);
}