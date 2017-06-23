sabio.ui.sweetalert = sabio.ui.sweetalert || {};

sabio.ui.sweetalert.delete = function (id, deleteAjax, onSuccess, onError) {
    swal({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!',
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        buttonsStyling: true
    }).then(function () {
        deleteAjax(id, onSuccess, onError)
    }, function (dismiss) {
        // dismiss can be 'cancel', 'overlay',
        // 'close', and 'timer'       
        if (dismiss === 'cancel') {

        }
    })
}

sabio.ui.sweetalert.cancel = function (returnLocation) {
    swal({
        title: 'Are you sure you want to go back?',
        text: "Any unsaved changes will be lost!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, go back',
        cancelButtonText: 'No, stay here',
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        buttonsStyling: true
    }).then(function () {
        window.location.href = returnLocation;
    }, function (dismiss) {
        // dismiss can be 'cancel', 'overlay',
        // 'close', and 'timer'       
        if (dismiss === 'cancel') {

        }
    })
}

sabio.ui.sweetalert.confirmRegistration = function () {
    swal({
        title: 'Your registration has been submitted',
        text: "Please check your Email for a confirmation link",
        type: 'info',
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'Ok',
        confirmButtonClass: 'btn btn-success',
        buttonsStyling: true
    })
}

sabio.ui.sweetalert.registrationError = function () {
    swal({
        title: 'Your registration failed to submit',
        text: "Please retry or contact an administrator",
        type: 'error',
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'Ok',
        confirmButtonClass: 'btn btn-success',
        buttonsStyling: true
    })
  
}

sabio.ui.sweetalert.logInRequiredForEvents = function () {
    swal({
        title: 'Login required',
        text: "Please log-in as a manager to add events",
        type: 'error',
        confirmButtonColor: '#3085d6',
        confirmButtonText: 'Ok',
        confirmButtonClass: 'btn btn-success',
        buttonsStyling: true
    })

}