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

    app.filter("jsDate", function () {
        return function (x) {
            return new Date(parseInt(x.substr(6)));
        };
    });

    app.filter("tmbimage", function () {
        return function (photo) {
            if (!photo)
                return '';

            var path = photo.ImagePath;
            if (!path)
                return '';

            var isLocal = path.substr(0, 4) != 'http';

            if (!isLocal)
                return path;

            var lastDotPos = path.lastIndexOf('.');
            if (lastDotPos < 0)
                return path;

            var res = path.slice(0, lastDotPos) + '.tmb' + path.slice(lastDotPos);
            return res;
        };
    });
}());