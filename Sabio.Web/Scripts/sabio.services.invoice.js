sabio.services.invoice = sabio.services.invoice || {};

sabio.services.invoice.selectProjectByCompanyId = function (Id, onSuccess, onError) {
    var url = "/api/projects/company/" + Id;

    var settings = {
        async: false,
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.invoice.getTimecardByProjectId = function (Id, onSuccess, onError) {
    var url = "/api/timecardentry/" + Id;

    var settings = {
        async: false,
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
}

sabio.services.invoice.postJson = function (data, onSuccess, onError) {
    var url = "/api/invoices/";
    var settings = {
        cache: false
		, contentType: "application/json; charset=UTF-8"
		, dataType: "json"
		, data: JSON.stringify(data)
		, success: onSuccess
		, error: onError
		, type: "POST"
    };
    $.ajax(url, settings);
}
sabio.services.invoice.putJson = function (id, data, onSuccess, onError) {
    var url = "/api/invoices/" + id
    //blogTag.id = id;  // Just in case blogTag does not include id
    var settings = {
        cache: false
		, contentType: "application/json; charset=UTF-8"
		, dataType: "json"
		, data: JSON.stringify(data)
		, success: onSuccess
		, error: onError
		, type: "PUT"
    };
    $.ajax(url, settings);
}

