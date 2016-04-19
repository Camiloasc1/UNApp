var app = angular.module('CommentsApp', []);

app.controller('CommentsController', function ($scope, $http) {
    $scope.query = JSON.parse(window.location.search.replace("?", '{"').replace(/=/g, '":"').replace(/&/g, '","').concat('"}'));
    $scope.id = $scope.query.id;
    $scope.max = 5;
    $scope.offset = 0;
    $scope.comments = [];
    $scope.loadMore = function () {
        $http.get("comments", {
                headers: {'User-Agent': ''},
                params: {id: $scope.id, max: $scope.max, offset: $scope.offset}
            })
            .then(function (response) {
                $scope.comments.push.apply($scope.comments, response.data);
                $scope.offset = $scope.comments.length;
            });
    };
    $scope.loadMore();
});