<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="PaidServices.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.PaidServices" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Платные образовательные услуги</h2>
    <ctr:DocumentList ID="dlPaidServices" runat="server" Category="PaidServices" />
</asp:Content>
