sabio.services.jobApplication = sabio.services.jobApplication || {};

sabio.services.jobApplication.post = function (data, onSuccess, onError) {
	var url = "/api/jobapplications";
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

sabio.services.jobApplication.put = function (id, data, onSuccess, onError) {
	var url = "/api/jobapplications/" + id;

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

sabio.services.jobApplication.delete = function (id, onSuccess, onError) {
	var url = "/api/jobapplications/" + id;

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

sabio.services.jobApplication.getByStatusId = function (jobPostingId, statusId, onSuccess, onError) {
    var url = "/api/jobapplications/" + jobPostingId + "/" + statusId;

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

sabio.services.jobApplication.getByPersonId = function (id, onSuccess, onError) {
    var url = "/api/jobapplications/" + id;

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

sabio.services.jobApplication.getAllStatuses = function (onSuccess, onError) {
    var url = "/api/jobapplications/statuses";

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