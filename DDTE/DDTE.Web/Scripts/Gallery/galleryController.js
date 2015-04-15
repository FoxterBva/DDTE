(function () {
    var injectParams = ['$scope', 'GalleryServiceFactory'];

    var GalleryController = function ($scope, GalleryServiceFactory) {
        $scope.name = 'Photo Viewer';
        $scope.photoItems = [];
        $scope.currentImage = GetEmptyImage();
        $scope.displayImage = false;
        $scope.currentFolder = -1;
        $scope.CurrentFolderTitle = '';
        $scope.Errors = [];                 // list of recent errors
        $scope.SelectedAlbum = GetEmptyAlbum()
        $scope.SelectedPhoto = GetEmptyPhoto()
        $scope.DisplayEditForm = false;
        $scope.DisplayLoading = false;

        $scope.GetItems = function (albumId) {
            $scope.DisplayLoading = true;
            GalleryServiceFactory.GetPhotoItems(albumId, onItemsLoaded, onError)
            $scope.currentFolder = albumId;
        }

        $scope.SelectFolder = function (albumId, title) {
            $scope.GetItems(albumId);
            $scope.CurrentFolderTitle = title;
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

        $scope.ToggleCreateAlbumForm = function () {
            $scope.DisplayEditForm = !$scope.DisplayEditForm;
            if ($scope.DisplayEditForm)
            {
                $scope.SelectedAlbum = GetEmptyAlbum()
            }
        }

        $scope.ToggleCreatePhotoForm = function () {
            $scope.DisplayEditForm = !$scope.DisplayEditForm;
            if ($scope.DisplayEditForm) {
                $scope.SelectedPhoto = GetEmptyPhoto()
            }
        }

        $scope.ToggleEditAlbumForm = function (albumId) {
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

        $scope.ToggleEditPhotoForm = function (photoId) {
            $scope.DisplayEditForm = true;
            var items = $scope.photoItems;

            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                if (item.ItemType == 1 && item.Id == photoId) {
                    $scope.SelectedPhoto = { Title: item.Title, Description: item.Description, IsPublic: item.IsPublic, Id: item.Id, Url: item.Url };
                }
            }
        }

        $scope.AddAlbum = function () {
            if ($scope.currentFolder == -1) {
                if ($scope.SelectedAlbum.Id != null) {
                    var data = { AlbumId: $scope.SelectedAlbum.Id, Title: $scope.SelectedAlbum.Title, Description: $scope.SelectedAlbum.Description, IsPublic: $scope.SelectedAlbum.IsPublic }
                    GalleryServiceFactory.UpdateAlbum(data, onAlbumUpdated, onError);
                } else {
                    var data = { Title: $scope.SelectedAlbum.Title, Description: $scope.SelectedAlbum.Description, IsPublic: $scope.SelectedAlbum.IsPublic }
                    GalleryServiceFactory.AddAlbum(data, onAlbumCreated, onError);
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
            if ($scope.currentFolder > 0) {
                if ($scope.SelectedPhoto.Id != null) {
                    var data = { PhotoId: $scope.SelectedPhoto.Id, Title: $scope.SelectedPhoto.Title, Description: $scope.SelectedPhoto.Description, isPublic: $scope.SelectedPhoto.IsPublic }
                    GalleryServiceFactory.UpdatePhoto(data, onPhotoUpdated, onError);
                } else {
                    // TODO: 
                    var f = document.getElementById('photoFileSelector').files[0];

                    if (f) {

                        var r = new FileReader();
                        var fileName;
                        r.onload = (function (theFile) {
                            fileName = theFile.name;
                        })(f);
                        r.onloadend = function (e) {
                            var q = this.file;
                            var fileStr = e.target.result.split(',')[1];
                            var data = { Title: $scope.SelectedPhoto.Title, Description: $scope.SelectedPhoto.Description, isPublic: $scope.SelectedPhoto.IsPublic, Url: $scope.SelectedPhoto.Url, AlbumId: $scope.currentFolder, File: fileStr, FileName: fileName };
                            GalleryServiceFactory.AddPhoto(data, onPhotoCreated, onError);
                        }
                        r.readAsDataURL(f);
                    } else {
                        if (!$scope.SelectedPhoto.Url){
                            alert('Нужно указать либо URL либо выбрать файл.');
                            return false;
                        }
                        var data = { Title: $scope.SelectedPhoto.Title, Description: $scope.SelectedPhoto.Description, isPublic: $scope.SelectedPhoto.IsPublic, Url: $scope.SelectedPhoto.Url, AlbumId: $scope.currentFolder, File: '', FileName: fileName };
                        GalleryServiceFactory.AddPhoto(data, onPhotoCreated, onError);
                    }
                }
            } else {

            }

            return false;
        }

        $scope.DeletePhoto = function (id, title) {
            if (confirm("Вы действительно хотите удалить фотографию '" + title + "'?")) {
                GalleryServiceFactory.DeletePhoto(id, onPhotoDeleted, onError);
            }
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
                $scope.ToggleCreateAlbumForm();
                alert('Альбом создан!');
            }
        }

        function onAlbumUpdated(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                $scope.ToggleCreateAlbumForm();
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

        function onPhotoCreated(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                $scope.ToggleCreatePhotoForm();
                alert('Фотография добавлена!');
            }
        }

        function onPhotoUpdated(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                $scope.ToggleCreatePhotoForm();
                alert('Фотография изменена!');
            }
        }

        function onPhotoDeleted(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                $scope.GetItems($scope.currentFolder);
                alert('Фотография удалена!');
            }
        }

        function GetEmptyAlbum() {
            return {
                Id: null,
                IsPublic: true,
                Title: '',
                Description: ''
            };
        }

        function GetEmptyPhoto() {
            return {
                Id: null,
                IsPublic: true,
                Url: '',
                Title: '',
                Description: '',
                File: null
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

        function Init()
        {
            $scope.GetItems($scope.currentFolder);
        }

        Init();
    }

    GalleryController.$inject = injectParams;

    angular.module('ddteGalleryApp').controller('GalleryController', GalleryController);
}());