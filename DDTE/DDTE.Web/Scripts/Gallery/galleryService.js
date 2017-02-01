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

        factory.AddAlbum = function (data, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/CreateAlbum',
                dataType: 'json',
                method: 'POST',
                //data: "{ 'title': '" + title + "', 'description': '" + descr + "', 'isPublic': '" + isPublic + "' }"
                data: { albumData: data }
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data);
            });
        }

        factory.UpdateAlbum = function (data, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/UpdateAlbum',
                dataType: 'json',
                method: 'POST',
                data: { albumData: data }
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

        factory.AddPhoto = function (data, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/AddPhoto',
                dataType: 'json',
                method: 'POST',
                data: { photoData: data }
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data, status, headers, config);
            });
        }

        factory.UpdatePhoto = function (data, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/UpdatePhoto',
                dataType: 'json',
                method: 'POST',
                data: { photoData: data }
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

        factory.RecreateThumb = function (path) {
            var httpParams = {
                url: '/DataActionService.asmx/RecreateThumbnail',
                dataType: 'json',
                method: 'POST',
                data: "{ 'path': '" + path + "' }"
            };

            return $http(httpParams).then(
                function (res) {
                    return res.data.d;
                }
            );
        }

        return factory;
    }

    GalleryServiceFactory.$inject = injectParams;

    angular.module('ddteGalleryApp').factory('GalleryServiceFactory', GalleryServiceFactory);
}());
