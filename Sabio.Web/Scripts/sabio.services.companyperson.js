sabio.services.companyperson = sabio.services.companyperson || {};

sabio.services.companyperson.add = function (companyId, personId, onSuccess, onError) {
    var url = "/api/companiespeople/" + companyId + "/" + personId;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "JSON",
        type: "POST",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}

sabio.services.companyperson.delete = function (companyId, personId, onSuccess, onError) {
    var url = "/api/companiespeople/" + companyId + "/" + personId;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "JSON",
        type: "DELETE",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}

sabio.services.companyperson.getCompanies = function (personId, onSuccess, onError) {
    var url = "/api/companiespeople/" + personId;

    var settings = {
        cache: false,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "JSON",
        type: "GET",
        success: onSuccess,
        error: onError
    }

    $.ajax(url, settings);
}