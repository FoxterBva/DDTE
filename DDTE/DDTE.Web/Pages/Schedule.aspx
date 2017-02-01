<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="DDTE.Web.Pages.Schedule" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Расписание</h2>
    <asp:Panel ID="pnlSchedule" runat="server">
        <asp:Literal ID="ltlMessage" runat="server" EnableViewState="false" />
        <div>Загрузить расписание: <asp:FileUpload CssClass="controls" ID="fuSchedule" runat="server" multiple="false"  /><asp:Button ID="btnUpload" runat="server" Text="Загрузить" OnClick="btnUpload_Click" /></div>
    </asp:Panel>
    <asp:HyperLink ID="hfDownload" runat="server" Text="Скачать расписание" Target="_blank"></asp:HyperLink>
    <div style="position: relative; width: 1270px; left: -50px;">
    <iframe style="width: 100%; height: 100%; min-height: 600px;" src="/Schedule/Schedule.html"></iframe>
    </div>

        <%-- 
        <div>
            <a href="https://docs.google.com/spreadsheets/d/1JvuTMGeClbDWIC96qAwgjYEitM5xCJwIqmzeQiLkZXg/edit?usp=sharing" target="_blank">Редактировать</a>

            <iframe style="width: 100%; min-height:800px" src="https://docs.google.com/spreadsheets/d/1JvuTMGeClbDWIC96qAwgjYEitM5xCJwIqmzeQiLkZXg/pubhtml?gid=0&amp;single=true&amp;widget=false&amp;headers=false&amp;chrome=false"></iframe>
        </div>
        --%>
    
</asp:Content>
