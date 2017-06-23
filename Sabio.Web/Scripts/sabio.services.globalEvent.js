sabio.services.globalEvent = sabio.services.globalEvent || {};

sabio.services.globalEvent.getLatLng = function (address, onSuccess, onError) {
	var url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=AIzaSyAEXjYvK3d8Dasdyz2HN3gy81FJk6XvlYI";

	var settings = {
		cache: false,
		dataType: "json",
		type: "GET",
		success: onSuccess,
		error: onError,
	};

	$.ajax(url, settings);
};

sabio.services.globalEvent.getAddress = function (latitude, longitude, onSuccess, onError) {
    var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + latitude + "," + longitude + "&key=AIzaSyAEXjYvK3d8Dasdyz2HN3gy81FJk6XvlYI";

    var settings = {
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.post = function (globalEvent, onSuccess, onError) {
    var url = "/api/globalevents/";

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        data: globalEvent,
        type: "POST"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.getAll = function (onSuccess, onError) {
    var url = "/api/globalevents/";

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        dataType: "json",
        type: "GET"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.calendarGetAll = function (onSuccess, onError) {
    var url = "/api/globalevents/c";
    var ts = new Date().getTime();
    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        dataType: "json",
        type: "GET",
        data: {timestamp:ts}
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.getById = function (id, onSuccess, onError) {
    var url = "/api/globalevents/" + id;

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        dataType: "json",
        type: "GET"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.put = function (id, globalEvent, onSuccess, onError) {
    var url = "/api/globalevents/" + id;

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        data: globalEvent,
        type: "PUT"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.deleteById = function (id, onSuccess, onError) {
    var url = "/api/globalevents/" + id;

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "DELETE"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.cancelById = function (id, onSuccess, onError) {
    var url = "/api/globalevents/cancel/" + id;

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "PUT"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.setEventRadius = function (userLat, userLng, radius, onSuccess, onError) {
    var url = "/api/globalevents/radius?lat=" + userLat + "&lng=" + userLng + "&radius=" + radius;

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.search = function (searchStr, onSuccess, onError) {
    var url = "/api/globalevents/search?searchstr=" + searchStr;

    var settings = {
        cache: false,
        success: onSuccess,
        error: onError,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        type: "GET"
    };

    $.ajax(url, settings);
};

sabio.services.globalEvent.calendarGetAll = function (onSuccess, onError) {
    var url = "/api/calendar"

    var settings = {
        cache: false,
        dataType: "json",
        type: "GET",
        success: onSuccess,
        error: onError,
    };

    $.ajax(url, settings);
};