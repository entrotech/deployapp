sabio.services.blogTag = sabio.services.blogTag || {};

sabio.services.blogTag.post = function (blogTag, onSuccess, onError) {
    var url = "/api/blogtags";
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: blogTag
        , success: onSuccess
        , error: onError
        , type: "POST"
    };
    $.ajax(url, settings);
}

sabio.services.blogTag.postJson = function (blogTag, onSuccess, onError) {
    var url = "/api/blogtags";
    var settings = {
        cache: false
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(blogTag)
        , success: onSuccess
        , error: onError
        , type: "POST"
    };
    $.ajax(url, settings);
}

sabio.services.blogTag.put = function (id, blogTag, onSuccess, onError) {
    var url = "/api/blogtags/" + id
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: blogTag
        , success: onSuccess
        , error: onError
        , type: "PUT"
    };
    $.ajax(url, settings);
}

sabio.services.blogTag.putJson = function (id, blogTag, onSuccess, onError) {
    var url = "/api/blogtags/" + id
    blogTag.id = id;  // Just in case blogTag does not include id
    var settings = {
        cache: false
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(blogTag)
        , success: onSuccess
        , error: onError
        , type: "PUT"
    };
    $.ajax(url, settings);
}

sabio.services.blogTag.getById = function (id, onSuccess, onError) {
    var url = "/api/blogtags/" + id
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "GET"
    };
    $.ajax(url, settings);
}
sabio.services.blogTag.search = function (searchString, onSuccess, onError) {
    var url = "/api/blogtags/search?searchString=" + searchString;
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "GET"
    };
    $.ajax(url, settings);
}
sabio.services.blogTag.getAll = function (onSuccess, onError) {
    var url = "/api/blogtags";
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "GET"
    };
    $.ajax(url, settings);
}
sabio.services.blogTag.delete = function (id, onSuccess, onError) {
    var url = "/api/blogtags/" + id;
    var settings = {
        cache: false
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "DELETE"
    };
    $.ajax(url, settings);
}