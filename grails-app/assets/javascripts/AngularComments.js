var app = angular.module('CommentsApp', []);

app.controller('CommentFormController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.commentBody = "";
    $scope.postComment = function () {
        $http.post("comment", {id: $scope.id, body: $scope.commentBody})
            .then(function (response) {
                $scope.commentBody = "";
                $rootScope.$broadcast('postComment', response.data);
            });
    };
}]);

app.controller('CommentsController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.max = 5;
    $scope.offset = 0;
    $scope.comments = [];
    $scope.loadMore = function () {
        $http.get("comments", {
                params: {id: $scope.id, max: $scope.max, offset: $scope.offset}
            })
            .then(function (response) {
                $scope.comments.push.apply($scope.comments, response.data);
                $scope.offset = $scope.comments.length;
            });
    };
    $scope.loadMore();
    $scope.$on('postComment', function (event, args) {
        $scope.comments.push.apply(args, $scope.comments)
        $scope.offset++;
        $http.get("comments", {
                params: {id: $scope.id, max: $scope.offset, offset: 0}
            })
            .then(function (response) {
                $scope.comments = response.data;
                $scope.offset = $scope.comments.length;
            });
    });
}]);

app.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode(true);
}]);