var ddteHelper = {
    Debug: function (msg) { console.log(msg); }
};


(function () {
    var app = angular.module('ddteGalleryApp', []);

    app.config(function () {
        ddteHelper.Debug('app.config');
    });

    app.run(function () {
        ddteHelper.Debug('app.run');
    });

}());