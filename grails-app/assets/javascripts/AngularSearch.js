var app = angular.module('SearchApp', []);

app.controller('SearchController', ['$scope', '$rootScope', '$http', '$window', '$location','$anchorScroll', function ($scope, $rootScope, $http, $window, $location, $anchorScroll) {



    $scope.query = "";
    $scope.courses = [];
    $scope.teachers = [];
    $scope.loadingCourses = false;
    $scope.loadingTeachers = false;

    angular.element(document).ready(function () {
        if($location.search().search_nav) {
            $scope.query = $location.search().search_nav;
            $scope.search();
        }
    });
    $scope.search = function () {
        $scope.courses = [];
        $scope.teachers = [];

        $scope.loadingTeachers = true;
        $scope.loadingCourses = true;

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

    $scope.$watch('query', function () {
        if ($scope.query.length < 3) {
            $scope.courses = [];
            $scope.teachers = [];
        } else {
            $scope.search();
        }
    });
}]);

app.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode({enabled: true, rewriteLinks: false});
}]);

app.directive('endSearch', function($location, $anchorScroll) {
    return function(scope, element, attrs) {
        if (scope.$last){
            $location.hash('showSearch');
            $anchorScroll();
        }
    };
});