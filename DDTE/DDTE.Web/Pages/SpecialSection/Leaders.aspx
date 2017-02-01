<%@ Page Title="" Language="C#" MasterPageFile="~/SpecialSection.master" AutoEventWireup="true" CodeBehind="Leaders.aspx.cs" Inherits="DDTE.Web.Pages.SpecialSection.Leaders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <script src="/Scripts/angular.min.js"></script>
    <link href="/Content/themes/staff.css" rel="stylesheet" />
    
    <h2>Руководство. Педагогический (научно-педагогический) состав</h2>

    <asp:Literal ID="ltlMessage" runat="server" EnableViewState="false" />

    <asp:Panel ID="pnlOld" runat="server" Visible="false">

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
                <td class="row-title">Повышение квалификации</td>
                <td class="row-value" colspan="3"><span><%# ((string)Eval("QualificationCourses")).Replace(Environment.NewLine, "</span><span>") %></span></td>
            </tr>
            <tr class="divider"><td colspan="4"><hr /></td></tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    
    </asp:Panel>
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

    <div data-ng-app="ddteStaffApp">
        <div data-ng-controller="StaffController" >
            <a data-ng-show="Data.CanEdit" class="button" data-ng-click="EditDetails(null)" >Добавить Сотрудника</a>
            <div style="padding-left: 5px; padding-bottom: 5px; margin-bottom: 5px; margin-top: 5px; border-bottom: 1px solid #CCCCCC">Поиск по сотрудникам: <input data-ng-model="Data.FilterText" /></div>
            <table class="staff-list" style="width: 100%">
                <tr>
                    <td style="width: 120px"></td>
                    <td style="width: 10px"></td>
                    <td style="width: 250px"></td>
                    <td></td>
                </tr>
                <tr data-ng-repeat-start="empl in Data.Employees | filter : emplFilter">
                    <td colspan="4" class="row-name">
                        <span class="staff-name" data-ng-click="DisplayDetails(empl.StaffId)">{{ empl.Name }}</span>
                        <div class="actions" data-ng-show="Data.CanEdit">
                            <a class="button" data-ng-click="EditDetails(empl.StaffId)" >Редактировать</a>
                            <a class="button" data-ng-click="DeleteEmployee(empl)" >Удалить</a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <!-- Photo -->
                    <td colspan="2" rowspan="5" class="photo" data-ng-click="DisplayDetails(empl.StaffId)">
                        <img src='{{ empl.PhotoUrl }}' title='{{ empl.Name }}' style="max-height: 100px; cursor: pointer; margin-right: 15px;margin-top: 10px;" />
                    </td>
                    <td class="row-title">Должность</td>
                    <td class="row-value"><span>{{ empl.Position }} </span></td>
                </tr>
                <tr id="trLeader" runat="server">
                    <td class="row-title">Руководитель объединения</td><td class="row-value"><span>{{ empl.LeaderOf }} </span></td>
                </tr>
                <tr>
                    <td class="row-title">Общий / педагогический стаж</td><td class="row-value"><span> {{ empl.GeneralExperience }} / {{ empl.EducationExperience }}</span></td>
                </tr>
                <tr>
                    <td class="row-title">Контактный телефон</td><td class="row-value"><span>{{ empl.Phone }}</span></td>
                </tr>
                <tr >
                    <td class="row-title">e-mail</td><td class="row-value"><span>{{ empl.Email }}</span></td>
                </tr>
                <tr data-ng-repeat-end class="divider"><td colspan="4"><hr /></td></tr>
            </table>

            <div data-ng-show="Data.DisplayDetailsForm" ng-cloak class="ag-edit-form-overlay" ></div>
            <div data-ng-show="Data.DisplayDetailsForm" ng-cloak class="ag-edit-form" >
                <%--<div data-ng-show="Data.IsEditMode">
                    <fieldset class="staff-edit-form" style="margin: auto">
                        <legend>Информация</legend>
                        <!-- edit -->
                    
                        <div class="field-row">
                            <div class="field-title">Ф.И.О.</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.Name" /></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title" >Фото</div>
                            <div class="field-value">
                                <img class="photo-preview" src="{{ Data.ActiveEmployee.PhotoUrl  }}" />
                                <input id="photoFileSelector" type="file" data-ng-model="SelectedPhoto.File" />
                            </div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Должность</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.Position" /></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Квалификационная категория</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.Qualification" /></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Руководитель объединения</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.LeaderOf" /></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Образование</div>
                            <div class="field-value"><textarea data-ng-model="Data.ActiveEmployee.Education" rows="3" ></textarea></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Специальность</div>
                            <div class="field-value"><textarea data-ng-model="Data.ActiveEmployee.Speciality" rows="3" ></textarea></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Ученая степень, звание, награды</div>
                            <div class="field-value"><textarea data-ng-model="Data.ActiveEmployee.Degree" rows="3" ></textarea></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Повышение квалификации</div>
                            <div class="field-value"><textarea data-ng-model="Data.ActiveEmployee.QualificationCourses" rows="3" ></textarea></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Общий стаж работы</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.GeneralExperience" /></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Стаж педагогической работы</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.EducationExperience" /></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">Контактный телефон</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.Phone" /></div>
                        </div>
                        <div class="field-row">
                            <div class="field-title">E-mail</div>
                            <div class="field-value"><input type="text" data-ng-model="Data.ActiveEmployee.Email" /></div>
                        </div>

                        <a class="button"  data-ng-click="SubmitEmployee()" >Добавить/Обновить</a>
                        <a class="button" data-ng-click="CloseDetails()" >Отмена</a>
                    </fieldset>
                </div>--%>

                <!-- display & edit -->
                <div name="fDetails" style="padding: 10px;">
                    <table class="staff-list details" style="width: 100%" >
                        <tr>
                            <td colspan="3" class="row-name">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Name }}</span>
                                <div data-ng-show="Data.IsEditMode" >ФИО <input type="text" data-ng-model="Data.ActiveEmployee.Name" /></div>
                            </td>
                        </tr>
                        <tr>
                            <!-- Photo -->
                            <td rowspan="11" class="photo" style="width: 350px;">
                                <img data-ng-src="{{ Data.ActiveEmployee.PhotoUrl | fullImg:'.full.jpg' }}"  />
                            </td>
                            <td class="row-title" style="width: 250px;">Должность</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Position }}</span>
                                <input data-ng-show="Data.IsEditMode" type="text" data-ng-model="Data.ActiveEmployee.Position" />
                            </td>
                        </tr>
                        <tr id="tr1" runat="server">
                            <td class="row-title">Руководитель объединения</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.LeaderOf }}</span>
                                <input data-ng-show="Data.IsEditMode" type="text" data-ng-model="Data.ActiveEmployee.LeaderOf" />
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Общий стаж работы</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.GeneralExperience }}</span>
                                <input data-ng-show="Data.IsEditMode" type="text" data-ng-model="Data.ActiveEmployee.GeneralExperience" />
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Стаж педагогической работы</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.EducationExperience }}</span>
                                <input data-ng-show="Data.IsEditMode" type="text" data-ng-model="Data.ActiveEmployee.EducationExperience" />
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Контактный телефон</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Phone }}</span>
                                <input data-ng-show="Data.IsEditMode" type="text" data-ng-model="Data.ActiveEmployee.Phone" />
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">e-mail</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Email }}</span>
                                <input data-ng-show="Data.IsEditMode" type="text" data-ng-model="Data.ActiveEmployee.Email" />
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Квалификационная категория</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Qualification }}</span>
                                <input data-ng-show="Data.IsEditMode" type="text" data-ng-model="Data.ActiveEmployee.Qualification" />
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Образование</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Education }}</span>
                                <textarea data-ng-show="Data.IsEditMode" data-ng-model="Data.ActiveEmployee.Education" rows="3" ></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Специальность</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Speciality }}</span>
                                <textarea data-ng-show="Data.IsEditMode" data-ng-model="Data.ActiveEmployee.Speciality" rows="3" ></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Ученая степень, звание, награды</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.Degree }}</span>
                                <textarea data-ng-show="Data.IsEditMode" data-ng-model="Data.ActiveEmployee.Degree" rows="3" ></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td class="row-title">Повышение квалификации</td>
                            <td class="row-value">
                                <span data-ng-hide="Data.IsEditMode">{{ Data.ActiveEmployee.QualificationCourses }}</span>
                                <textarea data-ng-show="Data.IsEditMode" data-ng-model="Data.ActiveEmployee.QualificationCourses" rows="3" ></textarea>
                            </td>
                        </tr>
                    </table>

                    <%--<div class="field-row">
                        <div class="field-value">{{ Data.ActiveEmployee.Name }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Фото</div>
                        <div class="field-value">
                            <img data-ng-src="{{ Data.ActiveEmployee.PhotoUrl }}" />
                        </div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Должность</div>
                        <div class="field-value">{{ Data.ActiveEmployee.Position }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Квалификационная категория</div>
                        <div class="field-value">{{ Data.ActiveEmployee.Qualification }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Руководитель объединения</div>
                        <div class="field-value">{{ Data.ActiveEmployee.LeaderOf }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Образование</div>
                        <div class="field-value">{{ Data.ActiveEmployee.Education }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Специальность</div>
                        <div class="field-value">{{ Data.ActiveEmployee.Speciality }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Ученая степень, звание, награды</div>
                        <div class="field-value">{{ Data.ActiveEmployee.Degree }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Повышение квалификации</div>
                        <div class="field-value">{{ Data.ActiveEmployee.QualificationCourses }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Общий стаж работы</div>
                        <div class="field-value">{{ Data.ActiveEmployee.GeneralExperience }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Стаж педагогической работы</div>
                        <div class="field-value">{{ Data.ActiveEmployee.EducationExperience }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">Контактный телефон</div>
                        <div class="field-value">{{ Data.ActiveEmployee.Phone }}</div>
                    </div>
                    <div class="field-row">
                        <div class="field-title">E-mail</div>
                        <div class="field-value">{{ Data.ActiveEmployee.Email }}</div>
                    </div>--%>

                    <div style="float: right; margin-bottom: 10px; margin-right: 10px;">
                        <a data-ng-show="Data.CanEdit && !Data.IsEditMode" class="button" data-ng-click="SwitchToEdit(empl.StaffId)" >Редактировать</a>
                        <a data-ng-show="Data.CanEdit && Data.IsEditMode" class="button"  data-ng-click="SubmitEmployee()" >Добавить/Обновить</a>
                        <a class="button" data-ng-click="CloseDetails()"  >Закрыть</a>
                    </div>
                </div>
        </div>
    </div>
    </div>
    <script src="/Scripts/Staff/app_staff.js"></script>
    <script src="/Scripts/Staff/StaffService.js"></script>
    <script src="/Scripts/Staff/StaffController.js"></script>
</asp:Content>
