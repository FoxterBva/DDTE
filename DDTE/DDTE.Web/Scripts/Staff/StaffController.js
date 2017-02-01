(function () {
    var injectParams = ['$scope', 'StaffService'];

    var StaffController = function ($scope, StaffService) {

        $scope.Data = {
            DisplayDetailsForm: false,
            Employees: [],
            ActiveEmployee: {},
            IsEditMode: false,
            IsNew: false,
            CanEdit: false
        }

        $scope.emplFilter = function (employer) {
            var token = $scope.Data.FilterText;
            var regex = new RegExp(token, "i");

            var res = (employer.Name || '').search(regex) >= 0 ||
                (employer.Phone || '').search(regex) >= 0 ||
                (employer.Position || '').search(regex) >= 0 ||
                (employer.Email || '').search(regex) >= 0 ||
                (employer.GeneralExperience || '').search(regex) >= 0 ||
                (employer.LeaderOf || '').search(regex) >= 0;

            return res;
        }

        $scope.DisplayDetails = function (emplId) {
            $scope.Data.IsEditMode = false;
            GetEmployee(emplId).then(
                function (res) {
                    if (res)
                        $scope.Data.DisplayDetailsForm = true;
                }
            );
        }

        $scope.EditDetails = function (emplId) {
            $scope.Data.IsNew = emplId == null;
            $scope.Data.IsEditMode = true;
            GetEmployee(emplId).then(
                function (res) {
                    if (res)
                        $scope.Data.DisplayDetailsForm = true;
                }
            );
        }

        $scope.SwitchToEdit = function () {
            $scope.Data.IsNew = false;
            $scope.Data.IsEditMode = true;
        }

        $scope.CloseDetails = function () {
            $scope.Data.DisplayDetailsForm = false;
        }

        $scope.SubmitEmployee = function () {
            if ($scope.Data.IsNew)
                $scope.AddDetails();
            else
                $scope.UpdateDetails();
        }

        $scope.AddDetails = function () {
            StaffService.AddEmployee($scope.Data.ActiveEmployee).then(
                function (res) {
                    if (!res.ErrorMessage) {
                        return true;
                    } else {
                        alert('Не удалось добавить сотрудника: ' + res.ErrorMessage);
                        return false;
                    }
                },
                function (err) {
                    alert('Не удалось добавить сотрудника');
                    return false;
                }
            ).then(function (res) {
                if (res) {
                    $scope.CloseDetails();
                    ReloadEmployees();
                }
            });
        }

        $scope.UpdateDetails = function () {
            StaffService.UpdateEmployee($scope.Data.ActiveEmployee).then(
                function (res) {
                    if (!res.ErrorMessage) {
                        return true;
                    } else {
                        alert('Не удалось обновить сотрудника: ' + res.ErrorMessage);
                        return false;
                    }
                },
                function (err) {
                    alert('Не удалось обновить сотрудника');
                    return false;
                }
            ).then(function (res) {
                if (res) {
                    $scope.CloseDetails();
                    ReloadEmployees();
                }
            });
        }

        $scope.DeleteEmployee = function (empl) {
            if (!confirm("Вы действительно хотите удалить сотрудника '" + empl.Name + "'?"))
            {
                return;
            }

            StaffService.DeleteEmployee(empl.StaffId).then(
                function (res) {
                    if (!res.ErrorMessage) {
                        return true;
                    } else {
                        alert('Не удалось удалить сотрудника: ' + res.ErrorMessage);
                        return false;
                    }
                },
                function (err) {
                    alert('Не удалось удалить сотрудника');
                    return false;
                }
            ).then(function (res) {
                if (res)
                    ReloadEmployees();
            });
        }



        function GetEmployee(emplId) {
            return StaffService.GetEmployee(emplId).then(
                function (res) {
                    if (!res.ErrorMessage) {
                        $scope.Data.ActiveEmployee = res.Employees[0];
                        return true;
                    } else {
                        alert('Не удалось загрузить данные сотрудника: ' + res.ErrorMessage);
                        return false;
                    }
                },
                function (err) {
                    alert('Не удалось загрузить данные сотрудника');
                    return false;
                }
            )
        }

        function ReloadEmployees() {
            return StaffService.GetEmployees().then(
                function (res) {
                    if (!res.ErrorMessage) {
                        $scope.Data.Employees = res.Employees;
                    } else {
                        alert('Не удалось загрузить список сотрудников: ' + res.ErrorMessage);
                    }
                },
                function (err) {
                    alert('Не удалось загрузить список сотрудников');
                }
            );
        }

        function Init() {
            StaffService.CanEditStaff().then(
                function (res) {
                    $scope.Data.CanEdit = res;
                }
            );

            ReloadEmployees();
        }

        Init();
    };

    StaffController.$inject = injectParams;

    angular.module('ddteStaffApp').controller('StaffController', StaffController);
}());