sabio.services.squadMember = sabio.services.squadMember || {};

sabio.services.squadMember.post = function (data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "POST"
    };
    $.ajax("/api/squadmembers", settings);
}

sabio.services.squadMember.put = function (memberId, data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "PUT"
    };
    $.ajax("/api/squadmembers/" + memberId, settings);
}

sabio.services.squadMember.getById = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "GET"
    };
    $.ajax("/api/squadMembers/" + id, settings);
}

sabio.services.squadMember.getAll = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/squadMembers/", settings);
}

sabio.services.squadMember.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "DELETE"
    };
    $.ajax("/api/squadMembers/" + id, settings);
}

//==============Angular AJAX==================

sabio.services.squadMember.postJson = function (data, onSuccess, onError) {
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
}

sabio.services.squadMember.putJson = function (memberId, data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "PUT"
    };
    $.ajax("/api/squadmembers/" + memberId, settings);
}

sabio.services.squadMember.getByIdJson = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , type: "GET"
    };
    $.ajax("/api/squadMembers/" + id, settings);
}

sabio.services.squadMember.getAllStatus = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/squadMemberStatus/", settings);
}

sabio.page.searchPersonResults = function (data) { //PersonSearch
    var settings = {
        minlength: 2
  , cache: true
  , success: sabio.page.personReceived
  , error: sabio.page.requestFailed
  , contentType: "application/json; charset=UTF-8"
  , type: "GET"
    };
    $.ajax("/api/squads/PersonSearch?searchstring=" + data, settings);

}