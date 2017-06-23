sabio.services.educationlevel = sabio.services.educationlevel || {};

sabio.services.educationlevel.post = function (data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "POST"
    };
    $.ajax("/api/educationlevels/", settings);
}

sabio.services.educationlevel.put = function (id, data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "PUT"
    };
    $.ajax("/api/educationlevels/" + id, settings);
}

sabio.services.educationlevel.getById = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "GET"
    };
    $.ajax("/api/educationlevels/" + id, settings);
}

sabio.services.educationlevel.getAll = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/educationlevels/", settings);
}

sabio.services.educationlevel.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "DELETE"
    };
    $.ajax("/api/educationlevels/" + id, settings);
}

sabio.services.educationlevel.searchPersonResults = function (data, onSuccess, onError) { //PersonSearch
    var settings = {
   cache: true
  , success: onSuccess
  , error: onError
  , contentType: "application/json; charset=UTF-8"
  , type: "GET"
    };
    $.ajax("/api/squads/PersonSearch?searchstring=" + data, settings);

}

sabio.services.educationlevel.postPerson = function (data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "POST"
    };
    $.ajax("/api/squadmembers/", settings);
}