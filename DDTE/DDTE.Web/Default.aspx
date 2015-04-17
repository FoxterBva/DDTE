<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DDTE.Web.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Новости</h2>

    <asp:Panel ID="pnlAddNews" runat="server">
        <asp:LinkButton ID="lbAddNews" runat="server" Text="Добавить новость" CssClass="button" OnClientClick="alert('пока не работает!'); return false;"></asp:LinkButton>
    </asp:Panel>

    <asp:Repeater ID="rptrNews" runat="server">
        <HeaderTemplate>
            <ul class="news-list">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="news">
                <header>
                    <h3>[<%# Eval("CreatedDate", "{0:yyyy-MM-dd}") %>] <%# Eval("Title") %></h3>
                    <asp:Panel ID="pnlActions" runat="server" Visible="<%# DDTE.Web.Helpers.SecurityHelper.CanEditNews() %>" CssClass="actions">
                        <asp:LinkButton ID="lbEdit" runat="server" Text="Редактировать" OnClientClick="alert('пока нельзя!'); return false;" CssClass="button" />
                        <asp:LinkButton ID="lbDelete" runat="server" Text="Удалить" OnClientClick="return confirm('Действительно удалить? (пока нельзя)');" CssClass="button" />
                    </asp:Panel>
                    
                </header>
                <article>
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
