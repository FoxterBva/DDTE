<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="Leaders.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.Leaders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <style type="text/css">
        .staff-list
        {
            
        }

        .staff-list td
        {
            
        }

        .staff-list .photo
        {
            vertical-align: middle;
            text-align: center;
        }

        .staff-list .photo img
        {
            max-width: 200px;
            max-height: 200px;
        }

        .staff-list .row-name
        {
            padding-left: 5px;
            position: relative;
        }

        .staff-list .row-name span
        {
            text-transform: uppercase;
            font-weight: bold;
        }

        .staff-list .row-name .actions
        {
            position: absolute;
            right: 10px;
            top: 0px;
        }

        .staff-list .row-title
        {
            padding: 5px 2px 5px 2px;
            font-weight: bold;
            vertical-align: middle;
            /*border: 1px solid #6BDDE2*/
        }

        .staff-list .row-value
        {
            padding: 5px 2px 5px 2px;
            vertical-align: middle;
            /*border: 1px solid #6BDDE2*/
        }

        .staff-list .row-value span
        {
            display: block; 
        }

        .staff-list .divider td
        {
            height: 35px;
        }
        .staff-edit-form
        {
            width: 500px;
            border: 1px solid;
            padding: 10px;
        }

        .staff-edit-form .field-title
        {
            
            padding-right: 5px;
        }

        .staff-edit-form .field-value
        {
            
        }

        .staff-edit-form .field-value .photo-preview
        {
            max-width: 150px;
            max-height: 120px;
        }

        .staff-edit-form .field-title,
        .staff-edit-form .field-value
        {
            
        }

        .staff-edit-form .field-value input[type='text'],
        .staff-edit-form .field-value textarea
        {
            width: 95%;
        }
    </style>

    <h2>Руководство. Педагогический (научно-педагогический) состав</h2>

    <asp:Literal ID="ltlMessage" runat="server" EnableViewState="false" />

    <asp:Panel ID="pnlEditForm" runat="server" Visible="false">
        <fieldset class="staff-edit-form">
            <legend><asp:Label ID="lblEditFormTitle" runat="server"></asp:Label></legend>
            <div class="field-row">
                <div class="field-title">Ф.И.О.</div>
                <div class="field-value"><asp:TextBox ID="tbFullName" runat="server" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Фото</div>
                <div class="field-value">
                    <asp:Image ID="imgPhoto" runat="server" CssClass="photo-preview" />
                    <asp:FileUpload ID="fuPhoto" runat="server" />
                    <asp:Button ID="btnUploadPhoto" runat="server" Text="Загрузить" OnClick="btnUploadPhoto_Click" />
                </div>
            </div>
            <div class="field-row">
                <div class="field-title">Должность</div>
                <div class="field-value"><asp:TextBox ID="tbPosition" runat="server" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Квалификационная категория</div>
                <div class="field-value"><asp:TextBox ID="tbQualification" runat="server" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Руководитель объединения</div>
                <div class="field-value"><asp:TextBox ID="tbLeaderOf" runat="server" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Образование</div>
                <div class="field-value"><asp:TextBox ID="tbEducation" runat="server" TextMode="MultiLine" Rows="3" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Специальность</div>
                <div class="field-value"><asp:TextBox ID="tbSpeciality" runat="server" TextMode="MultiLine" Rows="3" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Ученая степень, звание, награды</div>
                <div class="field-value"><asp:TextBox ID="tbDegree" runat="server" TextMode="MultiLine" Rows="3" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Повышение квалификации</div>
                <div class="field-value"><asp:TextBox ID="tbQualificationCourses" runat="server" TextMode="MultiLine" Rows="3" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Общий стаж работы</div>
                <div class="field-value"><asp:TextBox ID="tbGeneralExperience" runat="server" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Стаж педагогической работы</div>
                <div class="field-value"><asp:TextBox ID="tbEducationExperience" runat="server" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">Контактный телефон</div>
                <div class="field-value"><asp:TextBox ID="tbPhone" runat="server" /></div>
            </div>
            <div class="field-row">
                <div class="field-title">E-mail</div>
                <div class="field-value"><asp:TextBox ID="tbEmail" runat="server" /></div>
            </div>
            <asp:HiddenField ID="hfId" runat="server" />
            <asp:LinkButton ID="btnAdd" runat="server" Text="Добавить" CssClass="button" OnClick="btnAdd_Click" />
            <asp:LinkButton ID="btnUpdate" runat="server" Text="Обновить" CssClass="button" OnClick="btnUpdate_Click"  />
            <asp:LinkButton ID="btnCancel" runat="server" Text="Отмена"  CssClass="button" OnClick="btnCancel_Click" />
        </fieldset>
    </asp:Panel>

    <asp:LinkButton ID="lbAddStaff" runat="server" Text="Добавить Сотрудника" CssClass="button" OnClick="lbAddStaff_Click" />

    <asp:Repeater ID="rptrStaff" runat="server" OnItemCommand="rptrStaff_ItemCommand" OnItemDataBound="rptrStaff_ItemDataBound">
        <HeaderTemplate>
            <table class="staff-list">
        </HeaderTemplate>
        <ItemTemplate>
            <%--<tr>
                <td rowspan="11" class="photo"></td>
                <td colspan="2" class="row-name">
                    <span><%# Eval("Name") %></span>
                    <asp:Panel ID="pnlActions" runat="server" CssClass="actions">
                        <asp:LinkButton ID="btnEdit" runat="server" Text="Редактировать" CommandName="Edit" CommandArgument='<%# Eval("StaffId") %>' CssClass="button" ></asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" Text="Удалить" OnClientClick="return confirm('Действительно удалить эту запись?')" CommandName="Delete" CommandArgument='<%# Eval("StaffId") %>' CssClass="button" ></asp:LinkButton>
                    </asp:Panel>
                </td>
            </tr>
            <tr><td class="row-title">Должность</td><td class="row-value"><span><%# ((string)Eval("Position")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Квалификационная категория</td><td class="row-value"><span><%# ((string)Eval("Qualification")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Образование</td><td class="row-value"><span><%# ((string)Eval("Education")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Специальность</td><td class="row-value"><span><%# ((string)Eval("Speciality")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Ученая степень, звание, награды</td><td class="row-value"><span><%# ((string)Eval("Degree")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Повышение квалификации</td><td class="row-value"><span><%# ((string)Eval("QualificationCourses")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Общий стаж работы</td><td class="row-value"><span><%# ((string)Eval("GeneralExperience")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Стаж педагогической работы</td><td class="row-value"><span><%# ((string)Eval("EducationExperience")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">Контактный телефон</td><td class="row-value"><span><%# ((string)Eval("Phone")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr><td class="row-title">e-mail</td><td class="row-value"><span><%# ((string)Eval("Email")).Replace(Environment.NewLine, "</span><span>") %></span></td></tr>
            <tr class="divider"><td colspan="3"></td></tr>--%>
            <tr>
                <td style="width: 150px"></td>
                <td style="width: 100px"></td>
                <td style="width: 170px"></td>
                <td></td>
            </tr>
            <tr>
                
                <td colspan="4" class="row-name">
                    <span><%# Eval("Name") %></span>
                    <asp:Panel ID="pnlActions" runat="server" CssClass="actions">
                        <asp:LinkButton ID="btnEdit" runat="server" Text="Редактировать" CommandName="Edit" CommandArgument='<%# Eval("StaffId") %>' CssClass="button" ></asp:LinkButton>
                        <asp:LinkButton ID="btnDelete" runat="server" Text="Удалить" OnClientClick="return confirm('Действительно удалить эту запись?')" CommandName="Delete" CommandArgument='<%# Eval("StaffId") %>' CssClass="button" ></asp:LinkButton>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <!-- Photo -->
                <td colspan="2" rowspan="6" class="photo">
                    <asp:Image ID="ImgStaffPhoto" runat="server" ImageUrl='<%# Eval("PhotoUrl") %>' ToolTip='<%# Eval("Name") %>' />
                </td>
                <td class="row-title">Должность</td>
                <td class="row-value"><span><%# ((string)Eval("Position")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr id="trLeader" runat="server">
                <td class="row-title">Руководитель объединения</td><td class="row-value"><span><%# ((string)Eval("LeaderOf") ?? String.Empty).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Общий стаж работы</td><td class="row-value"><span><%# ((string)Eval("GeneralExperience")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Стаж педагогической работы</td><td class="row-value"><span><%# ((string)Eval("EducationExperience")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Контактный телефон</td><td class="row-value"><span><%# ((string)Eval("Phone")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">e-mail</td><td class="row-value"><span><%# ((string)Eval("Email")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Квалификационная категория</td>
                <td class="row-value" colspan="3"><span><%# ((string)Eval("Qualification")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Образование</td>
                <td class="row-value" colspan="3"><span><%# ((string)Eval("Education")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Специальность</td>
                <td class="row-value" colspan="3"><span><%# ((string)Eval("Speciality")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Ученая степень, звание, награды</td>
                <td class="row-value" colspan="3"><span><%# ((string)Eval("Degree")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr>
                <td class="row-title">Повышение квалификации</td><td class="row-value"><span><%# ((string)Eval("QualificationCourses")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr class="divider"><td colspan="4"><hr /></td></tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    
    <%--<section class="leader clearfix">
        <header class="leader-name">Вася Пупкин</header>
        <div class="leader-content clearfix">
            <figure class="leader-photo"></figure>
            Пам-пам-пам парам-пам-пам пам парам-пам-пам-пам-пам. Пам-пам-пам парам-пам-пам пам парам-пам-пам-пам-пам. Пам-пам-пам парам-пам-пам пам парам-пам-пам-пам-пам
        </div>
    </section>
    <section class="leader clearfix">
        <header class="leader-name">Вася Пупкин</header>
        <figure class="leader-photo"></figure>
        Пам-пам-пам парам-пам-пам пам парам-пам-пам-пам-пам. Пам-пам-пам парам-пам-пам пам парам-пам-пам-пам-пам. Пам-пам-пам парам-пам-пам пам парам-пам-пам-пам-пам
    </section>--%>
</asp:Content>
