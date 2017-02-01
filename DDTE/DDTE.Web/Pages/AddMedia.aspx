<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.Master" AutoEventWireup="true" CodeBehind="AddMedia.aspx.cs" Inherits="DDTE.Web.Pages.AddMedia" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Медиа файлы</h2>
    <ctr:DocumentList ID="dlMediaFiles" runat="server" Category="GeneralMedia" DisplayGetLinkBtn="true" />
</asp:Content>
