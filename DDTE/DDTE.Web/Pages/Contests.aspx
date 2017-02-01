<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.Master" AutoEventWireup="true" CodeBehind="Contests.aspx.cs" Inherits="DDTE.Web.Pages.Contests" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Конкурсы</h2>
    <ctr:DocumentList ID="dlContests" runat="server" Category="Contests" />
</asp:Content>
