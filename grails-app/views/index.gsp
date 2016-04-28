<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div ng-app="SearchApp" ng-controller="SearchController" class="container">
    <div class="row">
        <div class="col-xs-12">
            <div class="jumbotron">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2 col-sm-6 col-sm-offset-3 col-lg-4 col-lg-offset-4">
                        <img class="img-responsive center-block" src="${assetPath(src: 'search_logo.png')}"
                             alt="Search Logo">
                    </div>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-8 col-sm-offset-2 col-lg-6 col-lg-offset-3">
                        <form ng-submit="search()">
                            <div class="input-group">
                                <input type="text" class="form-control input-lg"
                                       placeholder="Buscar un profesor o materia"
                                       ng-model="query"/>
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-info btn-lg" ng-click="search()">
                                        <i class="glyphicon glyphicon-search"></i>
                                    </button>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="jumbotron">
                <h3>Profesores</h3>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Correo Institucional</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="teacher in teachers" class="clickable-element"
                        ng-click="showTeacher(teacher.id)">
                        <td>{{teacher.name}}</td>
                        <td>{{teacher.email}}</td>
                    </tr>
                    </tbody>
                </table>

                <div ng-show="loadingTeachers" class="text-center">
                    <i class="fa fa-spinner fa-pulse fa-5x"></i>
                    <span class="sr-only">Cargando...</span>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="jumbotron">
                <h3>Materias</h3>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>Codigo</th>
                        <th>Nombre</th>
                        <th>Creditos</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="course in courses" class="clickable-element" ng-click="showCourse(course.id)">
                        <td>{{course.code}}</td>
                        <td>{{course.name}}</td>
                        <td>{{course.credits}}</td>
                    </tr>
                    </tbody>
                </table>

                <div ng-show="loadingCourses" class="text-center">
                    <i class="fa fa-spinner fa-pulse fa-5x"></i>
                    <span class="sr-only">Cargando...</span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
