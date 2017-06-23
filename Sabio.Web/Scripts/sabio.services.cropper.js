sabio.services.cropper = sabio.services.cropper || {};

var $uploadCrop = [];
sabio.services.cropper.options = null;
sabio.services.cropper.options = function (wd, ht,tp) {
    $uploadCrop =
        $('#canvas').croppie({
            enableExif: true,
            viewport: {
                width: wd,
                height: ht,
                type: tp
            },
            boundary: {
                width: wd + 80,
                height: ht + 80
            }
        });

}

sabio.services.cropper.bindToCropper = function () {
    var reader = new FileReader();
    reader.onload = function (e) {
        $uploadCrop.croppie('bind', {
            url: e.target.result
        }).then(function () {
            console.log('jQuery bind complete');
        });

    }
    reader.readAsDataURL(this.files[0]);
};

sabio.services.cropper.uploadToServer = function (ev) {
  
   $uploadCrop.croppie('result', {
        type: 'canvas',
        size: 'viewport'
    }).then(function (resp) {
        var blob = dataURItoBlob(resp);
        console.log(blob);
       
        var fd = new FormData(document.forms[0]);
        fd.append("image", blob,document.forms[0].fileName+".png");
        sabio.services.file.postPhotoJson(fd, sabio.page.onSuccess, sabio.page.onError);
    });
}


function dataURItoBlob(dataURI) {
    // convert base64/URLEncoded data component to raw binary data held in a string
    var byteString;
    if (dataURI.split(',')[0].indexOf('base64') >= 0)
        byteString = atob(dataURI.split(',')[1]);
    else
        byteString = unescape(dataURI.split(',')[1]);

    // separate out the mime component
    //debugger;
    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

    // write the bytes of the string to a typed array
    var ia = new Uint8Array(byteString.length);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i) ;
    }

    return new Blob([ia], { type: mimeString }); 
}