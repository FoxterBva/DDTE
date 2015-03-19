<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.Education" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Образование</h2>
    <p>Общая информация: ДДТ «Эврика» осуществляет образовательный процесс по 4 направленностям:</p>
    <ul style="list-style: none">
        <li>- художественно-эстетическая</li>
        <li>- социально-педагогическая</li>
        <li>- культурологическая</li>
        <li>- военно-патриотическая</li>
    </ul>
    <p>Образование осуществляется на русском языке.</p>

    <ctr:DocumentList ID="documentList" runat="server" Category="Education" />
</asp:Content>
