sabio.services.user = sabio.services.user || {};

//REGISTER - POST new user
sabio.services.user.postRegister = function (data, onSuccess, onError) {
    var url = "/api/users";
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "POST",
        success: onSuccess,
        error: onError,
    };
    $.ajax(url, settings);
}
//CONFIRM - GET token check if valid
sabio.services.user.getConfirmToken = function (token, onSuccess, onError) {
    var url = "/api/users/" + token;
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };
    $.ajax(url, settings);
}
//CONFIRM - PUT resend confirmation token
sabio.services.user.putConfirmToken = function (token, onSuccess, onError) {
    var url = "/api/users/" + token;
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "PUT",
        success: onSuccess,
        error: onError,
    };
    $.ajax(url, settings);
}
//LOGIN - POST user login
sabio.services.user.postLogin = function (data, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "POST"
    };
    $.ajax("/api/users/login/", settings);
}
//LOGIN - POST send reset password email
sabio.services.user.postResetEmail = function (data, onSuccess, onError) {
    var url = "/api/users/forgotpassword";
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "POST",
        success: onSuccess,
        error: onError,
    };
    $.ajax(url, settings);
}
//RESETPASSWORD - GET token check if valid
sabio.services.user.getResetToken = function (token, onSuccess, onError) {
    var url = "/api/users/reset/" + token;
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };
    $.ajax(url, settings);
}
//RESETPASSWORD - PUT resend reset password token
sabio.services.user.putReset = function (token, data, onSuccess, onError) {
    var url = "/api/users/resetpassword/" + token;
    var settings = {
        cache: false
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , success: onSuccess
        , error: onError
        , type: "PUT"
    };
    $.ajax(url, settings);
}
//RESETPASSWORD - PUT reset user password
sabio.services.user.putResetToken = function (token, onSuccess, onError) {
    var url = "/api/users/resend/" + token;
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "PUT",
        success: onSuccess,
        error: onError,
    };
    $.ajax(url, settings);
}
//LOGOUT - GET logout user
sabio.services.user.getLogout = function (onSuccess, onError) {
    var url = "/api/users/logout";
    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET"
    }
    $.ajax(url, settings);
}

//GET CURRENT USER PERSONAL INFO
sabio.services.user.getCurrentUser = function (onSuccess, onError) {
    var url = "/api/users/home";
    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        dataType: "json",
        type: "GET"
    }
    $.ajax(url, settings);
}










