/*
Template Name: Color Admin - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.3.7
Version: 2.1.0
Author: Sean Ngu
Website: http://www.seantheme.com/color-admin-v2.1/admin/html/
*/

var handleDataTableFixedHeader = function() {
	"use strict";

    if ($('#data-table').length !== 0) {
        $('#data-table').DataTable({
            lengthMenu: [20, 40, 60],
            fixedHeader: {
                header: true,
                headerOffset: $('#header').height()
            },
            responsive: true
        });
    }
};

var TableManageFixedHeader = function () {
	"use strict";
    return {
        //main function
        init: function () {
            handleDataTableFixedHeader();
        }
    };
}();