<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="DocumentsDownload.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.DocumentsDownload" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Документы</h2>
    <%--<asp:Panel ID="pnlAddDocument" runat="server" CssClass="add-document-main">
        <a href="#" onclick="$(this).next().toggle()">Добавить</a>
        <section class="add-document">
            <div class="add-document-prompt">Выберите файл:</div>
            <asp:FileUpload CssClass="controls" ID="fuDocuments" runat="server" multiple="true" />
            <asp:Button ID="btnUpload" runat="server" Text="Добавить выбранные файлы" OnClick="btnUpload_Click" />
        </section>
    </asp:Panel>
    <section class="document-list">
        <asp:Repeater ID="rptrFiles" runat="server">
            <HeaderTemplate>
                <ul class="documents">
            </HeaderTemplate>
            <ItemTemplate>
                    <li class="documents-item">
                        <a href="#" class="document-link-download" title="загрузить"></a>
                        <a href='<%# Page.ResolveUrl("~/Documents/" + Eval("FileName")) %>' class="document-link" title="Нажмите для просмотра"><%# Eval("FileName") %></a>
                    </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </section>--%>
    <ctr:DocumentList ID="documentList" runat="server" Category="Documents" />
</asp:Content>
