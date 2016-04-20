var app = angular.module('CommentsApp', []);

app.controller('CommentFormController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.commentBody = "";
    $scope.loading = false;
    $scope.postComment = function () {
        $scope.loading = true;
        $http.post("comment", {id: $scope.id, body: $scope.commentBody})
            .then(function (response) {
                $scope.commentBody = "";
                $scope.loading = false;
                $rootScope.$broadcast('postComment', response.data);
            });
    };
}]);

app.controller('CommentsController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.max = 5;
    $scope.offset = 0;
    $scope.comments = [];
    $scope.loading = false;

    $scope.voteUp = function (id, index) {
        $scope.comments[index].positiveVotes++;
        $http.post("voteUp", {id: id})
            .then(function (response) {
                $scope.comments[index] = response.data;
                $scope.reload();
            });
    };

    $scope.voteDown = function (id, index) {
        $scope.comments[index].negativeVotes++;
        $http.post("voteDown", {id: id})
            .then(function (response) {
                $scope.comments[index] = response.data;
                $scope.reload();
            });
    };

    $scope.loadMore = function () {
        $scope.loading = true;
        $http.get("comments", {
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
        $http.get("comments", {
                params: {id: $scope.id, max: $scope.offset, offset: 0}
            })
            .then(function (response) {
                $scope.comments = response.data;
                $scope.offset = $scope.comments.length;
                $scope.loading = false;
            });
    };

    $scope.$on('postComment', function (event, postedComment) {
        $scope.comments = [postedComment].concat($scope.comments);
        $scope.offset++;
        $scope.reload();
    });

    $scope.loadMore();
}]);

app.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode(true);
}]);