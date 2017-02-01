<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BlindPanel.ascx.cs" Inherits="DDTE.Web.Controls.BlindPanel" %>

<div>
    <div class="blnd-pnl-toggler" style="" onclick="$(this).next().slideToggle()" title="Настройки для слабовидящих">
        <img src="/Images/blind-version.png" class="blind-visible" />
    </div>
    <asp:Panel ID="pnlBlind" runat="server" CssClass="blind-panel" style="display: none">
        <asp:Panel ID="pnlControls" runat="server" style="background-color: white !important; color: black !important; height: 100%">
            Размер шифта:
            <asp:LinkButton ID="btnSmallText" runat="server" CssClass="blind-btn blnd-small" ToolTip="Малый размер шрифта" OnClick="btnSmallText_Click"></asp:LinkButton>
            <asp:LinkButton ID="btnMediumText" runat="server" CssClass="blind-btn blnd-med" ToolTip="Средний размер шрифта" OnClick="btnMediumText_Click"></asp:LinkButton>
            <asp:LinkButton ID="btnLargeText" runat="server" CssClass="blind-btn blnd-large" ToolTip="Большой размер шрифта" OnClick="btnLargeText_Click"></asp:LinkButton>
            
            Цвет Фона:
            <asp:LinkButton ID="btnBlackWhite" runat="server" CssClass="blind-btn blnd-blackonwhite" ToolTip="Черный на белом" OnClick="btnBlackWhite_Click"></asp:LinkButton>
            <asp:LinkButton ID="btnWhiteBlack" runat="server" CssClass="blind-btn blnd-whiteonblack" ToolTip="Белый на черном" OnClick="btnWhiteBlack_Click"></asp:LinkButton>
            <asp:LinkButton ID="btnStandardColor" runat="server" CssClass="blind-btn blnd-default" ToolTip="Обычный фон" OnClick="btnStandardColor_Click"></asp:LinkButton>
        </asp:Panel>
    </asp:Panel>
</div>
