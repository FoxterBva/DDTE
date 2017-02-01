<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.master" AutoEventWireup="true" CodeBehind="GalleryAng.aspx.cs" Inherits="DDTE.Web.Pages.GalleryAng" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
    <%--<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.6/angular.min.js"></script>--%>
    <script src="/Scripts/angular.min.js"></script>

    <script type="text/javascript">
        function adjustResizerSize(ignoreVisibility) {
            var resizer = $('#bigImageResizer');
            if (!resizer.is(":visible") && !ignoreVisibility)
                return;

            var viewportWidth = $(window).width();
            var viewportHeight = $(window).height();

            var maxWidth = viewportWidth * 0.8;
            var maxHeight = viewportHeight * 0.8 - 100;

            var image = $('#bigImage', resizer);
            var imgHeight = image[0].naturalHeight;
            var imgWidth = image[0].naturalWidth;

            // another approach to determine image size
            //var tempImg = new Image();
            //tempImg.onload = function () {
            //    imgHeight = this.width;
            //    imgWidth = this.height;
            //}
            //tempImg.src = image.attr('src');

            if (imgHeight > maxHeight && imgWidth > maxWidth)
            {
                var hRatio = imgHeight / maxHeight;
                var wRatio = imgWidth / maxWidth;
                if (hRatio > wRatio) {
                    resizer.height = maxHeight;
                    resizer.width(maxHeight * imgWidth / imgHeight + 'px');
                }
                else {
                    resizer.width(maxWidth + 'px');
                    resizer.height(maxWidth * imgHeight / imgWidth + 'px');
                }
            }
            else if (imgHeight > maxHeight)
            {
                resizer.height(maxHeight + 'px');
                resizer.width(maxHeight * imgWidth / imgHeight + 'px');
            }
            else if (imgWidth > maxWidth) {
                resizer.width(maxWidth + 'px');
                resizer.height(maxWidth * imgHeight / imgWidth + 'px');
            }
            else
            {
                resizer.width(imgWidth + 'px');
                resizer.height(imgHeight + 'px');
            }
        }

        $(window).resize(function () {
            adjustResizerSize(false);
        });

        $(document).ready(function () {
            //var resizer = $('#bigImageResizer');
            // call on visibility changed
            //resizer..visible(function () {  });
            $('#bigImage').load(function () { adjustResizerSize(true); });
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <div data-ng-app="ddteGalleryApp" class="gallery-main">
        <div data-ng-controller="GalleryController">
            <div class="breadcrumb">
                <span  data-ng-click="SelectFolder(-1)" style="cursor: pointer">Все Альбомы</span>
                <span data-ng-show="currentFolder > 0" >&nbsp;/&nbsp;{{ CurrentFolderTitle }}</span>
            </div>
            
            <asp:Panel ID="pnlAddAlbum" runat="server">
                <div class="button" data-ng-show="currentFolder <= 0" data-ng-click="ToggleCreateAlbumForm()">Добавить альбом</div>
                <div data-ng-show="DisplayEditForm  && currentFolder <= 0" class="edit-form album">
                    <fieldset>
                        <legend>Редактирование альбома</legend>
                        <div class="album-edit-row title"><label>Название: </label><input type="text" data-ng-model="SelectedAlbum.Title" /></div>
                        <div class="album-edit-row descr"><label>Описание: </label><textarea data-ng-model="SelectedAlbum.Description" ></textarea></div>
                        <div class="album-edit-row public"><input type="checkbox" data-ng-model="SelectedAlbum.IsPublic" /><label>публичный</label></div>
                    </fieldset>
                    
                    <div class="button" id="btnAddPhotoItem" data-ng-click="AddAlbum()" >Подтвердить</div>
                    <div class="button" id="btnCloseAlbumEditForm" data-ng-click="ToggleCreateAlbumForm()" >Закрыть</div>
                </div>
            </asp:Panel>
            
            <asp:Panel ID="pnlAddPhoto" runat="server">
                <div class="button" data-ng-show="currentFolder > 0" data-ng-click="ToggleCreatePhotoForm()">Добавить фото</div>
                <div data-ng-show="DisplayEditForm  && currentFolder > 0" class="edit-form photo">
                    <fieldset>
                        <legend>Редактирование фотографии</legend>
                        <div class="photo-edit-row title"><label>Название:</label><input type="text" data-ng-model="SelectedPhoto.Title" /></div>
                        <div class="photo-edit-row descr"><label>Описание:</label> <textarea data-ng-model="SelectedPhoto.Description" ></textarea></div>
                        <div class="photo-edit-row public"><input type="checkbox" data-ng-model="SelectedPhoto.IsPublic" /> <label>публичная</label></div>
                        <div class="photo-edit-row url" data-ng-show="SelectedPhoto.Id == null"><label>URL-адрес: </label><input type="text" data-ng-model="SelectedPhoto.Url" /></div>
                        <div class="photo-edit-row file" data-ng-show="SelectedPhoto.Id == null"><label>либо выберите файл </label><input id="photoFileSelector" type="file" data-ng-model="SelectedPhoto.File" /></div>
                    </fieldset>
                    
                    <div class="button" id="btnAddPhoto" data-ng-click="AddPhoto()" >Подтвердить</div>
                    <div class="button" id="btnClosePhotoEditForm" data-ng-click="ToggleCreatePhotoForm()" >Закрыть</div>
                </div>
            </asp:Panel>

            <div class="photo-items">
                <div class="data-load-overlay" data-ng-show="DisplayLoading">Загрузка...</div>
                <div data-ng-repeat="pi in photoItems" data-ng-class="{ 'photo-item album' : pi.ItemType == 0, 'photo-item' : pi.ItemType == 1 } " >
                    <div data-ng-if="pi.ItemType == 0">
                        <div class="photo-album" data-ng-click="SelectFolder(pi.Id, pi.Title)" title="Смотреть" >
                            <span class="title" >{{ pi.Title }}</span>
                            <div class="count">({{ pi.PhotoCount }} фотографи{{ pi.PhotoCount % 10 == 1 ? 'я' : pi.PhotoCount % 10 > 4 || pi.PhotoCount % 10 == 0 ? 'й' : 'и' }})</div>
                            <span class="descr">{{ pi.Description }}</span>
                            <span class="created">Добавлено: {{ pi.CreatedDate | jsDate | date:'yyyy-MM-dd' }}</span>
                            
                        </div>
                        <asp:Literal ID="ltlAlbumActions" runat="server">
                            <div class="actions">
                                <div class="button" data-ng-click="ToggleEditAlbumForm(pi.Id)" title="Редактировать альбом" >Изменить</div>
                                <div class="button" data-ng-click="DeleteAlbum(pi.Id, pi.Title)" title="Удалить альбом" >Удалить</div>
                            </div>
                        </asp:Literal>
                    </div>
                    <div data-ng-if="pi.ItemType == 1">
                        <div class="photo">
                            <div class="photo-image-container">
                                <a class="img-link" href="#" data-ng-click="ViewImage(pi)" >
                                    <!-- onclick="$('#overlay').toggle();$('#bigImage').attr('src', $(this).children().first().attr('src')); return false;" -->
                                    <img id="imgPhoto" runat="server" src="#" data-ng-src="{{ pi | tmbimage  }}" class="photo-image blind-visible"  />
                                </a>
                            </div>
                            <div class="img-title">{{ pi.Title }}</div>
                        </div>
                        <asp:Literal ID="ltlPhotoActions" runat="server">
                            <div class="actions">
                                <div class="button" data-ng-click="ToggleEditPhotoForm(pi.Id)" title="Редактировать фотографию" >Изменить</div>
                                <div class="button" data-ng-click="DeletePhoto(pi.Id, pi.Title)" title="Удалить фотографию" >Удалить</div>
                                <div class="button" data-ng-click="RecreateThumb(pi)" title="Пересоздать превью" >Пересоздать превью</div>
                            </div>
                        </asp:Literal>
                    </div>
                </div>
            </div>

            <div id="overlay" class="photo-overaly" data-ng-click="CloseImage();" data-ng-show="displayImage" data-ng-cloak ></div>
            <div class="photo-big-container" data-ng-show="displayImage" data-ng-cloak>
                <div class="photo-big" >
                    <div class="btn-close" data-ng-click="CloseImage()">x</div>
                    <div class="photo-big-title">{{ currentImage.Title }}</div>
                    <div class="img-big" id="bigImageResizer" style="position: relative">
                        <img id="bigImage" src="#" data-ng-src="{{ currentImage.ImagePath }}" class="img-big blind-visible" />
                        <div class="slider-cnt img-prev" style="">
                            <div data-ng-click="PrevImage()" class="slider-btn"></div>
                        </div>
                        <div class="slider-cnt img-next" style="">
                            <div data-ng-click="NextImage()" class="slider-btn"></div>
                        </div>
                    </div>
                    <div class="photo-big-descr">{{ currentImage.Description }}</div>
                </div>
            </div>
<%--            <div id="overlay" class="photo-overaly" data-ng-click="CloseImage();" data-ng-show="displayImage" data-ng-cloak ></div>
            <div class="photo-big-container" data-ng-show="displayImage" data-ng-cloak>
                <div style="max-height: 500px; max-width: 100%; display: table;">
                    <img id="bigImage" src="#" data-ng-src="{{ currentImage.ImagePath }}" style="max-height: 100%; max-width: 100%;"  />
                </div>
            </div>--%>
        </div>
    </div>

    <script src="/Scripts/Gallery/app.js"></script>
    <script src="/Scripts/Gallery/galleryService.js"></script>
    <script src="/Scripts/Gallery/galleryController.js"></script>
</asp:Content>
