sabio.services.skill = sabio.services.skill || {};

sabio.services.skill.post = function (skill, onSuccess, onError) {
    var url = "/api/skills/";
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json" 
        , data: skill
        , type: "POST"
	};
	$.ajax(url, settings);
}

sabio.services.skill.put = function (id, skill, onSuccess, onError) {
    var url = "/api/skills/" + id;
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: skill
        , type: "PUT"
	};
    $.ajax(url, settings);
}

sabio.services.skill.getById = function (id, onSuccess, onError) {
    var url = "/api/skills/" + id;
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "GET"
	};
	$.ajax(url, settings);
}

sabio.services.skill.getAll = function (onSuccess, onError) {
    var url = "/api/skills/";
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
	};
	$.ajax(url, settings);
}

sabio.services.skill.delete = function (id, onSuccess, onError) {
    var url = "/api/skills/" + id;
	var settings = {
		cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "DELETE"
	};
	$.ajax(url, settings);
}