(function () {
    var injectParams = ['$scope', 'GalleryServiceFactory'];

    var GalleryController = function ($scope, GalleryServiceFactory) {
        $scope.name = 'Photo Viewer';
        $scope.photoItems = [];
        $scope.currentImage = GetEmptyImage();
        $scope.displayImage = false;
        $scope.currentFolder = -1;
        $scope.Errors = [];                 // list of recent errors
        $scope.SelectedAlbum = GetEmptyAlbum()
        $scope.DisplayEditForm = false;
        $scope.DisplayLoading = false;

        $scope.GetItems = function (albumId) {
            GalleryServiceFactory.GetPhotoItems(albumId, onItemsLoaded, onError)
            $scope.DisplayLoading = true;
            $scope.currentFolder = albumId;
        }

        $scope.SelectFolder = function (albumId) {
            $scope.GetItems(albumId);
        }

        $scope.ViewImage = function (img) {
            $scope.currentImage = img;
            $scope.displayImage = true;
            return false;
        }

        $scope.ToggleCreateAlbumForm = function () {
            $scope.DisplayEditForm = !$scope.DisplayEditForm;
            if ($scope.DisplayEditForm)
            {
                $scope.SelectedAlbum = GetEmptyAlbum()
            }
        }

        $scope.ToggleCreateEditForm = function (albumId) {
            $scope.DisplayEditForm = true;
            var items = $scope.photoItems;

            for (var i = 0; i < items.length; i++)
            {
                var item = items[i];
                if (item.ItemType == 0 && item.Id == albumId) {
                    $scope.SelectedAlbum = { Title: item.Title, Description: item.Description, IsPublic: item.IsPublic, Id: item.Id };
                }
            }
        }

        $scope.CloseImage = function () {
            $scope.currentImage = GetEmptyImage();
            $scope.displayImage = false;
            return false;
        }

        $scope.AddAlbum = function () {
            if ($scope.currentFolder == -1) {
                if ($scope.SelectedAlbum.Id != null) {
                    GalleryServiceFactory.UpdateAlbum($scope.SelectedAlbum.Id, $scope.SelectedAlbum.Title, $scope.SelectedAlbum.Description, $scope.SelectedAlbum.IsPublic, onAlbumUpdated, onError);
                } else {
                    GalleryServiceFactory.AddAlbum($scope.SelectedAlbum.Title, $scope.SelectedAlbum.Description, $scope.SelectedAlbum.IsPublic, onAlbumCreated, onError);
                }
            } else {
                
            }

            return false;
        }

        $scope.DeleteAlbum = function (id, title) {
            if (confirm("Вы действительно хотите удалить альбом '" + title + "' со всеми фотографиями?")) {
                GalleryServiceFactory.DeleteAlbum(id, onAlbumDeleted, onError);
            }
        }

        $scope.AddPhoto = function () {

        }

        function onItemsLoaded(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else
                $scope.photoItems = data.d.PhotoItems;

            $scope.DisplayLoading = false;
        }

        function onAlbumCreated(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                alert('Альбом создан!');
            }
        }

        function onAlbumUpdated(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                alert('Альбом обновлен!');
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

        function GetEmptyAlbum() {
            return {
                Id: null,
                IsPublic: false
            };
        }

        function GetEmptyImage() {
            return {
                Title: '',
                Description: '',
                ImagePath: ''
            };
        }

        function onError(data, status, headers, config) {
            $scope.DisplayLoading = false;
            $scope.Errors.push({ Data: data, Status: status, Headers: headers, Config: config });
            alert('Операция завершена с ошибкой');
        }

        $scope.GetItems($scope.currentFolder);
    }

    GalleryController.$inject = injectParams;

    angular.module('ddteGalleryApp').controller('GalleryController', GalleryController);
}());