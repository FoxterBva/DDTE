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
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                alert('Error !');
                onError(data);
            });
        }

        factory.AddAlbum = function (title, descr, isPublic, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/CreateAlbum',
                dataType: 'json',
                method: 'POST',
                data: "{ 'title': '" + title + "', 'description': '" + descr + "', 'isPublic': '" + isPublic + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                alert('Error !');
                onError(data);
            });
        }

        factory.DeleteAlbum = function (albumId, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/DeleteAlbum',
                dataType: 'json',
                method: 'POST',
                data: "{ 'albumId': '" + albumId + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                alert('Error !');
                onError(data, status, headers, config);
            });
        }

        return factory;
    }

    GalleryServiceFactory.$inject = injectParams;

    angular.module('ddteGalleryApp').factory('GalleryServiceFactory', GalleryServiceFactory);
}());
