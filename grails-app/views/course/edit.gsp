<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>
		<div class="container" ng-app="EditCourse">
			<div class="jumbotron" style="padding: 50px 100px;">
				<div class="row" ng-controller="FormEdit">
					<form novalidate role="form" >
						<label for="location">Locación</label>
						<select ng-model ="location.id" class="form-control" id="location">
							<option ng-repeat="loc in location" value="{{loc.id}}" ng-selected="loc.selected == 1">{{loc.location}}</option>
						</select>
						<br />
						<label for="code">Código</label>
						<input type="text" id="code" ng-model ="code" class="form-control" value="" />
						<br />
						<label for="name">Nombre</label>
						<input type="text"  id="name" ng-model ="name" class="form-control" value="" />
						<br />
						<label for="typo">Tipologia</label>
						<input type="text" id="typo" ng-model ="typo" class="form-control" value="" />
						<br />
						<label for="descr">Descripción</label>
						<textarea id="descr" ng-model ="descr" class="form-control"></textarea>
						<br />
						<label>Profesores</label>
						<input class="teachers" ng-keyup="searchTeacher($event)" placeholder="Busca un profesor"/>
						<div id="livesearch">
							<div ng-repeat="teacher in teachersSearch" ng-click="appendToTeachers( teacher.id, teacher.name )">{{teacher.name}}</div>
						</div>
						<div>
							<table class="table table-striped">
								<thead>
								<tr>
									<th>Nombre</th>
									<th>Boton</th>
								</tr>
								</thead>
								<tbody id="teacher-table">
								<tr ng-repeat="teacher in teachers" id="{{teacher.id}}">
									<td>{{teacher.name}}</td>
									<td><button type="button" class="btn btn-default" ng-click="popFromTeachers($event)">Borrar</button></td>
								</tr>
								</tbody>
							</table>
						</div>
						<input type="submit" ng-click="sendFormEdit(course)" value="Guardar" />

						<div id="message-response"></div>
					</form>
				</div>
			</div>
		</div>
		<a href="#edit-course" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
	</body>
</html>
