var app = angular.module('SearchApp', []);

app.controller('SearchController', ['$scope', '$rootScope', '$http', '$window', function ($scope, $rootScope, $http, $window) {
    $scope.query = "";
    $scope.courses = [];
    $scope.teachers = [];
    $scope.loadingCourses = false;
    $scope.loadingTeachers = false;
    $scope.search = function () {
        $scope.loadingTeachers = true;
        $scope.loadingCourses = true;
        
        $scope.courses = [];
        $scope.teachers = [];
        
        $http.get('teacher/search', {
                params: {query: $scope.query}
            })
            .then(function (response) {
                $scope.teachers = response.data;
                $scope.loadingTeachers = false;
            });
        $http.get('course/search', {
                params: {query: $scope.query}
            })
            .then(function (response) {
                $scope.courses = response.data;
                $scope.loadingCourses = false;
            });
    };
    $scope.showTeacher = function (id) {
        $window.location.href = 'teacher/show?id=' + id;
    };
    $scope.showCourse = function (id) {
        $window.location.href = 'course/show?id=' + id;
    };
}]);

app.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode({enabled: true, rewriteLinks: false});
}]);