
(function () {
    var app = angular.module('ddteStaffApp', []);

    app.config(function () {

    });

    app.run(function () {

    });

    app.filter('fullImg', function () {
        return function (input, extension) {
            if (!input)
                return input;

            // repalce current extension with extension of full image
            var extPos = input.lastIndexOf('.');

            if (extPos > -1) {
                input = input.substr(0, extPos) + extension;
            }

            return input;
        }
    });

}());