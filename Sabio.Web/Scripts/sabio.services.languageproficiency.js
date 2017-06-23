sabio.services.languageProficiency = sabio.services.languageProficiency || {};

// Create - GET - activeID
sabio.services.languageProficiency.readById = function (id, onSuccess, onError) {
    //
    var url = "/api/languageproficiency/" + id;

    var settings = {
        cache: false
        ,contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , type: "GET"
        , success: onSuccess
        , error: onError
    };

    $.ajax(url, settings);
}

// Create - POST - submit new entry
sabio.services.languageProficiency.create = function (data, onSuccess, onError) {
	var url = "/api/languageproficiency/";
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "json"
        , dataType: "json"
        , data: data
        , type: "POST"
    };
    $.ajax(url, settings);
}

// Create - PUT - update entry
sabio.services.languageProficiency.update = function (id, data, onSuccess, onError) {
    var url = "/api/languageproficiency/" + id;
    var settings = {
        cache: false
        , contentType: "json"
        , dataType: "json"
        , data: data
        , type: "PUT"
        , success: onSuccess
        , error: onError
    };
    $.ajax(url, settings);
}

// Create - DELETE - delete entry
sabio.services.languageProficiency.delete = function (id, onSuccess, onError) {
    var url = "/api/languageproficiency/" + id;
    var settings = {
        cache: false
        , dataType: "json"
        , type: "DELETE"
        , success: onSuccess
        , error: onError
    };
    $.ajax(url, settings);
}

// Index - GET - get all entries
sabio.services.languageProficiency.read = function (onSuccess, onError) {
    var url = "/api/languageproficiency/";
    var settings = {
        cache: false
        , dataType: "json"
        , type: "GET"
        , success: onSuccess
        , error: onError
    };
    $.ajax(url, settings);
}