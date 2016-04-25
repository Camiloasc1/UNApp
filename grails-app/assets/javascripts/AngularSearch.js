var app = angular.module('SearchApp', []);

app.controller('SearchController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.query = "";
    $scope.courses = [];
    $scope.teachers = [];
    $scope.loadingCourses = false;
    $scope.loadingTeachers = false;
    $scope.search = function () {
        $scope.loadingCourses = true;
        $scope.loadingTeachers = true;
        $http.get('course/search', {
                params: {query: $scope.query}
            })
            .then(function (response) {
                $scope.courses = response.data;
                $scope.loadingCourses = false;
            });
        $http.get('teacher/search', {
                params: {query: $scope.query}
            })
            .then(function (response) {
                $scope.teachers = response.data;
                $scope.loadingTeachers = false;
            });
    };
}]);

app.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode({enabled: true, rewriteLinks: false});
}]);