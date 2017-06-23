sabio.services.file = sabio.services.file || {};

sabio.services.file.getResume = function (onSuccess, onError) {
    var settings = {
        type: 'GET'
       , contentType: 'JSON'
        , success: onSuccess
       , error: onError
    };
    $.ajax('/api/files/resume', settings);
};

sabio.services.file.getPhoto = function (onSuccess, onError) {
    var settings = {
        type: "GET"
        , contentType: "JSON"
        , success: onSuccess
       , error: onError
    };
    $.ajax("/api/files/photo", settings);
}

sabio.services.file.postPhoto = function (formData, onSuccess, onError) {
    var settings = {
        processData: false
       , contentType: false
       , data: formData
       , type: 'POST'
       , success: onSuccess
       , error: onError
    };
    $.ajax("/api/files/photo", settings);
};

sabio.services.file.postResume = function (formData, onSuccess, onError) {
    var settings = {
        processData: false
       , contentType: false
       , data: formData
       , type: 'POST'
       , success: onSuccess
       , error: onError
    };
    $.ajax("/api/files/resume/", settings);
};
sabio.services.file.postPhotoJson = function (formData, onSuccess, onError) {
    var settings = {
        processData: false
       , contentType: false
       , data: formData
       , type: 'POST'
       , success: onSuccess
       , error: onError
    };
    $.ajax("/api/files/photo", settings);
};
sabio.services.file.updateBlogPhoto = function (data, onSuccess, onError) {
    var settings = {
        cache: false,
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        success: onSuccess,
        error: onError
    };

    $.ajax("/api/files/blogphoto/", settings);
};
sabio.services.file.uploadPhoto = function (formData, onSuccess, onError) {
    var settings = {
        processData: false
       , contentType: false
       , data: formData
       , type: 'POST'
       , success: onSuccess
       , error: onError
    };
    $.ajax("/api/files/", settings);
};