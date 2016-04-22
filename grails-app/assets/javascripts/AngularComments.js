var app = angular.module('CommentsApp', []);

app.controller('StarRatingController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.starRating = function (vote) {
        console.log(vote)
    }
}]);


app.controller('CommentFormController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.context = $location.path().toLowerCase().contains('course') ? 'Course' : $location.path().toLowerCase().contains('teacher') ? 'Teacher' : '';
    $scope.commentBody = '';
    $scope.loading = false;
    $scope.postComment = function () {
        $scope.loading = true;
        $http.post('comment/add' + $scope.context + 'Comment', {id: $scope.id, body: $scope.commentBody})
            .then(function (response) {
                $scope.commentBody = "";
                $scope.loading = false;
                $rootScope.$broadcast('newComment', response.data);
            });
    };
}]);

app.controller('CommentsController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.context = $location.path().toLowerCase().contains('course') ? 'Course' : $location.path().toLowerCase().contains('teacher') ? 'Teacher' : '';
    $scope.max = 5;
    $scope.offset = 0;
    $scope.comments = [];
    $scope.loading = false;

    $scope.voteUp = function (id, index) {
        switch ($scope.comments[index].voted) {
            case -1:
                $scope.comments[index].negativeVotes--;
            case 0:
                $scope.comments[index].positiveVotes++;
            case 1:
            default:
                break;
        }
        $scope.comments[index].voted = 1;

        $http.post("comment/voteUp", {id: id})
            .then(function (response) {
                $scope.comments[index] = response.data;
                $scope.reload();
            });
    };

    $scope.voteDown = function (id, index) {
        switch ($scope.comments[index].voted) {
            case 1:
                $scope.comments[index].positiveVotes--;
            case 0:
                $scope.comments[index].negativeVotes++;
            case -1:
            default:
                break;
        }
        $scope.comments[index].voted = -1;

        $http.post("comment/voteDown", {id: id})
            .then(function (response) {
                $scope.comments[index] = response.data;
                $scope.reload();
            });
    };

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
    $locationProvider.html5Mode(true);
}]);