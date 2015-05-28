<%@ Page Title="" Language="C#" MasterPageFile="~/MainRight.Master" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="DDTE.Web.Pages.Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeader" runat="server">
    <script src="/Scripts/angular.min.js"></script>

    <style type="text/css">
        .union-loading
        {
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
            opacity: 0.5;
            background-color: #ABABAB;
            z-index: 100;
        }

        .unions .union-title
        {
            display: inline;
            cursor: pointer;
        }

        .unions .actions
        {
            position: absolute;
            right: 5px;
            top: 0px;
        }

        .unions > li
        {
            margin-bottom: 10px;
        }

        .unions > li:hover
        {
            
        }

        .unions .union-content
        {
            margin-bottom: 25px;
        }

        .up-title
        {
            margin-bottom: 3px;
            margin-top: 15px;
        }

        .up-name
        {
            text-decoration: underline;
        }

        .up-list
        {
            margin-left: 30px;
        }

        .up-list .label
        {
            font-weight: bold;
        }

        .up-tasks .up-task-title
        {
            text-decoration: underline;
        }

        /* \/ edit -form \/ */
        .union-edit
        {
            padding: 10px;
            border: 1px solid;
        }

        .union-edit .union-program
        {
            padding: 10px;
            border: 1px solid;
            margin-top: 10px;
        }

        .union-edit input[type='text'],
        .union-edit .union-program .field input[type='text'],
        .union-edit .union-program .field textarea
        {
            width: 98%;
        }

        .up-schedule-edit,
        .up-achievements-edit
        {
            width: 100%;
        }

        .up-schedule-edit th,
        .up-schedule-edit td
        {
            border: 1px solid;
            padding: 2px;
            line-height: 1;
            text-align: center;
            vertical-align: middle;
        }

        .up-schedule-edit td input[type='text']
        {
            width: 98%;
        }

        .up-schedule-edit th { background-color: #6BE2E0; }
        .up-schedule-edit .year { }
        .up-schedule-edit .duration { }
        .up-schedule-edit .hrs-day { }
        .up-schedule-edit .hrs-week { }
        .up-schedule-edit .hrs-year { }
        .up-schedule-edit .lessons {  }

        .up-achievements-edit th,
        .up-achievements-edit td
        {
            border: 1px solid;
            padding: 2px;
            line-height: 1;
            vertical-align: middle;
        }

        .up-achievements-edit th { text-align: center; background-color: #6BE2E0; }
        .up-achievements-edit .name { width: 350px; }
        .up-achievements-edit .date { }
        .up-achievements-edit .participants { }
        .up-achievements-edit .results {  }

        .up-achievements-edit td input[type=text],
        .up-achievements-edit td textarea
        {
            width: 98%;
        }

        /* /\ edit -form /\ */

        .up-schedule,
        .up-achievements
        {
            width: 100%;
        }

        .up-schedule th,
        .up-schedule td
        {
            border: 1px solid;
            padding: 9px;
            line-height: 1;
            text-align: center;
            vertical-align: middle;
        }

        .up-schedule th { background-color: #6BE2E0; }
        .up-schedule .year { width: 100px; }
        .up-schedule .duration { width: 150px; }
        .up-schedule .hrs-day { width: 90px; }
        .up-schedule .hrs-week { width: 110px; }
        .up-schedule .hrs-year { width: 90px; }
        .up-schedule .lessons {  }

        .up-achievements th,
        .up-achievements td
        {
            border: 1px solid;
            padding: 9px;
            line-height: 1;
            vertical-align: middle;
        }

        .up-achievements th { text-align: center; background-color: #6BE2E0; }
        .up-achievements .name { width: 350px; }
        .up-achievements .date { width: 150px; }
        .up-achievements .participants { width: 165px; }
        .up-achievements .results {  }
        .up-achievements .grp-record { display: block; }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <h2>Наши объединения</h2>
    <%--<ul class="welcome-list">
        <li><details><summary>Объединение «Мастерская художника»</summary>Описание:</details></li>
        <li><details><summary>Объединение «Кудесники»</summary>Описание:</details></li>
        <li><details><summary>Объединение «Фантазёры»</summary>Описание:</details></li>
        <li><details><summary>Объединение «Природа и творчество»</summary>Описание:</details></li>
        <li><details><summary>Объединение «Народные мотивы»</summary>Описание:</details></li>
        <li><details><summary>Объединение «Сделай сам!»</summary>Описание:</details></li>
        <li><details><summary>Объединение «Художественное творчество»</summary>Описание:</details></li>
        <li><details><summary>Объединение «Марья искусница»</summary>Описание:</details></li>
        <li><details><summary>Танцевальный коллектив «Рапсодия»</summary>Описание:</details></li>
        <li><details><summary>Театральная арт – студия «Рассвет»</summary>Описание:</details></li>
        <li><details><summary>Ансамбль бального танца «Д’Арт»</summary>Описание:</details></li>
        <li><details><summary>Ансамбль народной песни «Настенька»</summary>Описание:</details></li>
        <li><details><summary>Образцовый детский коллектив «Вокальная студия «Радуга»</summary>Описание:</details></li>
        <li><details><summary>Образцовый детский коллектив «Театральная студия «Звёздная»</summary>Описание:</details></li>
        <li><details><summary>Образцовый детский коллектив «Хореографический ансамбль «Каприз»</summary>Описание:</details></li>
    </ul>--%>

    <asp:Literal ID="ltlMessage" runat="server" EnableViewState="false" />

    <div data-ng-app="ddteUnionApp">
        <div data-ng-controller="UnionController" >
            <div data-ng-show="DisplayLoading" class="union-loading" data-ng-cloak>LOADING!!!</div>
            <input id="btnAddUnion" runat="server" type="button" class="button" value="Добавить Новое Объединение" data-ng-click="EditUnion(0)" data-ng-show="!DisplayEdit" />
            <div class="union-edit" data-ng-show="DisplayEdit" data-ng-cloak>
                <div>Редактирование Объединения</div>
                <div>Название: <input type="text" data-ng-model="CurrentUnion.Name" /></div>
                <div>Описание: <input type="text" data-ng-model="CurrentUnion.Description" /></div>
                <div data-ng-repeat="up in CurrentUnion.UnionPrograms" >
                    <section class="union-program">
                        <fieldset>
                            <legend>Образовательная программа:</legend>
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
                                    <div class="field"><textarea rows="2" data-ng-model="up.AcceptCondition" ></textarea></div>
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
                                        <td><a data-ng-click="DeleteSchedule($parent.$index, $index)">Удалить</a></td>
                                    </tr>
                                </table>
                                <input type="button" class="button" value="Добавить расписание" data-ng-click="AddEmptySchedule($index)" />
                                <div>Достижения: </div>
                                <table class="up-achievements-edit">
                                    <tr>
                                        <th class="name">Название мероприятия</th>
                                        <th class="date">Сроки</th>
                                        <th class="participants">Участник</th>
                                        <th class="results">Результат</th>
                                        <th></th>
                                    </tr>
                                    <tr data-ng-repeat="ach in up.Achievements" >
                                        <td><textarea rows="2" data-ng-model="ach.Name" ></textarea></td>
                                        <td><input type="text" data-ng-model="ach.Date" /></td>
                                        <td><input type="text" data-ng-model="ach.Participant" /></td>
                                        <td><input type="text" data-ng-model="ach.Result" /></td>
                                        <td><a data-ng-click="DeleteAchievement($parent.$index, $index)">Удалить</a></td>
                                    </tr>
                                </table>
                                <input type="button" class="button" value="Добавить достижение" data-ng-click="AddEmptyAchievement($index)" title="Добавляет пустое достижение к списку достижений" />
                                <input type="button" class="button" value="Добавить копию" data-ng-click="AddAchievementCopy($index, up.Achievements.length - 1)" title="Добавляет достижение к списку достижений с заполненным названием и сроком из последнего достижения в списке." />
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
                                                    <div><%# ((string)Eval("EducationTasks") ?? String.Empty).Replace(Environment.NewLine, "</div></div>") %></div>
                                                    <span class="up-task-title">развивающие:</span>
                                                    <div><%# ((string)Eval("DevelopingTasks") ?? String.Empty).Replace(Environment.NewLine, "</div></div>") %></div>
                                                    <span class="up-task-title">воспитательные:</span>
                                                    <div><%# ((string)Eval("EducativeTasks") ?? String.Empty).Replace(Environment.NewLine, "</div></div>") %></div>
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
                                                            <th class="participants">Участники</th>
                                                            <th class="resutls">Результат</th>
                                                        </tr>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("Name") %></td>
                                                        <td><%# Eval("Date") %></td>
                                                        <td><span class="grp-record"></sp><%# ((string)Eval("Participant") ?? String.Empty).Replace(Environment.NewLine, "</span><span class='grp-record'>") %></span></td>
                                                        <td><span class="grp-record"><%# ((string)Eval("Result") ?? String.Empty).Replace(Environment.NewLine, "</span><span class='grp-record'>") %></span></td>
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
