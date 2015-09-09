<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DDTE.Web.Default" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
<%--    <link rel="stylesheet" href="Scripts/YellowText/stylesheets/style.css" type="text/css" media="all" />
    <link rel="stylesheet" href="Scripts/YellowText/stylesheets/yellow-text-default.css" type="text/css" media="all" />
    
    <script type="text/javascript" src="Scripts/YellowText/yellow-text.js"></script>--%>
    <script type="text/javascript" src="Scripts/TinyMCE/tinymce.min.js"></script>

    <script type="text/javascript">
        var newsContext = { isNew: true };

        function ShowEditForm(newsId) {
            newsContext.isNew = newsId == '0';

            //$('#editForm').css('position', 'fixed');
            var form = $('#editForm').show(100);
            var title = newsContext.isNew ? '' : $('span[data-title="' + newsId + '"]').html().trim();
            var content = newsContext.isNew ? '' : $('article[data-content="' + newsId + '"]').html().trim();
            var author = newsContext.isNew ? '' : $('span[data-author="' + newsId + '"]').html().trim();

            $('.tbContent', form).val(content);
            $('.tbTitle', form).val(title);
            $('.tbAuthor', form).val(author);
            tinyMCE.activeEditor.setContent(content);

            if (newsContext.isNew) {
                $('.lbSubmit', form).show();
                $('.lbUpdate', form).hide();
            } else
            {
                $('.lbSubmit', form).hide();
                $('.lbUpdate', form).show();
            }
        }

        function CloseEditForm()
        {
            $('#editForm').hide();
            $('.preview').hide();
            //$('#editForm').css('position', 'absolute');

            $('span[data-title="0"]').html('');
            $('article[data-content="0"]').html('');
            $('span[data-author="0"]').html('');
        }

        function ShowPreview() {
            $('.preview').show();
            var form = $('#editForm');

            $('span[data-title="0"]').html($('.tbTitle', form).val().trim());
            $('article[data-content="0"]').html(tinyMCE.activeEditor.getContent());
            $('span[data-author="0"]').html($('.tbAuthor', form).val().trim());
        }

        function PublishNews() {
            var form = $('#editForm');
            $('input[type=hidden]', form).val(newsContext.isNew);
            $('.tbContent').html(tinyMCE.activeEditor.getContent());
        }

        tinymce.init({
            selector: "textarea",
            plugins: [
                "advlist autolink lists link image charmap print preview anchor",
                "searchreplace visualblocks code fullscreen",
                "insertdatetime media table contextmenu paste"
            ],
            toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image"
        });

        function ToggleNews(newsId, btn) {
            var article = $('article[data-content="' + newsId + '"]');
            if (article.hasClass('news-short')) {
                article.switchClass('news-short', 'news-long', 400, 'easeOutCubic');
                $(btn).html('Свернуть...');
            }
            else {
                article.switchClass('news-long', 'news-short', 400, 'easeOutCubic');
                $(btn).html('Подробнее...');
            }
        }
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
            <asp:HiddenField ID="hfMode" runat="server" />
            <a class="button" onclick="ShowPreview();return false;" title="Предпросмотр новости">Предпросмотр</a>
            <asp:LinkButton ID="lbSubmit" runat="server" Text="Опубликовать" CssClass="button lbSubmit" OnClientClick="PublichNews()" OnClick="lbSubmit_Click" ToolTip="Опубликовать новость" />
            <asp:LinkButton ID="lbUpdate" runat="server" Text="Обновить" CssClass="button lbUpdate" OnClientClick="PublichNews()" OnClick="lbSubmit_Click" ToolTip="Обновить новость" />
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
                        <%# (int)Eval("NewsId") == 0 ? "[ <span class='preview'> ПРЕДПРОСМОТР </span> ]" : "" %>
                        <span data-title='<%# Eval("NewsId") %>'>
                            <%# HttpUtility.HtmlEncode((string)Eval("Title")) %>
                        </span>
                    </h3>
                    <asp:Panel ID="pnlActions" runat="server" Visible='<%# DDTE.Web.Helpers.SecurityHelper.CanEditNews() && (int)Eval("NewsId") > 0 %>' CssClass="actions">
                        <a data-id='<%# Eval("NewsId") %>' onclick='ShowEditForm(this.dataset.id);return false;' class="button" >Редактировать</a>
                        <asp:LinkButton ID="lbDelete" runat="server" Text="Удалить" OnClientClick="return confirm('Действительно удалить?');" CssClass="button" CommandArgument='<%# Eval("NewsId") %>' CommandName="Delete" />
                    </asp:Panel>
                </header>
                <div class="news-content">
                    <article data-content='<%# Eval("NewsId") %>' class='<%# (int)Eval("NewsId") == 0 ? "" : "news-short" %>'>
                        <%# Eval("Content") %>
                    </article>
                    <span style="position: absolute; right: 10px; bottom: -22px; display: block;cursor: pointer" onclick="ToggleNews(<%# Eval("NewsId") %>, this)">Подробнее...</span>
                </div>
                <footer class="news-footer">
                    Добавлено: <span data-author='<%# Eval("NewsId") %>' class="author"><%# Eval("Author") %></span><span class="time"><%# Eval("CreatedDate","{0:dd.MM.yyyy HH:mm:ss}") %></span>
                </footer>
            </li>
            <hr />
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
