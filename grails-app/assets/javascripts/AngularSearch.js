var app = angular.module('SearchApp', []);

app.controller('SearchController', ['$scope', '$rootScope', '$http', '$window', function ($scope, $rootScope, $http, $window) {
    $scope.query = "";
    $scope.courses = [];
    $scope.teachers = [];
    $scope.users= [];
    $scope.loadingCourses = false;
    $scope.loadingTeachers = false;
    $scope.loadingUsers = false;
    $scope.search = function () {
        $scope.courses = [];
        $scope.teachers = [];
        $scope.users = [];

        $scope.loadingTeachers = true;
        $scope.loadingCourses = true;
        $scope.loadingUsers = true;

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
        $http.get('user/search', {
                params: {query: $scope.query}
            })
            .then(function (response) {
                $scope.users = response.data;
                $scope.loadingUsers = false;
            });
    };
    $scope.showTeacher = function (id) {
        $window.location.href = 'teacher/show?id=' + id;
    };
    $scope.showCourse = function (id) {
        $window.location.href = 'course/show?id=' + id;
    };
    $scope.showUser = function (id) {
        $window.location.href = 'user/show?id=' + id;
    };

    $scope.$watch('query', function () {
        if ($scope.query.length < 3) {
            $scope.courses = [];
            $scope.teachers = [];
            $scope.users = [];
        } else {
            $scope.search();
        }
    });
}]);

app.controller('MyCommentsController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.context = ( $location.path().toLowerCase().indexOf('user') != -1 ) ? 'User' : '';
    $scope.max = 5;
    $scope.offset = 0;
    $scope.comments = [];
    $scope.loading = false;

    $scope.loadMore = function () {
        $scope.loading = true;
        $http.get($scope.context + '/comments', {
                params: {id: $scope.id, max: $scope.max, offset: $scope.offset}
            })
            .then(function (response) {
                $scope.comments = $scope.comments.concat(response.data);
                $scope.offset = $scope.comments.length;
                $scope.loading = false;
            });
    };

    $scope.reload = function () {
        $scope.loading = true;
        $http.get($scope.context + '/comments', {
                params: {id: $scope.id, max: $scope.offset, offset: 0}
            })
            .then(function (response) {
                $scope.comments = response.data;
                $scope.offset = $scope.comments.length;
                $scope.loading = false;
            });
    };

    $scope.$on('newComment', function (event, postedComment) {
        $scope.comments = [postedComment].concat($scope.comments);
        $scope.offset++;
        $scope.reload();
    });

    $scope.loadMore();
}]);


app.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode({enabled: true, rewriteLinks: false});
}]);