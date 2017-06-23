sabio.services.jobPosting = sabio.services.jobPosting || {};

sabio.services.jobPosting.post = function (data, onSuccess, onError) {
    var url = "/api/jobpostings";
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "POST",
        success: onSuccess,
        error: onError
    };

    $.ajax(url, settings);
}

sabio.services.jobPosting.put = function (id, data, onSuccess, onError) {
    var url = "/api/jobpostings/" + id;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        data: data,
        dataType: "json",
        type: "PUT",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobPosting.delete = function (id, onSuccess, onError) {
    var url = "/api/jobpostings/" + id;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "DELETE",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobPosting.getById = function (id, onSuccess, onError) {
    var url = "/api/jobpostings/" + id;

    var settings = {
        async: false,
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobPosting.searchByKeyword = function (searchRequest, onSuccess, onError) {

    var url = "/api/jobpostings/search/" + searchRequest;

    var settings = {
        async: false,
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.jobPosting.searchIndeed = function (searchRequest, onSuccess, onError) {

    var url = "/api/jobpostings/indeedsearch?" + searchRequest;

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

sabio.services.jobPosting.searchMonster = function (searchRequest, onSuccess, onError) {

    var url = "/api/jobpostings/monstersearch?" + searchRequest;

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

sabio.services.jobPosting.searchUsaJobs = function (searchRequest, onSuccess, onError) {

    var url = "/api/jobpostings/usajobssearch?" + searchRequest;

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

sabio.services.jobPosting.getAll = function (onSuccess, onError) {
    var url = "/api/jobpostings/";

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

sabio.services.jobPosting.clickLog = function (engineId, onSuccess, onError) {
    var url = "/api/jobpostings/clicklog/" + engineId;
    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        type: "POST",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}