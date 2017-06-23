sabio.services.faq = sabio.services.faq || {};

sabio.services.faq.post = function (data, onSuccess, onError) {
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data
        , type: "POST"
	};
	$.ajax("/api/faqs/", settings);
};

sabio.services.faq.put = function (id, data, onSuccess, onError) {
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: data + "&id=" + id
        , type: "PUT"
	};
	$.ajax("/api/faqs/" + id, settings);
};

sabio.services.faq.getById = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "GET"

    };
	$.ajax("/api/faqs/" + id, settings);
};

sabio.services.faq.getAll = function (onSuccess, onError) {
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
	};
	$.ajax("/api/faqs/", settings);
};

sabio.services.faq.delete = function (id, onSuccess, onError) {
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError        
        , dataType: "json"   
        , type: "DELETE"
	};
	$.ajax("/api/faqs/" + id, settings);
};