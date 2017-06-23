sabio.services.language = sabio.services.language || {};

// Create - GET - activeID
sabio.services.language.getById = function (id, onSuccess, onError) {
    var url = "/api/languages/" + id;

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
sabio.services.language.post = function (data, onSuccess, onError) {
    var url = "/api/languages/";
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

//PostJson for Angular
sabio.services.language.postJson = function (language, onSuccess, onError) {
    var url = "/api/languages/";
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(language)
        , type: "POST"
    };
    $.ajax(url, settings);
}

// Create - PUT - update entry
sabio.services.language.put = function (id, data, onSuccess, onError) {
    var url = "/api/languages/" + id;
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "PUT"
        , success: onSuccess
        , error: onError
    };
    $.ajax(url, settings);
}

//PutJson for Angular
sabio.services.language.putJson = function (id, language, onSuccess, onError) {
    var url = "/api/languages/" + id;
    var settings = {
        cache: false
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(language)
        , type: "PUT"
        , success: onSuccess
        , error: onError
    };
    $.ajax(url, settings);
}

// Create - DELETE - delete entry
sabio.services.language.delete = function (id, onSuccess, onError) {
    var url = "/api/languages/" + id;
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
sabio.services.language.getLanguages = function (onSuccess, onError) {
    var url = "/api/languages/";
    var settings = {
        cache: false
        , dataType: "json"
        , type: "GET"
        , success: onSuccess
        , error: onError
    };
    $.ajax(url, settings);
}