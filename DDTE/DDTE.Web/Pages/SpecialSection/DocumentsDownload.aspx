<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="DocumentsDownload.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.DocumentsDownload" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Документы</h2>
    
    <ul class="documents-main">
        <li>
            <span>Документы на осуществление образовательной деятельности:</span>
            <ctr:DocumentList ID="dlEducation" runat="server" Category="Documents" />
        </li>
        <li>
            <span>Локальные нормативные акты:</span>
            <ctr:DocumentList ID="DocumentList1" runat="server" Category="Documents\LocalActs" />
            <ul class="documents-inner">
                <li><span>Планы:</span>
                    <ctr:DocumentList ID="dlPlans" runat="server" Category="Documents\LocalActs\Plans" />
                </li>
                <li><span>Правила:</span>
                    <ctr:DocumentList ID="dlRules" runat="server" Category="Documents\LocalActs\Rules" />
                </li>
                <li><span>Инструкции:</span>
                    <ctr:DocumentList ID="dlInstructions" runat="server" Category="Documents\LocalActs\Instructions" />
                </li>
                <li><span>Положения:</span>
                    <ctr:DocumentList ID="dlThesises" runat="server" Category="Documents\LocalActs\Thesises" />
                </li>
            </ul>
        </li>
        <li>
            <span>Отчёты, доклады, показатели, результаты самообследования:</span>
            <ctr:DocumentList ID="dlReports" runat="server" Category="Documents\Reports" />
        </li>
        <li>
            <span>Документы о порядке оказания платных образовательных услуг:</span>
            <ctr:DocumentList ID="dlPaidServices" runat="server" Category="Documents\PaidServices" />
        </li>
        <li>
            <span>Материалы проверок:</span>
            <ctr:DocumentList ID="dlRevisions" runat="server" Category="Documents\Revisions" />
        </li>
    </ul>
</asp:Content>
