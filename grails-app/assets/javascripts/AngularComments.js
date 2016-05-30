var app = angular.module('CommentsApp', []);

app.controller('StarRatingController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.context = ( $location.path().toLowerCase().indexOf('course') != -1 ) ? 'Course' : ( $location.path().toLowerCase().indexOf('teacher') != -1 ) ? 'Teacher' : '';
    $scope.starRating = function (vote) {
        $http.get($scope.context + '/starRate', {
                params: {id: $scope.id, vote: vote}
            })
            .then(function (response) {
                fill_stars_voted(vote);
                fill_stars_median(response.data.median);
            });
    }

    $scope.starMedian = function () {
        $http.get($scope.context + '/starMedian', {
                params: {id: $scope.id}
            })
            .then(function (response) {
                if (response.data.stars != 0)
                    fill_stars_voted(response.data.stars);
                if (response.data.median != -1)
                    fill_stars_median(response.data.median);
            });
    }
    $scope.starMedian();
}]);

app.controller('CommentsFilter', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.context = ( $location.path().toLowerCase().indexOf('course') != -1 ) ? 'Course' : ( $location.path().toLowerCase().indexOf('teacher') != -1 ) ? 'Teacher' : '';
    $scope.loading = false;
    $scope.searchFilter = ["", null, [], 0];
    $scope.date = 0;
    $scope.advancedSearch = function () {
        $scope.loading = true;
        $scope.searchFilter[2] = [];
        if( $scope.context == "Course" )
            var sel = document.getElementById("sel-materias");
        for (var i = 0; i < sel.options.length; i++)
            if(sel.options[i].selected)
                $scope.searchFilter[2].push(sel.options[i].value);

        $scope.searchFilter[3] = document.getElementById("select-date").selectedIndex;;
        $http.post($scope.context+"/commentsFiltered",
            {id: $scope.id, max: $scope.max, offset: $scope.offset, filters: $scope.searchFilter}
            ).then(function (response) {
                $rootScope.$broadcast('newFiltered', response.data);
                $scope.loading = false;
            });
    };
}]);

app.controller('CommentFormController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.context = ( $location.path().toLowerCase().indexOf('course') != -1 ) ? 'Course' : ( $location.path().toLowerCase().indexOf('teacher') != -1 ) ? 'Teacher' : '';
    $scope.commentBody = '';
    $scope.selectedCourse = -1;
    $scope.selectedTeacher = -1;
    $scope.loading = false;
    $scope.postComment = function () {
        if ($scope.commentBody.trim().length == 0) {
            return;
        }
        $scope.selectedCourse = parseInt($scope.selectedCourse);
        $scope.selectedTeacher = parseInt($scope.selectedTeacher);
        $scope.loading = true;
        $http.post('comment/addComment', {
                body: $scope.commentBody,
                course: $scope.context == 'Course' ? $scope.id : $scope.selectedCourse,
                teacher: $scope.context == 'Teacher' ? $scope.id : $scope.selectedTeacher
            })
            .then(function (response) {
                $scope.commentBody = '';
                $scope.loading = false;
                $rootScope.$broadcast('newComment', response.data);
            });
    };
}]);

app.controller('CommentsController', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt($location.search().id);
    $scope.context = ( $location.path().toLowerCase().indexOf('course') != -1 ) ? 'Course' : ( $location.path().toLowerCase().indexOf('teacher') != -1 ) ? 'Teacher' : '';
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

        $http.post("comment/voteUp", {id: id, context: $scope.context})
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

        $http.post("comment/voteDown", {id: id, context: $scope.context})
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

    $scope.$on('newFiltered', function (event, filteredComments) {
        console.log(filteredComments);
        $scope.comments = filteredComments;
    });

    $scope.loadMore();
}]);

app.config(['$locationProvider', function ($locationProvider) {
    $locationProvider.html5Mode({enabled: true, rewriteLinks: false});
}]);