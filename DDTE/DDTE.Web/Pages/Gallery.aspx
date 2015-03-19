<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="DDTE.Web.Pages.Gallery" %>

<%@ Register Src="~/Controls/PhotoViewer.ascx" TagName="PhotoViewer" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--<section class="gallery-main">
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
        <div class="photo-placeholder"></div>
    </section>--%>
    <ctr:PhotoViewer ID="pbPhotos" runat="server" />
</asp:Content>
