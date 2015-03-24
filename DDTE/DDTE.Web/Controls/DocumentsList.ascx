<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DocumentsList.ascx.cs" Inherits="DDTE.Web.Controls.DocumentsList" %>

<section class="documents-list">
    <asp:Panel ID="pnlAddDocument" runat="server" CssClass="add-document-main">
        <a href="#" onclick="$(this).next().toggle(); return false;">Добавить документ</a>
        <asp:Panel ID="pnlFormContainer" runat="server" style="display: none;">
            <div><asp:Literal ID="ltlMessage" runat="server" EnableViewState="false" /></div>
            <fieldset class="add-document">
                <legend>Добавление файла:</legend>
                <div><asp:Label ID="lblCategory" runat="server" Text="Раздел:" AssociatedControlID="tbCategory" /></div>
                <div><asp:TextBox ID="tbCategory" runat="server" /></div>
                <div>Выберите файл:</div>
                <div>
                    <asp:FileUpload CssClass="controls" ID="fuDocuments" runat="server" multiple="false"  />
                </div>
                <asp:Button ID="btnUpload" runat="server" Text="Добавить файл" OnClick="btnUpload_Click" />
            </fieldset>
        </asp:Panel>
    </asp:Panel>

    <section>
        <asp:Repeater ID="rptrFiles" runat="server" OnItemDataBound="rptrFiles_ItemDataBound" OnItemCommand="rptrFiles_ItemCommand">
            <HeaderTemplate>
                <ul class="documents">
            </HeaderTemplate>
            <ItemTemplate>
                    <li class="documents-item">
                        <a href='/FileDownload.ashx?file=<%# (bool)Eval("IsLocal") ? Page.ResolveUrl("~/" + DocumentFolder + Eval("Link")) : Eval("Link") %>' class="document-link-download" title="загрузить" target="_blank">(загрузить)</a>
                        <a href="#" class="document-link-view" title="просмотреть"></a>
                        <asp:HyperLink ID="hpDocumentLink" runat="server" ToolTip="Нажмите для просмотра" CssClass="extension-link"><%# Eval("LinkName") %></asp:HyperLink>
                        <asp:LinkButton ID="lbDelete" runat="server" ToolTip="Удалить документ" Text="(Удалить)" CssClass="btn-delete" OnClientClick="return confirm('Удалить файл?')" CommandName="Delete" CommandArgument='<%# Eval("Link") %>' />
                    </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </section>
</section>