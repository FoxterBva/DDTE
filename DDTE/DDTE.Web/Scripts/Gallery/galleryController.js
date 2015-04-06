(function () {
    var injectParams = ['$scope', 'GalleryServiceFactory'];

    var GalleryController = function ($scope, GalleryServiceFactory) {
        $scope.name = 'Photo Viewer';
        $scope.photoItems = [];
        $scope.currentImage = GetEmptyImage();
        $scope.displayImage = false;
        $scope.currentFolder = -1;
        $scope.IsPublic = true;
        $scope.Errors = [];                 // list of recent errors

        $scope.GetItems = function (albumId) {
            GalleryServiceFactory.GetPhotoItems(albumId, onItemsLoaded, onError)
            $scope.currentFolder = albumId;
        }

        $scope.SelectFolder = function (albumId) {
            $scope.GetItems(albumId);
            return false;
        }

        $scope.ViewImage = function (img) {
            $scope.currentImage = img;
            $scope.displayImage = true;
            return false;
        }

        $scope.CloseImage = function () {
            $scope.currentImage = GetEmptyImage();
            $scope.displayImage = false;
            return false;
        }

        $scope.AddItem = function () {
            if ($scope.currentFolder == -1) {
                GalleryServiceFactory.AddAlbum($scope.AlbumTitle, $scope.AlbumDescr, $scope.IsPublic, onAlbumCreated, onError);
            } else {
                // AddPhoto();
            }

            return false;
        }

        $scope.DeleteAlbum = function (id, title) {
            if (confirm("Вы действительно хотите удалить альбом '" + title + "' со всеми фотографиями?")) {
                GalleryServiceFactory.DeleteAlbum(id, onAlbumDeleted, onError);
            }
        }

        function onItemsLoaded(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else
                $scope.photoItems = data.d.PhotoItems;
        }

        function onAlbumCreated(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                alert('Альбом создан!');
            }
        }

        function onAlbumDeleted(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                alert('Альбом удален!');
            }
        }

        function GetEmptyImage() {
            return {
                Title: '',
                Description: '',
                ImagePath: ''
            };
        }

        function onError(data, status, headers, config) {
            $scope.Errors.push({ Data: data, Status: status, Headers: headers, Config: config });
            alert('Операция завершена с ошибкой');
        }

        $scope.GetItems($scope.currentFolder);
    }

    GalleryController.$inject = injectParams;

    angular.module('ddteGalleryApp').controller('GalleryController', GalleryController);
}());