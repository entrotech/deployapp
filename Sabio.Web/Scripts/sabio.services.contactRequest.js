sabio.services.contactRequest = sabio.services.contactRequest || {};

//POST
sabio.services.contactRequest.insert = function (contactRequest, onPostSuccess, onPostError) {
    var settings = {
        cache: false,
        type: "POST",
        data: contactRequest,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        datatype: "JSON",
        success: onPostSuccess,
        error: onPostError
    };
    $.ajax("/api/emails", settings);
};

//UPDATE
sabio.services.contactRequest.update = function (id, contactRequest, onUpdateReceived, onUpdateError) {
    console.log(id);

    var settings = {
        cache: false,
        type: "PUT",
        dataType: "JSON",
        success: onUpdateReceived,
        error: onUpdateError,
        data: contactRequest,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    };
    $.ajax("/api/emails/" + id, settings);
};

//GET BY ID
sabio.services.contactRequest.getById = function (id, getByIdSuccess, onError) {
    var settings = {
        cache: false
        , success: getByIdSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax("/api/emails/" + id, settings);
};

// GET ALL
sabio.services.contactRequest.getAll = function (getAllSuccess, getAllError) { 
    var settings = {
        cache: false
        , type: "GET"
        , success: getAllSuccess
        , error: getAllError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType:"JSON"
    };
    $.ajax("/api/emails/", settings);
};

// SEARCH 
sabio.services.contactRequest.search = function (searchString, onSearchSuccess, onSearchError) {
    var settings = {
        cache: false
        , success: onSearchSuccess
        , error: onSearchError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    var url = "/api/emails/search?searchString=" + searchString;

    $.ajax(url, settings);
};