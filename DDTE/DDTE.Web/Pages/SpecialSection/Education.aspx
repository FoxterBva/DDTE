<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="Education.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.Education" %>

<%@ Register Src="~/Controls/DocumentsList.ascx" TagName="DocumentList" TagPrefix="ctr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Образование</h2>
    <p style="margin-bottom: 15px;"><strong>Общая информация:</strong></p> 
    
    <p class="paragraph">МБОУ ДОД «Дом детского творчества «Эврика» создано для выполнения работ, оказания услуг в целях обеспечения реализации предусмотренных федеральными законами, нормативными правовыми актами Республики Бурятия, муниципального образования «город Северобайкальск», полномочий муниципального образования «город Северобайкальск» <strong>в сфере дополнительного образования детей.</strong></p>
    
    <p class="paragraph">В ДДТ «Эврика» принимаются <strong>дети</strong> преимущественно <strong>с 6 до 18 лет</strong>. Для зачисления, обучающегося необходимо предоставить заявление о приеме ребенка от его родителей (законных представителей). </p>

    <p class="paragraph">ДДТ «Эврика» реализует дополнительные общеобразовательные – дополнительные общеразвивающие программы следующих направленностей:</p>
    <ul style="list-style: none" class="paragraph">
        <li>- художественно-эстетической</li>
        <li>- культурологической</li>
        <li>- социально-педагогической</li>
        <li>- краеведческой</li>
        <li>- военно-патриотическая</li>
    </ul>

    <p class="paragraph"><strong>Продолжительность обучения</strong> в ДДТ «Эврика» определяется нормативным сроком освоения реализуемых дополнительных общеобразовательных программ, степенью освоения обучающимися программного содержания, характером деятельности, возрастом обучающихся. </p>

    <p class="paragraph"><strong>Нормативный срок освоения программ:</strong></p>
    <ul style="list-style: none" class="paragraph">
        <li>- художественно-эстетической направленности - до 6 лет</li>
        <li>- культурологической направленности - до 3 лет</li>
        <li>- социально-педагогической направленности - до 3 лет</li>
        <li>- краеведческой - до 2 лет</li>
        <li>- военно-патриотической - до 2 лет</li>
        <li>Образование осуществляется на русском языке</li>
    </ul>

    <section class="education-docs">
        <h4>Образовательная программа МБОУ ДОД «Дом детского творчества «Эврика»</h4>
        <ctr:DocumentList ID="documentList" runat="server" Category="Education" />
        <h4>ДОКУМЕНТЫ РЕГЛАМЕНТИРУЮЩИЕ ОБРАЗОВАТЕЛЬНУЮ ДЕЯТЕЛЬНОСТЬ В ДДТ «ЭВРИКА»</h4>
        <ctr:DocumentList ID="dlEducationReglament" runat="server" Category="EducationReglament" />
        <div class="education-parts">
            <h4>ДОПОЛНИТЕЛЬНЫЕ ОБЩЕОБРАЗОВАТЕЛЬНЫЕ ПРОГРАММЫ – ДОПОЛНИТЕЛЬНЫЕ ОБЩЕРАЗВИВАЮЩИЕ ПРОГРАММЫ ПО НАПРАВЛЕННОСТЯМ</h4>
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
                <h4>Социально-педагогическая направленность</h4>
                <ctr:DocumentList ID="dlSocPed" runat="server" Category="Education\SocPed" />
                <h4>Военно-патриотическая направленность</h4>
                <ctr:DocumentList ID="dlMilitaryPatr" runat="server" Category="Education\MilitaryPatr" />
            </div>
        </div>
    </section>
</asp:Content>
