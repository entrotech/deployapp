sabio.services.proposal = sabio.services.proposal || {};

sabio.services.proposal.post = function (data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "POST"
    };
    $.ajax("/api/proposals/", settings);
};

sabio.services.proposal.search = function (name, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/proposals/search?name=" + name, settings);
}

sabio.services.proposal.postJSON = function (data, onSuccess, onError) {
    var settings = {
        cache: false
         , success: onSuccess
         , error: onError
         , contentType: "application/json; charset=UTF-8"
         , dataType: "json"
         , data: JSON.stringify(data)
         , type: "POST"
    };
    $.ajax("/api/proposals/", settings);
};

sabio.services.proposal.put = function (id, data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data + "&id=" + id
        , type: "PUT"
    };
    $.ajax("/api/proposals/" + id, settings);
};
sabio.services.proposal.putJSON = function (id, data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data:JSON.stringify(data)
        , type: "PUT"
    };
    $.ajax("/api/proposals/" + id, settings);
};


sabio.services.proposal.getById = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(id)
        , type: "GET"

    };
    $.ajax("/api/proposals/" + id, settings);
};

sabio.services.proposal.getAll = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/proposals/", settings);
};

sabio.services.proposal.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , dataType: "json"
        , type: "DELETE"
    };
    $.ajax("/api/proposals/" + id, settings);
};