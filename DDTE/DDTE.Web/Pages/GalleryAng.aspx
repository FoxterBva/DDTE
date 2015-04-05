<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.master" AutoEventWireup="true" CodeBehind="GalleryAng.aspx.cs" Inherits="DDTE.Web.Pages.GalleryAng" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
    <%--<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.6/angular.min.js"></script>--%>
    <script src="/Scripts/angular-1.3.6.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <div data-ng-app="ddteGalleryApp">
        <div data-ng-controller="GalleryController">
            <asp:Panel ID="pnlAddAlbum" runat="server">
                <div>
                    <div>Title: <input type="text" data-ng-model="AlbumTitle" /></div>
                    <div>Description: <input type="text" data-ng-model="AlbumDescr" /></div>
                    <div>Public?: <input type="checkbox" data-ng-model="IsPublic" /></div>
                </div>
                <a class="btn-add" id="btnAddPhotoItem" runat="server" href="#" data-ng-click="AddItem()">Add</a>
                
            </asp:Panel>
            
            <div data-ng-repeat="pi in photoItems" class="photo-item">
                <div data-ng-if="pi.ItemType == 0">
                    <div class="photo-album">
                        <div class="title" data-ng-click="SelectFolder(pi.Id)">{{ pi.Title }}</div>
                        <div class="descr">{{ pi.Description }}</div>
                    </div>
                </div>
                <div data-ng-if="pi.ItemType == 1">
                    <div class="photo-image-container">
                        <a class="img-link" href="#" data-ng-click="ViewImage(pi)" >
                            <!-- onclick="$('#overlay').toggle();$('#bigImage').attr('src', $(this).children().first().attr('src')); return false;" -->
                            <img id="imgPhoto" runat="server" src="#" data-ng-src="{{ pi.ImagePath }}" class="photo-image"  />
                        </a>
                    </div>
                    <div class="img-title">{{ pi.Title }}</div>
                </div>
            </div>

            <div id="overlay" class="photo-overaly" data-ng-click="CloseImage();" data-ng-show="displayImage" ></div>
            <div class="photo-big" data-ng-show="displayImage">
                <div class="btn-close" data-ng-click="CloseImage()">x</div>
                <div class="photo-big-title">{{ currentImage.Title }}</div>
                <img id="bigImage" src="#" data-ng-src="{{ currentImage.ImagePath }}" class="img-big" />
                <div class="photo-big-descr">{{ currentImage.Description }}</div>
            </div>
        </div>
    </div>

    <script src="/Scripts/Gallery/app.js"></script>
    <script src="/Scripts/Gallery/galleryService.js"></script>
    <script src="/Scripts/Gallery/galleryController.js"></script>
</asp:Content>
