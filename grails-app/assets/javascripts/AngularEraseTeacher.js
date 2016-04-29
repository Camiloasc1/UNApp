/**
 * Created by mauricio on 29/04/16.
 */

var app = angular.module("eraseApp",[]);

app.controller('eraseController', ['$scope', '$rootScope', '$http', '$window', function ($scope, $rootScope, $http, $window) {
    $scope.query = "";
    $scope.teachers = [];
    $scope.loadingTeachers = false;
    
    $scope.search = function () {
        $scope.teachers = [];

        $scope.loadingTeachers = true;
        
        $http.get('teacher/search', {
                params: {query: $scope.query}
            })
            .then(function (response) {
                $scope.teachers = response.data;
                $scope.loadingTeachers = false;
            });
    };

    $scope.eraseTeacher = function(id){
        alert("Borrando "+id);
    };

    $scope.$watch('query', function () {
        if ($scope.query.length < 3) {
            $scope.courses = [];
            $scope.teachers = [];
        } else {
            $scope.search();
        }
    });
}]);