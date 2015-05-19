<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="LogisticalSupport.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.LogisticalSupport" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Материально-техническое обеспечение и оснащенность образовательного процесса</h2>
    <ctr:DocumentList ID="dlMTO" runat="server" Category="MTO" />
</asp:Content>
