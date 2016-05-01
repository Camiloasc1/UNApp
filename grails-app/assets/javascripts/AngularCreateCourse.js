var app = angular.module('CreateCourse', []);

app.controller('FormCreate', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.location = [];
    $scope.code = "";
    $scope.name = "";
    $scope.typo = "";
    $scope.descr = "";
    $scope.cont = "";
    $scope.teachers = [];
    $scope.teachersSearch = [];

    $scope.sendFormCreate = function(){
        document.getElementById("message-response").innerHTML = "... ...";

        $http.post("course/createCourse",
            {
                location: $scope.location.id,
                code: $scope.code,
                name: $scope.name,
                typo: $scope.typo,
                descr: $scope.descr,
                cont: $scope.cont,
                teachers: $scope.teachers
            })
            .then(function (response) {
                if( parseInt(response.data) == 1 ){
                    document.getElementById("message-response").innerHTML = "Se ha guardado correctamente";
                }else
                    document.getElementById("message-response").innerHTML = "Se ha presentado un error, intentalo nuevaente";
            });
    };

    $scope.searchTeacher = function( event ){
        var str = event.target.value;
        if( str.length >= 4 ) {
            $http.get('course/teacherSearch', {
                    params: {teacher : str}
                })
                .then(function (response) {
                    document.getElementById("livesearch").style.display = "block";
                    $scope.teachersSearch = response.data;
                });
        }else{
            document.getElementById("livesearch").style.display = "none";
            $scope.teachersSearch = [];
            document.getElementById("search-icons").className = "glyphicon glyphicon-search";
        }
    };

    $scope.appendToTeachers = function( id,name ){
        teacher = { id: id, name: name };
        find = false;
        for(var i = 0, len = $scope.teachers.length; i < len; i++) {
            if ($scope.teachers[i].id == id && $scope.teachers[i].name == name) {
                find = true;
                break;
            }
        }
        if( find === false ) {
            $scope.teachers.push(teacher);
            document.getElementById("teacher-search").value = name;
            document.getElementById("livesearch").style.display = "none";
            $scope.teachersSearch = [];
            document.getElementById("search-icons").className = "glyphicon glyphicon-ok ok-search";
        }else{
            document.getElementById("search-icons").className = "glyphicon glyphicon-remove remove-search";
        }
    };

    $scope.popFromTeachers = function( event ){
        var id = event.target.parentNode.parentNode.id;
        var i = 0;
        for( ; i < $scope.teachers.length; i++ ){
            if( $scope.teachers[i].id == id  )
                break;
        }
        $scope.teachers.splice(i, 1);
    };

    $scope.getLocations = function(){
        $http.post('course/getLocations', {})
            .then(function (response) {
                $scope.location = response.data;
            });
    };
    $scope.getLocations();
}]);

