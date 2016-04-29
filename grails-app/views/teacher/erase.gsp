<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">

</head>
<body>
<div ng-app="eraseApp" ng-controller="eraseController">
        <div align="center">
            <input type="text" class="form-control" placeholder="Buscar un profesor a eliminar" ng-model="query" style="width: 300px;">
        </div>

        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>Nombre</th>
                <th>Correo Institucional</th>
            </tr>
            </thead>
            <tbody>
            <tr ng-repeat="teacher in teachers" class="clickable-element"
                ng-click="eraseTeacher(teacher.id)">
                <td>{{teacher.name}}</td>
                <td>{{teacher.email}}</td>
            </tr>
            </tbody>
        </table>
</div>
</body>

</html>
