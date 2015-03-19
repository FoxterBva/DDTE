<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PhotoViewer.ascx.cs" Inherits="DDTE.Web.Controls.PhotoViewer" %>

<asp:Repeater ID="rptrAlbums" runat="server" OnItemCommand="rptrAlbums_ItemCommand" Visible="false">
    <ItemTemplate>
        <asp:LinkButton ID="lbAlbum" runat="server" class="photo-placeholder" CommandName="SelectAlbum" CommandArgument='<%# Eval("Id") %>'><%# Eval("Name") %></asp:LinkButton>
    </ItemTemplate>
</asp:Repeater>

<asp:Repeater ID="rptrPhotos" runat="server" Visible="false">
    <ItemTemplate>
        <div class="photo-placeholder"><%# Eval("Name") %></div>
    </ItemTemplate>
</asp:Repeater>