<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PhotoViewer.ascx.cs" Inherits="DDTE.Web.Controls.PhotoViewer" %>

<asp:Repeater ID="rptrPhotoItems" runat="server" OnItemCommand="rptrAlbums_ItemCommand" OnItemDataBound="rptrPhotoItems_ItemDataBound" >
    <ItemTemplate>
        <asp:Panel ID="pnlAlbum" runat="server" CssClass="photo-item">
            <asp:LinkButton ID="lbAlbum" runat="server" class="photo-placeholder" CommandName="SelectAlbum" CommandArgument='<%# Eval("Id") %>'><%# Eval("Title") %></asp:LinkButton>
        </asp:Panel>
        <asp:Panel ID="pnlPhoto" runat="server" CssClass="photo-item">
            <div class="photo-image-container">
                <a class="img-link" href="#"><span style=""></span><img id="imgPhoto" runat="server" src="#" class="photo-image"  /></a></div>
        </asp:Panel>
    </ItemTemplate>
</asp:Repeater>