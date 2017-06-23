sabio.services.project = sabio.services.project || {};

sabio.services.project.post = function (data, onSuccess, onError) {
    var url = "/api/projects/";
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "POST"
    };
    $.ajax(url, settings);
}

sabio.services.project.postJson = function (data, onSuccess, onError) {
    var url = "/api/projects/";
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "POST"
    };
    $.ajax(url, settings);
}

sabio.services.project.put = function (id, data, onSuccess, onError) {
    var url = "/api/projects/" + id;
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "PUT"
    };
    $.ajax(url, settings);
}

sabio.services.project.putJson = function (id, data, onSuccess, onError) {
    var url = "/api/projects/" + id;
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "PUT"
    };
    $.ajax(url, settings);
}

sabio.services.project.getById = function (id, onSuccess, onError) {
    var url = "/api/projects/" + id;
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , type: "GET"

    };
    $.ajax(url, settings);
}

sabio.services.project.getAll = function (onSuccess, onError) {
    var url = "/api/projects/";
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , dataType: "json"
        , type: "GET"
    };
    $.ajax(url, settings);
}

sabio.services.project.delete = function (id, onSuccess, onError) {
    var url = "/api/projects/" + id;
    var settings = {
        cache: false
      , success: onSuccess
      , error: onError
      , dataType: "json"
      , type: "DELETE"
    };
    $.ajax(url, settings);
}


// ---- Project Person Ajax Calls -----


sabio.services.project.postPerson = function (data, onSuccess, onError) {
    var url = "/api/projectperson"
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "POST"
    };
    $.ajax(url, settings);
}

sabio.services.project.putPerson = function (data, onSuccess, onError) {
    var url = "/api/projectperson"
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "PUT"
    };
    $.ajax(url, settings);
}

// ------- Project Person Status Ajax Calls ------ //

sabio.services.project.getAllStatus = function (onSuccess, onError) {
    var url = "/api/projectpersonstatus/";
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , dataType: "json"
        , type: "GET"
    };
    $.ajax(url, settings);
}

// ------ Person Ajax Calls ----- //

sabio.services.project.personSearch = function (data, onSuccess, onError) { //PersonSearch
    var settings = {
        cache: true
  , success: onSuccess
  , error: onError
  , contentType: "application/json; charset=UTF-8"
  , type: "GET"
    };
    $.ajax("/api/squads/PersonSearch?searchstring=" + data, settings);
  

};