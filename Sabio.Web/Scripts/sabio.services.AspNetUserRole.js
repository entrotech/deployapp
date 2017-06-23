sabio.services.AspNetUserRole = sabio.services.AspNetUserRole || {};

sabio.services.AspNetUserRole.post = function (userId, role, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: "UserId=" + userId + "&Role=" + role
        , type: "POST"
    };
    $.ajax("/api/AspNetUserRoles/", settings);
}

sabio.services.AspNetUserRole.search = function (name, role, current, results, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/AspNetUserRoles/search?name=" + name + "&role=" + role + "&CurrentPage=" + current + "&ItemsPerPage=" + results, settings);
}

sabio.services.AspNetUserRole.delete = function (userId, role, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: "UserId=" + userId + "&Role=" + role
        , type: "DELETE"
    };
    $.ajax("/api/AspNetUserRoles/" , settings);
}