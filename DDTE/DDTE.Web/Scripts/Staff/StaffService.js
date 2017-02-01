(function () {
    var injectParams = ['$http', '$q'];

    var StaffService = function ($http, $q) {

        var factory = {};

        factory.GetEmployees = function () {
            var httpParams = GetBaseJsonHttpParams();
            httpParams.url = '/dataactionservice.asmx/getemployees';
            httpParams.data = '{}';

            return $http(httpParams).then(
                function (res) {
                    return res.data.d;
                }
            );
        }

        factory.GetEmployee = function (emplId) {
            if (!emplId) {
                var def = $q.defer();

                var emptyEmpl = [ GetEmptyEmployee() ];
                var res = {
                    ErrorMessage: '',
                    Employees: emptyEmpl
                }
                def.resolve(res);

                return def.promise;
            }

            var httpParams = GetBaseJsonHttpParams();
            httpParams.url = '/dataactionservice.asmx/getemployee';
            httpParams.data = "{ 'emplId': '" + emplId + "' }";

            return $http(httpParams).then(
                function (res) {
                    return res.data.d;
                }
            );
        }

        factory.AddEmployee = function (employee) {
            var httpParams = GetBaseJsonHttpParams();
            httpParams.url = '/dataactionservice.asmx/addemployee';
            httpParams.data = { employee: employee };

            return $http(httpParams).then(
                function (res) {
                    return res.data.d;
                }
            );
        }

        factory.UpdateEmployee = function (employee) {
            var httpParams = GetBaseJsonHttpParams();
            httpParams.url = '/dataactionservice.asmx/updateemployee';
            httpParams.data = { employee: employee };

            return $http(httpParams).then(
                function (res) {
                    return res.data.d;
                }
            );
        }

        factory.DeleteEmployee = function (emplId) {
            var httpParams = GetBaseJsonHttpParams();
            httpParams.url = '/dataactionservice.asmx/deleteemployee';
            httpParams.data = { emplId: emplId };

            return $http(httpParams).then(
                function (res) {
                    return res.data.d;
                }
            );
        }

        factory.CanEditStaff = function (){
            var httpParams = GetBaseJsonHttpParams();
            httpParams.url = '/dataactionservice.asmx/caneditstaffdetails';
            httpParams.data = { };

            return $http(httpParams).then(
                function (res) {
                    return res.data.d;
                }
            );
        }

        function GetEmptyEmployee() {
            return {
                Name: '',
                PhotoUrl: '',
                Position: '',
                Qualification: '',
                LeaderOf: '',
                Education: '',
                Speciality: '',
                Degree: '',
                QualificationCourses: '',
                GeneralExperience: '',
                EducationExperience: '',
                Phone: '',
                Email: ''
            };
        }

        function GetBaseJsonHttpParams() {
            var httpParams = {
                dataType: 'json',
                method: 'POST',
                contentType: 'application/json; charset=utf-8'
            };

            return httpParams;
        }

        return factory;
    }

    StaffService.$inject = injectParams;

    angular.module('ddteStaffApp').factory('StaffService', StaffService);
}());