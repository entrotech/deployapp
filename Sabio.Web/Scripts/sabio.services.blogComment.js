sabio.services.blogComment = sabio.services.blogComment || {};

sabio.services.blogComment.post = function (blog, onSuccess, onError) {
    var url = "/api/blogComment";
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: blog
        , success: onSuccess
        , error: onError
        , type: "POST"
    };
    $.ajax(url, settings);
}

sabio.services.blogComment.put = function (id, blog, onSuccess, onError) {
    var url = "/api/blogComment" + id
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: blog + "&id=" + id
        , success: onSuccess
        , error: onError
        , type: "PUT"
    };
    $.ajax(url, settings);
}
sabio.services.blogComment.getById = function (id, onSuccess, onError) {
    var url = "/api/blogComment/" + id
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
sabio.services.blogComment.getAll = function (onSuccess, onError) {
    var url = "/api/blogComment/";
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
sabio.services.blogComment.delete = function (id, onSuccess, onError) {
    var url = "/api/blogComment/" + id;
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "DELETE"
    };
    $.ajax(url, settings);
}

sabio.services.blogComment.postJson = function (blog, onSuccess, onError) {
    var url = "/api/blogComment";
    var settings = {
        cache: false
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(blog)
        , success: onSuccess
        , error: onError
        , type: "POST"
    };
    $.ajax(url, settings);
}

sabio.services.blogComment.putJson = function (id, blog, onSuccess, onError) {
    blog.id = id;
    var url = "/api/blogComment/" + id
    var settings = {
        cache: false
        , contentType: "application/Json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(blog)
        , success: onSuccess
        , error: onError
        , type: "PUT"
    };
    $.ajax(url, settings);
}
sabio.services.blogComment.getByIdJson = function (id, onSuccess, onError) {
    var url = "/api/blogComment/" + id
    var settings = {
        cache: false
        , contentType: "application/Json; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "GET"
    };
    $.ajax(url, settings);
}
sabio.services.blogComment.getAllJson = function (onSuccess, onError) {
    var url = "/api/blogComment/";

    var settings = {
        cache: false
        , contentType: "application/Json; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "GET"
    };
    $.ajax(url, settings);
}
sabio.services.blogComment.deleteJson = function (id, onSuccess, onError) {
    var url = "/api/blogComment/"  + id;
    var settings = {
        cache: false
        , contentType: "application/Json; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "DELETE"
    };
    $.ajax(url, settings);
}
sabio.services.blogComment.approve = function (id, onSuccess, onError) {
    var url = "/api/blogComment/" + id + "/approve";
    var settings = {
        cache: false
        , contentType: "application/Json; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "PUT"
    };
    $.ajax(url, settings);
}

sabio.services.blogComment.getAllComments = function (id, onSuccess, onError) {
    var url = "/api/blogComment/"+ id +"/blog/"
    var settings = {
        cache: false
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , success: onSuccess
        , error: onError
        , type: "GET"
    };
    $.ajax(url, settings);
}