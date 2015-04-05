(function () {
    var injectParams = ['$scope', 'GalleryServiceFactory'];

    var GalleryController = function ($scope, GalleryServiceFactory) {
        $scope.name = 'Photo Viewer';
        $scope.photoItems = [];
        $scope.currentImage = GetEmptyImage();
        $scope.displayImage = false;
        $scope.currentFolder = -1;

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
                GalleryServiceFactory.AddFolder($scope.AlbumTitle, $scope.AlbumDescr, $scope.IsPublic, onAlbumCreated, onError);
            } else {
                // AddPhoto();
            }

            return false;
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
            else
                alert('Альбом создан!');
        }

        function GetEmptyImage() {
            return {
                Title: '',
                Description: '',
                ImagePath: ''
            };
        }

        function onError(data) {
            alert(data);
        }

        $scope.GetItems($scope.currentFolder);
    }

    GalleryController.$inject = injectParams;

    angular.module('ddteGalleryApp').controller('GalleryController', GalleryController);
}());