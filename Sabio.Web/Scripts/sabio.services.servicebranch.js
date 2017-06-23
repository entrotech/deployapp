sabio.services.servicebranch = sabio.services.servicebranch || {}
sabio.services.servicebranch.post = function (servicebranch, onSuccess, onError) {
    var settings = {
        cache: false
                    , success: onSuccess
                    , error: onError
                    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
                    , dataType: "json"
                    , data: servicebranch
                    , type: "POST"
    };
    $.ajax("/api/serviceBranches/", settings);
}
sabio.services.servicebranch.put = function (id, servicebranch, onSuccess, onError) {
    var settings = { 
        cache: false
                    , success: onSuccess
                    , error: onError
                    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
                    , dataType: "json"
                    , data: servicebranch + "&id=" + id
                    , type: "PUT"
    };
    $.ajax("/api/serviceBranches/" + id, settings);
}


sabio.services.servicebranch.getAll = function (onSuccess, onError) {
    var settings = {
        cache: false
                    , success: onSuccess
                    , error: onError
                    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
                    , dataType: "json"
                    , type: "GET"
    };
    $.ajax("/api/serviceBranches/", settings);
}

sabio.services.servicebranch.getById = function (id,onSuccess, onError) {
    var settings = {
        cache: false
                    , success: onSuccess
                    , error: onError
                    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
                    , dataType: "json"
                    , type: "GET"
    };
    $.ajax("/api/serviceBranches/"+id, settings);
}
sabio.services.servicebranch.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
                    , success: onSuccess
                    , error: onError
                    , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
                    , type: "DELETE"
    };
    $.ajax("/api/serviceBranches/" + id, settings);
}
sabio.services.servicebranch.getRank = function (url,onSuccess, onError) {
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