sabio.services.testimonial = sabio.services.testimonial || {};

sabio.services.testimonial.post = function (testimonial, personId, onSuccess, onError) {
    var data = {
        Content: testimonial,
        PersonId: personId
    }
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(data)
        , type: "POST"
    };
    $.ajax("/api/testimonials/", settings);
}

sabio.services.testimonial.put = function (id, testimonial, onSuccess, onError) {
    testimonial.id = id;
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/json; charset=UTF-8"
        , dataType: "json"
        , data: JSON.stringify(testimonial)
        , type: "PUT"
    };
    $.ajax("/api/testimonials/" + id, settings);
}

sabio.services.testimonial.getById = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "GET"
    };
    $.ajax("/api/testimonials/" + id, settings);
}

sabio.services.testimonial.getAll = function (onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/testimonials/", settings);
}

sabio.services.testimonial.delete = function (id, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , dataType: "json"
        , data: id
        , type: "DELETE"
    };
    $.ajax("/api/testimonials/" + id, settings);
}
sabio.services.testimonial.search = function (inactive, onSuccess, onError) {
    var settings = {
        cache: false
        , success: onSuccess
        , error: onError
        , contentType: "application/x-www-form-urlencoded; charset=UTF-8"
        , type: "GET"
    };
    $.ajax("/api/testimonials/search?inactive=" + inactive, settings);
}