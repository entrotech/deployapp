sabio.services.squad = sabio.services.squad || {};

//POST
sabio.services.squad.post = function (squad, onPostSuccess, onPostError) {
    var settings = {
        cache: false,
        type: "POST",
        data: squad,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        datatype: "JSON",
        success: onPostSuccess,
        error: onPostError
    };
    $.ajax("/api/squads", settings);
};

//SELECT ALL 
sabio.services.squad.getAll = function (onSuccess, getAllError) { 
    var settings = {
        cache: false
        , type: "GET"
        , success: onSuccess
        , error: getAllError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , datatype:"JSON"
    };
    $.ajax("/api/squads/", settings);
};

//UPDATE
sabio.services.squad.update = function (id, squad, onUpdateReceived, onUpdateError) {
    console.log(id);

    var settings = {
        cache: false,
        type: "PUT",
        dataType: "json",
        success: onUpdateReceived,
        error: onUpdateError,
        data: squad + "&id=" + id,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8"
    };
    $.ajax("/api/squads/" + id, settings);
};

//DELETE
sabio.services.squad.delete = function (id, onDeleteSuccess, onDeleteError) {
    var settings = {
        cache: false
                , success: onDeleteSuccess
                , error: onDeleteError
                , dataType: "json"
                , type: "DELETE"
    };
    $.ajax("/api/squads/" + id, settings);
};

//GET BY ID
sabio.services.squad.getById = function (id, getByIdSuccess, onError) {
    var settings = {
        cache: false
        , success: getByIdSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax("/api/squads/" + id, settings);
};

// SEARCH 
sabio.services.squad.search = function (searchString, onSearchSuccess, onSearchError) {
    var settings = {
        cache: false
        , success: onSearchSuccess
        , error: onSearchError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    }
    var url = "/api/squads/search?searchString=" + searchString;

    $.ajax(url, settings);
}
 
//-----------------ANGULAR CALLS-------------

//GET ALL
sabio.services.squad.getAllJson = function (onSuccess, getAllError) {
    var settings = {
        cache: false
        , type: "GET"
        , success: onSuccess
        , error: getAllError
        , contentType: "application/json; charset=UTF-8"
        , datatype: "JSON"
    };
    $.ajax("/api/squads/", settings);
};

//POST
sabio.services.squad.postJson = function (data, onPostSuccess, onPostError) {
    var settings = {
        cache: false,
        type: "POST",
        data: JSON.stringify(data),
        contentType: "application/json; charset=UTF-8",
        datatype: "JSON",
        success: onPostSuccess,
        error: onPostError
    };
    $.ajax("/api/squads", settings);
};

//UPDATE
sabio.services.squad.updateJson = function (id, data, onUpdateReceived, onUpdateError) {
    console.log(id);

    var settings = {
        cache: false,
        type: "PUT",
        dataType: "json",
        success: onUpdateReceived,
        error: onUpdateError,
        data: JSON.stringify(data),
        contentType: "application/json; charset=UTF-8"
    };
    $.ajax("/api/squads/" + id, settings);
};

//GET BY ID
sabio.services.squad.getByIdJson = function (id, getByIdSuccess, onError) {
    var settings = {
        cache: false
        , success: getByIdSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax("/api/squads/" + id, settings);
};

//==========Person Ajax Calls=============

sabio.services.squad.searchPersonResults = function (data, onSuccess, onError) { //PersonSearch
    var settings = {
        cache: true
  , success: onSuccess
  , error: onError
  , contentType: "application/json; charset=UTF-8"
  , type: "GET"
    };
    $.ajax("/api/squads/PersonSearch?searchstring=" + data, settings);

};

sabio.services.squad.postPerson = function (data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "POST"
    };
    $.ajax("/api/squadmembers", settings);
};








