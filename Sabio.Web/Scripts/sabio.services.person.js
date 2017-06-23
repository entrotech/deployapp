sabio.services.person = sabio.services.person || {};

sabio.services.person.add = function (data, onSuccess, onError) {
	var url = "/api/person/";
	var settings = {
		cache: false
		, contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		, data: data
		, dataType: "json"
		, success: onSuccess
		, error: onError
		, type: "POST"
	};
	$.ajax(url, settings);
}

sabio.services.person.put = function (id, data, onSuccess, onError) {
	var url = "/api/person/" + id;

	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		data: data + "&id=" + id,
		dataType: "json",
		type: "PUT",
		success: onSuccess,
		error: onError
	};
	$.ajax(url, settings);
}
//new put ends
sabio.services.person.getall = function (onSuccess, onError) {
	var url = "/api/person/";

	var settings = {
		cache: false,
		contentType: "json",
		dataType: "json",
		type: "GET",
		success: onSuccess,
		error: onError
	};
	$.ajax(url, settings);
}

sabio.services.person.delete = function (id, deleteSuccess, deleteError) {
	var url = "/api/person/" + id;

	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		type: "DELETE",
		success: deleteSuccess,
		error: deleteError,
		xhrFields: {
			withCredentials: true
		}
	};

	$.ajax(url, settings);
}

sabio.services.person.getById = function (id, onSuccess, onError) {
	var url = "/api/person/" + id;

	var settings = {
		cache: false,
		contentType: "json",
		dataType: "json",
		type: "GET",
		data: id,
		success: onSuccess,
		error: onError,
		xhrFields: {
			withCredentials: true
		}
	};

	$.ajax(url, settings);
}

sabio.services.person.postJson = function (data, onSuccess, onError) {
	var url = "/api/person";
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
sabio.services.person.putJson = function (id, data, onSuccess, onError) {
	var url = "/api/person/" + id
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

sabio.services.person.getLatLng = function (address, onSuccess, onError) {
	var url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=AIzaSyAEXjYvK3d8Dasdyz2HN3gy81FJk6XvlYI";

	var settings = {
		cache: false,
		dataType: "json",
		type: "GET",
		success: onSuccess,
		error: onError
	};

	$.ajax(url, settings);
};

sabio.services.person.search = function (searchString, itemsPerPage, currentPage, onSearchSuccess, onSearchError, isVeteran, isEmployer, isFamilyMember) {
	var url = "/api/person/search?searchstring=" + searchString+"&itemsPerPage=" + itemsPerPage +"&currentPage=" + currentPage;
	if (isVeteran) {
		url += "&isVeteran=true";     
	}
	if(isEmployer){
		url += "&isEmployer";
	}
	if (isFamilyMember) {
		url += "&isFamilyMember";
	}
	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		type: "GET",
		success: onSearchSuccess,
		error: onSearchError
	};

	$.ajax(url, settings);

}

sabio.services.person.getProjects = function (id, onSuccess, onError) {
	var url = "/api/person/" + id + "/projects";
	var settings = {
		cache: false,
		contentType: "application/json; charset=UTF-8",
		type: "GET",
		success: onSuccess,
		error: onError
	}
	$.ajax(url, settings);
}
sabio.services.person.addGoogleUser = function (data, onSuccess, onError) {
	var url = "/api/person/google/";
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

