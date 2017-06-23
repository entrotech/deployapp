sabio.services.squadEvent = sabio.services.squadEvent || {};



sabio.services.squadEvent.post = function (data, onSuccess, onError) {
    var url = "/api/SquadEvents";

    var settings = {
        cache: false,
        dataType: "json",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        type: "POST",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}

sabio.services.squadEvent.put = function (id, data, onSuccess, onError) {
    var url = "/api/SquadEvents/" + id;

    var settings = {
        cache: false,
        dataType: "json",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data + "&id=" + id,
        type: "PUT",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}

sabio.services.squadEvent.getById = function (id, onSuccess, onError) {
    var url = "/api/SquadEvents/" + id;

    var settings = {
        data: id,
        cache: false,
        type: "GET",
        dataType: "json",
        xhrFields: {
            withCredentials: true
        },
        success: onSuccess,
        error: onError
    };
    $.ajax(url, settings);
}

sabio.services.squadEvent.getBySquadId = function (squadId, onSuccess, onError) {
    var url = "/api/SquadEvents/" + squadId + "/squad";

    var settings = {
        data: squadId,
        cache: false,
        type: "GET",
        dataType: "json",
        xhrFields: {
            withCredentials: true
        },
        success: onSuccess,
        error: onError
    };
    $.ajax(url, settings);
}

sabio.services.squadEvent.getAll = function (onSuccess, onError) {
    var url = "/api/SquadEvents"

    var settings = {
        cache: false,
        type: "GET",
        dataType: "json",
        xhrFields: {
            withCredentials: true
        },
        success: onSuccess,
        error: onError
    };
    $.ajax(url, settings);
}

sabio.services.squadEvent.delete = function (id, onSuccess, onError) {
    var url = "/api/SquadEvents/" + id;

    var settings = {
        data: id,
        cache: false,
        type: "DELETE",
        dataType: "json",
        xhrFields: {
            withCredentials: true
        },
        success: onSuccess,
        error: onError
    };
    $.ajax(url, settings);
}

sabio.services.squadEvent.search = function (searchString, itemsPerPage, currentPage, squadId, onSearchSuccess, onSearchError) {
    var url = "/api/squadEvents/search?searchstring=" + searchString + "&itemsPerPage=" + itemsPerPage + "&currentPage=" + currentPage + "&squadId=" + squadId;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSearchSuccess,
        error: onSearchError
    };

    $.ajax(url, settings);
}

///// JSON services /////

sabio.services.squadEvent.addEvent = function (data, onSuccess, onError) {
    var url = "/api/SquadEvents";

    var settings = {
        data: data
        , cache: false
        , type: "POST"
        , dataType: "json"
        , xhrFields: {
            withCredentials: true
        }
        , success: onSuccess
        , error: onError
    };
    $.ajax(url, settings);
}
