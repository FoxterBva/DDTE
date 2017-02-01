<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.Master" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="DDTE.Web.Pages.Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
    <script src="/Scripts/angular.min.js"></script>
    <link href="/Content/themes/unions.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Наши объединения</h2>

    <asp:Literal ID="ltlMessage" runat="server" EnableViewState="false" />

    <div data-ng-app="ddteUnionApp">
        <div data-ng-controller="UnionController" >
            <div data-ng-show="DisplayLoading" class="union-loading" data-ng-cloak>LOADING!!!</div>
            <input id="btnAddUnion" runat="server" type="button" class="button" value="Добавить Новое Объединение" data-ng-click="EditUnion(0)" data-ng-show="!DisplayEdit" />
            <div class="union-edit" data-ng-show="DisplayEdit" data-ng-cloak>
                <h3>Редактирование Объединения</h3>
                <div>Название: <input type="text" data-ng-model="CurrentUnion.Name" /></div>
                <div>Описание: <input type="text" data-ng-model="CurrentUnion.Description" /></div>
                <div data-ng-repeat="up in CurrentUnion.UnionPrograms" >
                    <section class="union-program">
                        <fieldset>
                            <legend style="font-weight: bold;">Образовательная программа:</legend>
                            <div style="width: 810px;">
                                <div class="row">
                                    <div class="label">Название</div>
                                    <div class="field"><input type="text" data-ng-model="up.Name" /></div>
                                </div>
                                <div class="row">
                                    <div class="label">Заголовок</div>
                                    <div class="field"><input type="text" data-ng-model="up.Title" /></div>
                                </div>
                                <div class="row">
                                    <div class="label">Направленность дополнительной общеобразовательной программы</div>
                                    <div class="field"><input type="text" data-ng-model="up.Direction" /></div>
                                </div>
                                <div class="row">
                                    <div class="label">Направление образовательной деятельности</div>
                                    <div class="field"><input type="text" data-ng-model="up.EducationDirection" /></div>
                                </div>
                                <div class="row">
                                    <div class="label">Цель</div>
                                    <div class="field"><textarea rows="2" data-ng-model="up.Goal" ></textarea></div>
                                </div>
                                <div class="row">
                                    <div class="label">Образовательные задачи</div>
                                    <div class="field"><textarea rows="3" data-ng-model="up.EducationTasks" ></textarea></div>
                                </div>
                                <div class="row">
                                    <div class="label">Развивающие задачи</div>
                                    <div class="field"><textarea rows="3" data-ng-model="up.DevelopingTasks" ></textarea></div>
                                </div>
                                <div class="row">
                                    <div class="label">Воспитательные задачи</div>
                                    <div class="field"><textarea rows="3" data-ng-model="up.EducativeTasks" ></textarea></div>
                                </div>
                                <div class="row">
                                    <div class="label">Срок реализации программы</div>
                                    <div class="field"><input type="text" data-ng-model="up.Duration" /></div>
                                </div>
                                <div class="row">
                                    <div class="label">Возраст детей</div>
                                    <div class="field"><input type="text" data-ng-model="up.Age" /></div>
                                </div>
                                <div class="row">
                                    <div class="label">Условия приема детей</div>
                                    <div class="field"><textarea rows="2" data-ng-model="up.AcceptConditions" ></textarea></div>
                                </div>
                                <div>Расписание: </div>
                                <table class="up-schedule-edit">
                                    <tr>
                                        <th class="year">Год обучения</th>
                                        <th class="duration">Продолжительность 1 занятия (1час)</th>
                                        <th class="hrs-day">Количество часов в день</th>
                                        <th class="hrs-week">Количество часов в неделю</th>
                                        <th class="hrs-year">Количество часов в год</th>
                                        <th class="lessons">Кратность занятий</th>
                                        <th></th>
                                    </tr>
                                    <tr data-ng-repeat="sch in up.Schedule" >
                                        <td><input type="text" data-ng-model="sch.Year" /></td>
                                        <td><input type="text" data-ng-model="sch.LessonDuration" /></td>
                                        <td><input type="text" data-ng-model="sch.HoursDay" /></td>
                                        <td><input type="text" data-ng-model="sch.HoursWeek" /></td>
                                        <td><input type="text" data-ng-model="sch.HoursYear" /></td>
                                        <td><input type="text" data-ng-model="sch.LessonPerWeek" /></td>
                                        <td><a class="link-button" data-ng-click="DeleteSchedule($parent.$index, $index)">Удалить</a></td>
                                    </tr>
                                </table>
                                <input type="button" class="button" value="Добавить строку" data-ng-click="AddEmptySchedule($index)" />
                                <div style="margin-top: 10px;">Достижения: </div>
                                <table class="up-achievements-edit">
                                    <tr>
                                        <th class="name">Название мероприятия</th>
                                        <th class="date">Сроки</th>
                                        <th class="participants">Участники и Результаты</th>
                                        
                                        <th></th>
                                    </tr>
                                    <tr data-ng-repeat="ach in up.Achievements" >
                                        <td><textarea rows="2" data-ng-model="ach.Name" ></textarea></td>
                                        <td><textarea rows="2" data-ng-model="ach.Date" ></textarea></td>
                                        <td>
                                            <table class="up-ach-partisipants-edit">
                                                <tr>
                                                    <th>Имя</th>
                                                    <th>Результат</th>
                                                    <th></th>
                                                </tr>
                                                <tr data-ng-repeat="part in ach.Participants">
                                                    <td><input type="text" data-ng-model="part.ParticipantName" /></td>
                                                    <td><input type="text" data-ng-model="part.Result" /></td>
                                                    <td><a class="link-button" data-ng-click="DeleteParticipant($parent.$parent.$index, $parent.$index, $index)" title="Удалить участника">Удалить</a></td>
                                                </tr>
                                            </table>
                                            <a class="link-button" data-ng-click="AddParticipant($parent.$index, $index)">Добавить Участника</a>
                                        </td>
                                        <td><a class="link-button" data-ng-click="DeleteAchievement($parent.$index, $index)" title="Удалить мероприятие">Удалить</a></td>
                                    </tr>
                                </table>
                                <input type="button" class="button" value="Добавить строку" data-ng-click="AddEmptyAchievement($index)" title="Добавляет пустое достижение к списку достижений" />
                                <%--<input type="button" class="button" value="Добавить копию последней строки" data-ng-click="AddAchievementCopy($index, up.Achievements.length - 1)" title="Добавляет достижение к списку достижений с заполненным названием и сроком из последнего достижения в списке." />--%>
                            </div>
                        </fieldset>
                    </section>
                </div> <!-- up -->
                <input type="button" class="button" value="{{AddUPButtonText}}" data-ng-click="AddEmptyUnionProgram()" />
                <hr />
                <input type="button" class="button" value="СОХРАНИТЬ ОБЪЕДИНЕНИЕ" data-ng-click="SaveUnion()" />
                <input type="button" class="button" value="ОТМЕНА" data-ng-click="CancelEdit()" />
            </div>
        

        <asp:Repeater ID="rptrUnions" runat="server" OnItemDataBound="rptrUnions_ItemDataBound">
            <HeaderTemplate>
                <ul class="unions">
            </HeaderTemplate>
            <ItemTemplate>
                <li>
                    <details>
                        <summary style="position: relative">
                            <h2 class="union-title">Объединение «<%# Eval("Name") %>»</h2>
                            <asp:Panel ID="pnlUnionActions" runat="server" CssClass="actions">
                                <input type="button" class="button" value="Редактировать" data-ng-click='EditUnion(<%# Eval("UnionId") %>)' />
                                <input type="button" class="button" value="Удалить" onclick="return confirm('Удалить объединение?');" data-ng-click='DeleteUnion(<%# Eval("UnionId") %>)' />
                            </asp:Panel>
                        </summary>
                        <section class="union-content">
                            <p><%# Eval("Description") %></p>
                            <asp:Repeater ID="rptrUnionPrograms" runat="server">
                                <ItemTemplate>
                                    <h3 class="up-title"><%# Eval("Title") %> (<span class="up-name"><%# Eval("Name")%></span>)</h3>
                                    <ol class="up-list">
                                        <li>
                                            <span class="label">Направленность дополнительной общеобразовательной программы: </span>
                                            <span class="info"><%# Eval("Direction")%></span>
                                        </li>
                                        <li>
                                            <span class="label">Направление образовательной деятельности: </span>
                                            <span class="info"><%# Eval("EducationDirection")%></span>
                                        </li>
                                        <li>
                                            <span class="label">Цель дополнительной общеобразовательной программы: </span>
                                            <span class="info"><%# Eval("Goal")%></span>
                                        </li>
                                        <li>
                                            <span class="label">Задачи: </span>
                                            <ul class="up-tasks">
                                                <li>
                                                    <span class="up-task-title">образовательные:</span>
                                                    <div><%# ((string)Eval("EducationTasks") ?? String.Empty).Replace("\n", "</div><div>") %></div>
                                                    <span class="up-task-title">развивающие:</span>
                                                    <div><%# ((string)Eval("DevelopingTasks") ?? String.Empty).Replace("\n", "</div><div>") %></div>
                                                    <span class="up-task-title">воспитательные:</span>
                                                    <div><%# ((string)Eval("EducativeTasks") ?? String.Empty).Replace("\n", "</div><div>") %></div>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            <span class="label">Срок реализации программы: </span>
                                            <span class="info"><%# Eval("Duration")%></span>
                                        </li>
                                        <li>
                                            <span class="label">Возраст детей: </span>
                                            <span class="info"><%# Eval("Age")%></span>
                                        </li>
                                        <li>
                                            <span class="label">Режим занятий по программе: </span>
                                            <asp:Repeater ID="rptrUnionSchedule" runat="server">
                                                <HeaderTemplate>
                                                    <table class="up-schedule">
                                                        <tr>
                                                            <th class="year">Год обучения</th>
                                                            <th class="duration">Продолжительность 1 занятия (1 часа)</th>
                                                            <th class="hrs-day">Количество часов в день</th>
                                                            <th class="hrs-week">Количество часов в неделю</th>
                                                            <th class="hrs-year">Количество часов в год</th>
                                                            <th class="lessons">Кратность занятий</th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("Year") %></td>
                                                        <td><%# Eval("LessonDuration") %></td>
                                                        <td><%# Eval("HoursDay") %></td>
                                                        <td><%# Eval("HoursWeek") %></td>
                                                        <td><%# Eval("HoursYear") %></td>
                                                        <td><%# Eval("LessonPerWeek") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </li>
                                        <li>
                                            <span class="label">Условия приёма детей: </span>
                                            <span class="info"><%# Eval("AcceptConditions")%></span>
                                        </li>
                                        <li>
                                            <span class="label">Наши достижения: </span>
                                            <asp:Repeater ID="rptrUnionAchievements" runat="server">
                                                <HeaderTemplate>
                                                    <table class="up-achievements">
                                                        <tr>
                                                            <th class="name">Название мероприятия</th>
                                                            <th class="date">Сроки</th>
                                                            <th class="participants-results">Участники и Результат</th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><div><%# ((string)Eval("Name")?? String.Empty).Replace("\n", "</div><div>") %></div></td>
                                                        <td><%# Eval("Date") %></td>
                                                        <td>
                                                                <%--<span class="grp-record"></sp><%# ((string)Eval("Participant") ?? String.Empty).Replace("\n", "</span><span class='grp-record'>") %></span>
                                                                <span class="grp-record"><%# ((string)Eval("Result") ?? String.Empty).Replace("\n", "</span><span class='grp-record'>") %></span>--%>
                                                            <asp:Repeater ID="rptrUnionAchievementParticipants" runat="server">
                                                                <HeaderTemplate><table class="up-ach-participants"></HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <tr>
                                                                        <td><%# Eval("ParticipantName") %></td>
                                                                        <td><%# Eval("Result") %></td>
                                                                    </tr>
                                                                </ItemTemplate>
                                                                <FooterTemplate></table></FooterTemplate>
                                                            </asp:Repeater>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                        </li>
                                    </ol>
                                </ItemTemplate>
                            </asp:Repeater>
                        </section>
                    </details>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>

        </div>
    </div>

    <script src="/Scripts/Unions/app.js"></script>
    <script src="/Scripts/Unions/unionService.js"></script>
    <script src="/Scripts/Unions/unionController.js"></script>
</asp:Content>
