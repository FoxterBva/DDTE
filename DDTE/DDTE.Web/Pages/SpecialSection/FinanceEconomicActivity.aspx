<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="FinanceEconomicActivity.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.FinanceEcomonicActivity" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Финансово-хозяйственная деятельность</h2>
    <ctr:DocumentList ID="dlFinanceEconomicActivity" runat="server" Category="FinanceEconomicActivity" />
</asp:Content>
