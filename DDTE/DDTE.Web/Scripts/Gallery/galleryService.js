(function () {
    var injectParams = ['$http'];

    var GalleryServiceFactory = function ($http) {
        var factory = {};

        factory.GetPhotoItems = function (albumId, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/ListPhotoItems',
                dataType: 'json',
                method: 'POST',
                data: "{ 'albumId': '" + albumId + "' }"
            };

            $http(httpParams)
            .success(function (data, satatus, headers, config) {
                onCompleted(data)
            })
            .error(function (data, satatus, headers, config) {
                alert('Error !');
                onError(data);
            });
        }

        return factory;
    }

    GalleryServiceFactory.$inject = injectParams;

    angular.module('ddteGalleryApp').factory('GalleryServiceFactory', GalleryServiceFactory);
}());
