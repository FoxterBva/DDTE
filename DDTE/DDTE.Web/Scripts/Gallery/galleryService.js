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
                onError(data);
            });
        }

        factory.UpdateAlbum = function (id, title, descr, isPublic, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/UpdateAlbum',
                dataType: 'json',
                method: 'POST',
                data: "{ 'albumId': '" + id + "', 'title': '" + title + "', 'description': '" + descr + "', 'isPublic': '" + isPublic + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
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
                onError(data, status, headers, config);
            });
        }

        factory.AddPhoto = function (title, descr, isPublic, url, albumId, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/AddPhoto',
                dataType: 'json',
                method: 'POST',
                data: "{ 'title': '" + title + "', 'description': '" + descr + "', 'isPublic': '" + isPublic + "', 'url': '" + url + "', 'albumId': '" + albumId + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data, status, headers, config);
            });
        }

        factory.UpdatePhoto = function (photoId, title, descr, isPublic, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/UpdatePhoto',
                dataType: 'json',
                method: 'POST',
                data: "{ 'photoId': '" + photoId + "', 'title': '" + title + "', 'description': '" + descr + "', 'isPublic': '" + isPublic + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data, status, headers, config);
            });
        }

        factory.DeletePhoto = function (photoId, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/DeletePhoto',
                dataType: 'json',
                method: 'POST',
                data: "{ 'photoId': '" + photoId + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data, status, headers, config);
            });
        }

        return factory;
    }

    GalleryServiceFactory.$inject = injectParams;

    angular.module('ddteGalleryApp').factory('GalleryServiceFactory', GalleryServiceFactory);
}());
