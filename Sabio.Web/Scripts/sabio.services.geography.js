sabio.services.geography = sabio.services.geography || {};

sabio.services.geography.getAllCountries = function (onSuccess, onError) {
    var url = "/api/geography/countries";

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

sabio.services.geography.getAllStateProvinces = function (onSuccess, onError) {
    var url = "/api/geography/stateprovinces/";

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

sabio.services.geography.getStateProvincesByCountryId = function (countryId, onSuccess, onError) {
    var url = "/api/geography/stateprovinces/" + countryId;

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