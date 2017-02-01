<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DocumentsList.ascx.cs" Inherits="DDTE.Web.Controls.DocumentsList" %>

<section class="documents-list">
    <asp:Panel ID="pnlAddDocument" runat="server" CssClass="add-document-main">
        <a href="#" onclick="$(this).next().toggle(); return false;" class="document-link-add">Добавить документ</a>
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
                        <asp:LinkButton ID="lbDelete" runat="server" ToolTip="Удалить документ" OnClientClick="return confirm('Удалить файл?')" CommandName="Delete" CommandArgument='<%# Eval("Link") %>' class="document-link-btn delete" />
                        <a href='<%# (bool)Eval("IsLocal") ? Page.ResolveUrl("~/" + DocumentFolder + Eval("Link")) : Eval("Link") %>' class="document-link-btn view" title="просмотреть" target="_blank"></a>
                        <a href='/FileDownload.ashx?file=<%# (bool)Eval("IsLocal") ? Page.ResolveUrl("~/" + DocumentFolder + Eval("Link")) : Eval("Link") %>' class="document-link-btn download" title="загрузить" target="_blank"></a>
                        <asp:HyperLink ID="hpLinkInfo" runat="server" CssClass="document-link-btn getlink" title="показать ссылку на файл" onclick="$('.tbLink', $(this).parent()).toggle(); return false;" >(i)</asp:HyperLink>
                        <div style="display: table-cell; vertical-align: middle; height: 24px;">
                            <asp:HyperLink ID="hpDocumentLink" runat="server" ToolTip="Нажмите для просмотра" CssClass="extension-link"><%# Eval("LinkName") %></asp:HyperLink>
                            <asp:TextBox ID="tbLink" runat="server" CssClass="tbLink" Text='<%# Page.ResolveUrl("~/" + DocumentFolder + Eval("Link")) %>' style="display: none; min-width: 500px;"></asp:TextBox>
                        </div>
                    </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </section>
</section>