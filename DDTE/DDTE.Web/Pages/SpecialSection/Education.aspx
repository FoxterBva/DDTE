<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.Education" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Образование</h2>
    <p>Общая информация: ДДТ «Эврика» осуществляет образовательный процесс по 4 направленностям:</p>
    <ul style="list-style: none">
        <li>- художественно-эстетическая</li>
        <li>- социально-педагогическая</li>
        <li>- культурологическая</li>
        <li>- военно-патриотическая</li>
    </ul>
    <p>Образование осуществляется на русском языке.</p>

    <section class="education-docs">
        <p>Образовательная программа МБОУ ДОД «Дом детского творчества «Эврика»</p>
        <ctr:DocumentList ID="documentList" runat="server" Category="Education" />
        <div class="education-parts">
            <p>Общеобразовательные программы, информационные карты к образовательным программам </p>
            <div class="education-parts-docs">
                <h4>Декоративно-прикладное творчество</h4>
                <ctr:DocumentList ID="dlDecorativeCrafts" runat="server" Category="Education\DecorativeCrafts" />
                <h4>Изобразительное искусство</h4>
                <ctr:DocumentList ID="dlFineArts" runat="server" Category="Education\FineArts" />
                <h4>Хореография</h4>
                <ctr:DocumentList ID="dlChoreography" runat="server" Category="Education\Choreography" />
                <h4>Вокал</h4>
                <ctr:DocumentList ID="dlVocals" runat="server" Category="Education\Vocals" />
                <h4>Театр</h4>
                <ctr:DocumentList ID="dlTheater" runat="server" Category="Education\Theater" />
            </div>
        </div>
    </section>
</asp:Content>
