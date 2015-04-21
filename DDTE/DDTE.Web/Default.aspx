<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DDTE.Web.Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
    <link rel="stylesheet" href="Scripts/SCEditor/default.css" type="text/css" media="all" />
    <script type="text/javascript" src="Scripts/SCEditor/jquery.sceditor.xhtml.js"></script>

    <script type="text/javascript">
        var editContext = {};

        function ShowEditForm(newsId) {
            var form = $('#editForm').show();
            editContext.title = newsId == '0' ? '' : $('span[data-title="' + newsId + '"]').html().trim();
            editContext.content = newsId == '0' ? '' : $('article[data-content="' + newsId + '"]').html().trim();

            $('.tbContent', form).val(editContext.content);
            $('.tbTitle', form).val(editContext.title);
        }

        function CloseEditForm()
        {
            $('#editForm').hide();
            editContext = {};
        }

        function ShowPreview() {
            $('.preview').show();
            var form = $('#editForm');

            $('span[data-title="0"]').html($('.tbTitle', form).val().trim());
            $('article[data-content="0"]').html($('.tbContent', form).val().trim());
        }

        //$(function () { $(".tbContent").sceditor({ plugins: "xhtml", style: "jquery.sceditor.default.css" }); });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Новости</h2>

    <asp:Literal ID="ltlMessage" runat="server" EnableViewState="false" />

    <asp:Panel ID="pnlAddNews" runat="server">
        <asp:LinkButton ID="lbAddNews" runat="server" Text="Добавить новость" CssClass="button" OnClientClick="ShowEditForm(0); return false;"></asp:LinkButton>
    </asp:Panel>

    <asp:Panel ID="pnlEditForm" runat="server" >
        <div id="editForm" class="news-edit-form">
            <fieldset>
                <legend>Редактирование новости</legend>
                <div>Заголовок:</div><div> <asp:TextBox ID="tbTitle" runat="server" CssClass="tbTitle" /></div>
                <div>Автор:</div><div> <asp:TextBox ID="tbAuthor" runat="server" CssClass="tbAuthor" /></div>
                <div>Текст новости:</div><div> <asp:TextBox ID="tbContent" runat="server" TextMode="MultiLine" Rows="15" CssClass="tbContent" /></div>
            </fieldset>
            <a class="button" onclick="ShowPreview();return false;" ToolTip="Предпросмотр новости">Предпросмотр</a>
            <asp:LinkButton ID="lbSubmit" runat="server" Text="Опубликовать" CssClass="button" OnClick="lbSubmit_Click" ToolTip="Опубликовать новость" />
            <a class="button" onclick="CloseEditForm();return false;" title="Отменить добавление/изменение новости">Закрыть</a>
        </div>
    </asp:Panel>

    <asp:Repeater ID="rptrNews" runat="server" OnItemCommand="rptrNews_ItemCommand">
        <HeaderTemplate>
            <ul class="news-list">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="news <%# (int)Eval("NewsId") == 0 ? "preview" : "" %>">
                <header>
                    <h3>
                        [<%# (int)Eval("NewsId") == 0 ? "<span class='preview'> ПРЕДПРОСМОТР </span>" : Eval("CreatedDate", "{0:yyyy-MM-dd}") %>] 
                        <span data-title='<%# Eval("NewsId") %>'>
                            <%# HttpUtility.HtmlEncode((string)Eval("Title")) %>
                        </span>
                    </h3>
                    <asp:Panel ID="pnlActions" runat="server" Visible='<%# DDTE.Web.Helpers.SecurityHelper.CanEditNews() && (int)Eval("NewsId") > 0 %>' CssClass="actions">
                        <a data-id='<%# Eval("NewsId") %>' onclick='ShowEditForm(this.dataset.id);return false;' class="button" >Редактировать</a>
                        <asp:LinkButton ID="lbDelete" runat="server" Text="Удалить" OnClientClick="return confirm('Действительно удалить?');" CssClass="button" CommandArgument='<%# Eval("NewsId") %>' CommandName="Delete" />
                    </asp:Panel>
                </header>
                <article data-content='<%# Eval("NewsId") %>'>
                    <%# Eval("Content") %>
                </article>
                <footer class="news-footer">
                    Добавлено: <span class="author"><%# Eval("Author") %></span><span class="time"><%# Eval("CreatedDate","{0:yyyy-MM-dd HH:mm:ss}") %></span>
                </footer>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
    <%--<ul class="news-list">
        <li class="news">
            <article class="news-main">
                <header class="news-header">
                    <h2>This is a news</h2>
                </header>
                   
                <div class="news-content">
                    <figure class="news-image">
                        <img  />
                    </figure>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                </div>

                <footer class="news-footer">
                    Posted today
                </footer>
            </article>
        </li>
        <li class="news">
            <article class="news-main">
                <header class="news-header">
                    <h2>This is a news</h2>
                </header>
                   
                <div class="news-content">
                    <figure class="news-image">
                        <img  />
                    </figure>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                </div>

                <footer class="news-footer">
                    Posted today
                </footer>
            </article>
        </li>
        <li  class="news">
            <article class="news-main">
                <header class="news-header">
                    <h2>This is a news</h2>
                </header>
                   
                <div class="news-content">
                    <figure class="news-image">
                        <img  />
                    </figure>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                </div>

                <footer class="news-footer">
                    Posted today
                </footer>
            </article>
        </li>
        <li class="news">
            <article class="news-main">
                <header class="news-header">
                    <h2>This is a news</h2>
                </header>
                   
                <div class="news-content">
                    <figure class="news-image">
                        <img  />
                    </figure>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                    <p>Pam-param-pam-pam</p>
                </div>

                <footer class="news-footer">
                    Posted today
                </footer>
            </article>
        </li>
    </ul>--%>
</asp:Content>
