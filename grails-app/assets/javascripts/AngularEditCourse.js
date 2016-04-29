var app = angular.module('EditCourse', []);

app.controller('FormEdit', ['$scope', '$rootScope', '$http', '$location', function ($scope, $rootScope, $http, $location) {
    $scope.id = parseInt(($location.absUrl().split("id="))[1]);
    $scope.location = [];
    $scope.code = "";
    $scope.name = "";
    $scope.typo = "";
    $scope.descr = "";
    $scope.teachers = [];
    $scope.teachersSearch = [];
    $scope.sendFormEdit = function( course ){
        document.getElementById("message-response").innerHTML = "... ...";
        $http.post("course/updateCourse",
                {
                    id: $scope.id,
                    location: $scope.location.id,
                    code: $scope.code,
                    name: $scope.name,
                    typo: $scope.typo,
                    descr: $scope.descr,
                    teachers: $scope.teachers
                }
            )

            .then(function (response) {
                console.log(response);
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
                $scope.teachersSearch = response.data;
            });
        }else{
            $scope.teachersSearch = [];
        }
    };

    $scope.appendToTeachers = function( id,name ){
        $scope.teachers.push( { id: id, name: name } );
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
                $scope.descr = response.data.courseInstance.description;
                $scope.location = response.data.locations;
                $scope.teachers = response.data.teachers;
            });
    };
    $scope.findCourse();
}]);
