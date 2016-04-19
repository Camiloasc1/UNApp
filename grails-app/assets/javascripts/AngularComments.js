var app = angular.module('CommentsApp', []);

app.controller('CommentFormController', ['$scope', '$rootScope', '$http', function ($scope, $rootScope, $http) {
    $scope.query = JSON.parse(window.location.search.replace("?", '{"').replace(/=/g, '":"').replace(/&/g, '","').concat('"}'));
    $scope.id = $scope.query.id;
    $scope.postComment = function () {
        $http.post("comment", {id: $scope.id, body: $scope.commentBody})
            .then(function (response) {
                $rootScope.$broadcast('postComment');
            });
    };
}]);

app.controller('CommentsController', ['$scope', '$rootScope', '$http', function ($scope, $rootScope, $http) {
    $scope.query = JSON.parse(window.location.search.replace("?", '{"').replace(/=/g, '":"').replace(/&/g, '","').concat('"}'));
    $scope.id = $scope.query.id;
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
    $scope.$on('postComment', function (event, mass) {
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