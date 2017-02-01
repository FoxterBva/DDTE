(function () {
    var injectParams = ['$window','$scope', 'UnionServiceFactory'];

    var UnionController = function ($window, $scope, UnionServiceFactory) {
        $scope.CurrentUnion = GetEmptyUnion();
        $scope.DisplayLoading = false;
        $scope.DisplayEdit = false;
        $scope.Errors = [];
        $scope.AddUPButtonText = "Добавить образовательную программу";

        $scope.GetUnion = function(unionId) {
            $scope.DisplayLoading = true;
            UnionServiceFactory.GetUnion(unionId, onUnionLoaded, onError)
        }

        $scope.AddEmptyUnionProgram = function() {
            $scope.CurrentUnion.UnionPrograms.push(GetEmptyUnionProgram());
            if ($scope.CurrentUnion.UnionPrograms.length > 0)
                $scope.AddUPButtonText = "Добавить еще одну образовательную программу";
            else
                $scope.AddUPButtonText = "Добавить образовательную программу";
        }

        $scope.AddEmptySchedule = function (index) {
            $scope.CurrentUnion.UnionPrograms[index].Schedule.push(GetEmptySchedule());
        }

        $scope.DeleteSchedule = function (upIndex, schIndex) {
            $scope.CurrentUnion.UnionPrograms[upIndex].Schedule.splice(schIndex, 1);
        }

        $scope.AddEmptyAchievement = function(index) {
            $scope.CurrentUnion.UnionPrograms[index].Achievements.push(GetEmptyAchievement());
        }

        $scope.AddAchievementCopy = function (upIndex, achIndex) {
            if (achIndex < 0)
            {
                $scope.AddEmptyAchievement(upIndex);
            }
            else
            {
                var lastAch = $scope.CurrentUnion.UnionPrograms[upIndex].Achievements[achIndex];
                var newAch = GetEmptyAchievement();
                newAch.Name = lastAch.Name;
                newAch.Date = lastAch.Date;
                $scope.CurrentUnion.UnionPrograms[upIndex].Achievements.push(newAch);
            }
        }

        $scope.DeleteAchievement = function (upIndex, achIndex) {
            $scope.CurrentUnion.UnionPrograms[upIndex].Achievements.splice(achIndex, 1);
        }

        $scope.AddParticipant = function (upIndex, achIndex) {
            $scope.CurrentUnion.UnionPrograms[upIndex].Achievements[achIndex].Participants.push(GetEmptyParticipant());
        }

        $scope.DeleteParticipant = function (upIndex, achIndex, partIndex) {
            $scope.CurrentUnion.UnionPrograms[upIndex].Achievements[achIndex].Participants.splice(partIndex, 1);
        }


        $scope.EditUnion = function (id) {
            if (id == 0) {
                SetCurrentUnion(GetEmptyUnion());
                ToggleEditForm(true);
            }
            else
                $scope.GetUnion(id);
        }

        $scope.SaveUnion = function () {
            $scope.DisplayLoading = true;
            UnionServiceFactory.SaveUnion($scope.CurrentUnion, onUnionSaved, onError)
        }

        $scope.DeleteUnion = function (unionId) {
            $scope.DisplayLoading = true;
            UnionServiceFactory.DeleteUnion(unionId, onUnionDeleted, onError)
        }

        $scope.CancelEdit = function () {
            ToggleEditForm(false);
        }

        function SetCurrentUnion(union) {
            $scope.CurrentUnion = union;
            if ($scope.CurrentUnion.UnionPrograms.length > 0)
                $scope.AddUPButtonText = "Добавить еще одну образовательную программу";
            else
                $scope.AddUPButtonText = "Добавить образовательную программу";
        }

        function onUnionLoaded(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                SetCurrentUnion(data.d.Union);
                ToggleEditForm(true);
            }

            $scope.DisplayLoading = false;
        }

        function onUnionSaved(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                alert('Объединение изменено!');
                ToggleEditForm(false);
                $window.location.reload();
            }

            $scope.DisplayLoading = false;
        }

        function onUnionDeleted(data) {
            if (data.d.ErrorMessage)
                alert(data.d.ErrorMessage);
            else {
                alert('Объединение удалено!');
                $window.location.reload();
            }

            $scope.DisplayLoading = false;
        }

        function GetEmptyUnion() {
            return {
                UnionId: 0,
                UnionPrograms: []
            };
        }

        function GetEmptyUnionProgram() {
            return {
                UnionProgramId: 0,
                Achievements: [],
                Schedule: []
            };
        }

        function GetEmptyAchievement() {
            return {
                UnionAchievementId: 0,
                Participants: []
            };
        }

        function GetEmptyParticipant() {
            return {
                UnionAchievementParticipantId: 0
            };
        }

        function GetEmptySchedule() {
            return {
                UnionScheduleId: 0
            };
        }

        function ToggleEditForm(visible) {
            $scope.DisplayEdit = visible;
        }

        function Init() {
            $scope.Test = "Just a test";
        }

        function onError(data, status, headers, config) {
            $scope.DisplayLoading = false;
            $scope.Errors.push({ Data: data, Status: status, Headers: headers, Config: config });
            alert('Операция завершена с ошибкой');
        }

        Init();
    };

    UnionController.$inject = injectParams;

    angular.module('ddteUnionApp').controller('UnionController', UnionController);
}());