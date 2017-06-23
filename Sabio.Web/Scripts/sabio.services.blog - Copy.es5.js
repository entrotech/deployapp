"use strict";

sabio.services.blog = sabio.services.blog || {};

sabio.services.blog.post = function (blog, onSuccess, onError) {
	var url = "/api/blogs";
	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		data: blog,
		success: onSuccess,
		error: onError,
		type: "POST"
	};
	$.ajax(url, settings);
};

sabio.services.blog.put = function (id, blog, onSuccess, onError) {
	var url = "/api/blogs/" + id;
	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		data: blog + "&id=" + id,
		success: onSuccess,
		error: onError,
		type: "PUT"
	};
	$.ajax(url, settings);
};
sabio.services.blog.getById = function (id, onSuccess, onError) {
	var url = "/api/blogs/" + id;
	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		success: onSuccess,
		error: onError,
		type: "GET"
	};
	$.ajax(url, settings);
};
sabio.services.blog.getAll = function (onSuccess, onError) {
	var url = "/api/blogs";
	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		success: onSuccess,
		error: onError,
		type: "GET"
	};
	$.ajax(url, settings);
};
sabio.services.blog["delete"] = function (id, onSuccess, onError) {
	var url = "/api/blogs/" + id;
	var settings = {
		cache: false,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		success: onSuccess,
		error: onError,
		type: "DELETE"
	};
	$.ajax(url, settings);
};
sabio.services.blog.search = function (searchStr, blogCategory, currentPage, itemsPerPage, onSuccess, onError) {

	var url = "/api/blogs/search?SearchStr=" + searchStr + "&category=" + blogCategory + "&CurrentPage=" + currentPage + "&ItemsPerPage=" + itemsPerPage;
	var settings = {
		cache: false,
		success: onSuccess,
		error: onError,
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		type: "GET"
	};
	$.ajax(url, settings);
};

sabio.services.blog.postJson = function (blog, onSuccess, onError) {
	var url = "/api/blogs";
	var settings = {
		cache: false,
		contentType: "application/json; charset=UTF-8",
		dataType: "json",
		data: JSON.stringify(blog),
		success: onSuccess,
		error: onError,
		type: "POST"
	};
	$.ajax(url, settings);
};

sabio.services.blog.putJson = function (id, blog, onSuccess, onError) {
	blog.id = id;
	var url = "/api/blogs/" + id;
	var settings = {
		cache: false,
		contentType: "application/Json; charset=UTF-8",
		dataType: "json",
		data: JSON.stringify(blog),
		success: onSuccess,
		error: onError,
		type: "PUT"
	};
	$.ajax(url, settings);
};
sabio.services.blog.getByIdJson = function (id, onSuccess, onError) {
	var url = "/api/blogs/" + id;
	var settings = {
		cache: false,
		contentType: "application/Json; charset=UTF-8",
		dataType: "json",
		success: onSuccess,
		error: onError,
		type: "GET"
	};
	$.ajax(url, settings);
};
sabio.services.blog.getAllJson = function (onSuccess, onError) {
	var url = "/api/blogs";
	var settings = {
		cache: false,
		contentType: "application/Json; charset=UTF-8",
		dataType: "json",
		success: onSuccess,
		error: onError,
		type: "GET"
	};
	$.ajax(url, settings);
};
sabio.services.blog.deleteJson = function (id, onSuccess, onError) {
	var url = "/api/blogs/" + id;
	var settings = {
		cache: false,
		contentType: "application/Json; charset=UTF-8",
		dataType: "json",
		success: onSuccess,
		error: onError,
		type: "DELETE"
	};
	$.ajax(url, settings);
};

