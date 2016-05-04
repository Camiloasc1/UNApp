/**
 * Created by mauricio on 29/04/16.
 */

var app = angular.module("eraseApp",[]);

app.controller('eraseController', ['$scope', '$rootScope', '$http', '$window', function ($scope, $rootScope, $http, $window) {
    $scope.query = "";
    $scope.teachers = [];
    $scope.loadingTeachers = false;
    
    $scope.search = function () {
        $scope.teachers = [];

        $scope.loadingTeachers = true;
        
        $http.get('teacher/search', {
                params: {query: $scope.query}
            })
            .then(function (response) {
                $scope.teachers = response.data;
                $scope.loadingTeachers = false;
            });
    };

    $scope.eraseTeacher = function(teacher){
        var c = confirm("Vas a eliminar a "+teacher.name+" ¿estas seguro? (esta operacion no se puede deshacer)");
        if(c){
            $http.post('teacher/deleteAux',  {
                    id: teacher.id
                })
                .then( function (response) {
                    $scope.teachers = [];
                    if(response.data == "true")
                        $scope.confirmed = "El profesor " + teacher.name + " ha sido borrado correctamente";
                    else
                        $scope.confirmed = "Error en la operación";
                } );
        }
    };

    $scope.$watch('query', function () {
        if ($scope.query.length < 3) {
            $scope.teachers = [];
        } else {
            $scope.search();
        }
    });
}]);