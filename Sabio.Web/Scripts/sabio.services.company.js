sabio.services.company = sabio.services.company || {}

sabio.services.company.selectAll = function (onSuccess, onError)
{
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    };
    $.ajax("/api/companies/", settings);
};

sabio.services.company.selectById = function (id, onSuccess, onError)
{
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        ,type:"GET"
    }
    $.ajax("/api/companies/" + id, settings);
}

sabio.services.company.insert = function (company, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , data: company
        , type: "POST"
    };
    $.ajax("/api/companies/", settings)
}

sabio.services.company.update = function (id, company, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "JSON"
        , data: JSON.stringify(company)
        , type: "PUT"
    };
    $.ajax("/api/companies/" + id, settings);
}

sabio.services.company.delete = function (id, onSuccess, onError)
{
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contenttype: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "DELETE"
    };
    $.ajax("/api/companies/" + id, settings);
}

sabio.services.company.search = function (searchString, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "JSON"
        , type: "GET"
    }
    $.ajax("/api/companies/search?searchstring=" + searchString, settings);
}
