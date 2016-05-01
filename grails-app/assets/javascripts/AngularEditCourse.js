var app = angular.module('EditCourse', []);

app.controller('FormEdit', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt(($location.absUrl().split("id="))[1]);
    $scope.location = [];
    $scope.code = "";
    $scope.name = "";
    $scope.typo = "";
    $scope.credits = "";
    $scope.descr = "";
    $scope.cont = "";
    $scope.teachers = [];
    $scope.teachersSearch = [];
    $scope.sendFormEdit = function(){
        document.getElementById("message-response").innerHTML = "... ...";
        if( $scope.location.id != null && $scope.name != "" && $scope.typo != "" && $scope.teachers.length > 0 && $scope.credits != ""  ) {
            $http.post("course/updateCourse",
                {
                    id: $scope.id,
                    location: $scope.location.id,
                    code: $scope.code,
                    name: $scope.name,
                    typo: $scope.typo,
                    credits: $scope.credits,
                    descr: $scope.descr,
                    cont: $scope.cont,
                    teachers: $scope.teachers
                }
                )

                .then(function (response) {
                    if (parseInt(response.data) == 1) {
                        document.getElementById("message-response").innerHTML = "Se ha guardado correctamente";
                    } else
                        document.getElementById("message-response").innerHTML = "Se ha presentado un error, intentalo nuevaente";
                });
        }else{
            document.getElementById("message-response").innerHTML = "Hace falta alg&uacute;n valor, por favor revisa tu informaci&oacute;n";
        }
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

    $scope.findCourse = function(){
        $http.get('course/getCourseForm', {
                params: {id : $scope.id}
            })
            .then(function (response) {
                $scope.code = response.data.courseInstance.code;
                $scope.name = response.data.courseInstance.name;
                $scope.typo = response.data.courseInstance.typology;
                $scope.credits = response.data.courseInstance.credits;
                $scope.descr = response.data.courseInstance.description;
                $scope.cont = response.data.courseInstance.contents;
                $scope.location = response.data.locations;
                $scope.teachers = response.data.teachers;
            });
    };
    $scope.findCourse();
}]);

