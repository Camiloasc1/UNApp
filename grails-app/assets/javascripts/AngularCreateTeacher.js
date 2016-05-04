var app = angular.module('CreateTeacher', []);

app.controller('FormCreate', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.location = [];
    $scope.name = "";
    $scope.username = "";
    $scope.info = "";
    $scope.links = "";
    $scope.courses = [];
    $scope.coursesSearch = [];

    $scope.sendFormCreate = function(){
        document.getElementById("message-response").innerHTML = "... ...";
        if( $scope.location.id != null && $scope.name != "" && $scope.username != "" ) {
            $http.post("teacher/createTeacher",
                {
                    location: $scope.location.id,
                    name: $scope.name,
                    username: $scope.username,
                    info: $scope.info,
                    links: $scope.links,
                    courses: $scope.courses
                })
                .then(function (response) {
                    if (parseInt(response.data) == 1) {
                        document.getElementById("message-response").innerHTML = "Se ha guardado correctamente";
                    } else
                        document.getElementById("message-response").innerHTML = "Se ha presentado un error, intentalo nuevaente";
                });
        }else document.getElementById("message-response").innerHTML = "Hace falta alg&uacute;n valor, por favor revisa tu informaci&oacute;n";
    };

    $scope.searchCourse = function( event ){
        var str = event.target.value;
        if( str.length >= 4 ) {
            $http.get('teacher/courseSearch', {
                    params: {course : str}
                })
                .then(function (response) {
                    document.getElementById("livesearch").style.display = "block";
                    $scope.coursesSearch = response.data;
                });
        }else{
            document.getElementById("livesearch").style.display = "none";
            $scope.coursesSearch = [];
            document.getElementById("search-icons").className = "glyphicon glyphicon-search";
        }
    };

    $scope.appendToCourses = function( id,name ){
        course = { id: id, name: name };
        find = false;
        for(var i = 0, len = $scope.courses.length; i < len; i++) {
            if ($scope.courses[i].id == id && $scope.courses[i].name == name) {
                find = true;
                break;
            }
        }
        if( find === false ) {
            $scope.courses.push(course);
            document.getElementById("courses-search").value = name;
            document.getElementById("livesearch").style.display = "none";
            $scope.coursesSearch = [];
            document.getElementById("search-icons").className = "glyphicon glyphicon-ok ok-search";
        }else{
            document.getElementById("search-icons").className = "glyphicon glyphicon-remove remove-search";
        }
    };

    $scope.popFromCourses = function( event ){
        var id = event.target.parentNode.parentNode.id;
        var i = 0;
        for( ; i < $scope.courses.length; i++ ){
            if( $scope.courses[i].id == id  )
                break;
        }
        $scope.courses.splice(i, 1);
    };

    $scope.getLocations = function(){
        $http.post('course/getLocations', {})
            .then(function (response) {
                $scope.location = response.data;
            });
    };
    $scope.getLocations();
}]);

