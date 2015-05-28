(function () {
    var injectParams = ['$http'];

    var UnionServiceFactory = function ($http) {
        var factory = {};

        factory.GetUnion = function (unionId, onCompleted, onError) {
            var httpParams = {
                url: '/DataActionService.asmx/GetUnion',
                dataType: 'json',
                method: 'POST',
                data: "{ 'unionId': '" + unionId + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data);
            });
        }

        factory.SaveUnion = function (union, onCompleted, onError) {
            var obj = { union: union };

            var httpParams = {
                url: '/DataActionService.asmx/SaveUnion',
                dataType: 'json',
                method: 'POST',
                //data: "{ 'unionId': '" + unionId + "' }"
                data: obj
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data);
            });
        }

        factory.DeleteUnion = function (unionId, onCompleted, onError) {

            var httpParams = {
                url: '/DataActionService.asmx/DeleteUnion',
                dataType: 'json',
                method: 'POST',
                data: "{ 'unionId': '" + unionId + "' }"
            };

            $http(httpParams)
            .success(function (data, status, headers, config) {
                onCompleted(data)
            })
            .error(function (data, status, headers, config) {
                onError(data);
            });
        }

        return factory;
    }

    UnionServiceFactory.$inject = injectParams;

    angular.module('ddteUnionApp').factory('UnionServiceFactory', UnionServiceFactory);
}());
