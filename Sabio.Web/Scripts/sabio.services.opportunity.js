sabio.services.opportunity = sabio.services.opportunity || {};

// Create - GET - by ID
sabio.services.opportunity.getById = function (id, onSuccess, onError) {
	var url = "/api/opportunities/" + id;
	var settings = {
		cache: false
	   , success: onSuccess
	   , error: onError
	   , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
	   , dataType: "json"
	   //, data: sabio.page.activeId
	   , type: "GET"
	};
	$.ajax(url, settings);
}

// Create - POST - submit new entry
sabio.services.opportunity.post = function (data, onSuccess, onError) {
	var url = "/api/opportunities/";
	var settings = {
		cache: false
		 , success: onSuccess
		 , error: onError
		 , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		 , dataType: "json"
		 , data: data
		 , type: "POST"
	};
	$.ajax(url, settings);
}

// Create - PUT - update entry
sabio.services.opportunity.put = function (id, data, onSuccess, onError) {
	var url = "/api/opportunities/" + id;
	var settings = {
		cache: false
		 , success: onSuccess
		 , error: onError
		 , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		 , dataType: "json"
		 , data: data
		 , type: "PUT"
	};
	$.ajax(url, settings);
}

// Create - DELETE - delete entry
sabio.services.opportunity.delete = function (id, onSuccess, onError) {
	//
	var url = "/api/opportunities/" + id
	var settings = {
		cache: false
			, success: onSuccess
			, error: onError
			, dataType: "json"
			, type: "DELETE"
	};
	$.ajax(url, settings);
}

// Create - GOOGLE MAP -  GET LatLng
sabio.services.opportunity.getLatLng = function (address, onSuccess, onError) {
	var url = "https://maps.googleapis.com/maps/api/geocode/json?address=" +
		address + "&key=AIzaSyAEXjYvK3d8Dasdyz2HN3gy81FJk6XvlYI";

	var settings = {
		cache: false
		, dataType: "json"
		, type: "GET"
		, success: onSuccess
		, error: onError
	};

	$.ajax(url, settings);
};

// Index - GET - All
/*
sabio.services.opportunity.getAll = function (onSuccess, onError) {
	var url = "/api/opportunities/"
	var settings = {
		cache: false
		, dataType: "json"
		, success: onSuccess
		, error: onError
		, type: "GET"
	};
	$.ajax(url, settings);
}
*/


// IndexNg - PUT    
sabio.services.opportunity.putJson = function (id, opportunity, onSuccess, onError) {
	var url = "/api/opportunities/" + id;
	var settings = {
		cache: false
		, contentType: "application/json; charset=UTF-8"
		, dataType: "json"
		, data: JSON.stringify(opportunity)
		, type: "PUT"
		, success: onSuccess
		, error: onError
	}
	$.ajax(url, settings);
}

// IndexNg - POST
sabio.services.opportunity.postJson = function (opportunity, onSuccess, onError) {
	var url = "/api/opportunities/";
	var settings = {
		cache: false
		, contentType: "application/json; charset=UTF-8"
		, dataType: "json"
		, data: JSON.stringify(opportunity)
		, success: onSuccess
		, error: onError
		, type: "POST"
	}
	$.ajax(url, settings);
}
// IndexNg - DELETE
sabio.services.opportunity.deleteJson = function (id, onSuccess, onError) {
	var url = "/api/opportunities/" + id;
	var settings = {
		cache: false
		, type: "DELETE"
		, success: onSuccess
		, error: onError
	}
	$.ajax(url, settings);
}

// IndexNg - SEARCH (original)
/*
sabio.services.opportunity.search = function (searchString, itemsPerPage, currentPage, onSearchSuccess, onSearchError) {
	var url = "/api/opportunities/search?searchstring=" + searchString + "&itemsPerPage=" + itemsPerPage + "&currentPage=" + currentPage;
	var settings = {
		cache: false
		, success: onSearchSuccess
		, error: onSearchError
		, contentType: "application/json; charset=UTF-8"
		, dataType: "JSON"
		, type: "GET"
	}
	$.ajax(url, settings);
}
*/

// IndexNg - SEARCH 2 (pass in BeginDate, EndDate, SortByColumn, Descending)
sabio.services.opportunity.search = function (searchString, itemsPerPage, currentPage, beginDate, endDate, sortByColumn, descending, onSearchSuccess, onSearchError) {
	var url = "/api/opportunities/search?searchstring=" + searchString
		+ "&itemsPerPage=" + itemsPerPage
		+ "&currentPage=" + currentPage
		+ "&beginDate=" + beginDate
		+ "&endDate=" + endDate
		+ "&sortByColumn=" + sortByColumn
		+ "&descending=" + descending;
	var settings = {
		cache: false
		, success: onSearchSuccess
		, error: onSearchError
		, contentType: "application/json; charset=UTF-8"
		, dataType: "JSON"
		, type: "GET"
	}
	$.ajax(url, settings);
}