<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PhotoViewer.ascx.cs" Inherits="DDTE.Web.Controls.PhotoViewer" %>

<div><asp:LinkButton ID="lbAddAlbum" runat="server">Добавить альбом</asp:LinkButton></div>

<asp:Repeater ID="rptrPhotoItems" runat="server" OnItemCommand="rptrAlbums_ItemCommand" OnItemDataBound="rptrPhotoItems_ItemDataBound" >
    <ItemTemplate>
        <asp:Panel ID="pnlAlbum" runat="server" CssClass="photo-item">
            <asp:LinkButton ID="lbAlbum" runat="server" class="photo-album" CommandName="SelectAlbum" CommandArgument='<%# Eval("Id") %>'>
                <div class="title"><%# Eval("Title") %></div>
                <div class="descr"><%# Eval("Description") %></div>
            </asp:LinkButton>
        </asp:Panel>
        <asp:Panel ID="pnlPhoto" runat="server" CssClass="photo-item">
            <div class="photo-image-container">
                <a class="img-link" href="#"><span style=""></span><img id="imgPhoto" runat="server" src="#" class="photo-image"  /></a>
            </div>
            <div class="img-title"><%# Eval("Title") %></div>
            <asp:Panel ID="pnlImageActions" runat="server" class="img-actions">
                <asp:LinkButton ID="lblEdit" runat="server">Edit</asp:LinkButton>
                <asp:LinkButton ID="lbDelete" runat="server" OnClientClick="return confirm('Delete?')" CommandName="Delete" CommandArgument='<%# Eval("Id") %>'>Delete</asp:LinkButton>
            </asp:Panel>
        </asp:Panel>
    </ItemTemplate>
</asp:Repeater>