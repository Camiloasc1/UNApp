<%@ page import="unapp.Teacher" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>
		<div ng-app="EditTeacher" class="container subjectInfo">
			<div class="row">
				<div class="col-xs-12">
					<div class="jumbotron">
						<div class="row" ng-controller="FormEdit">
							<form novalidate role="form" >
								<div class="col-md-4 col-lg-5">
									<img src="${assetPath(src: 'book.png')}" class="img-rounded center-block photo-size"
										 height="250"
										 width="250">


									<label for="name">Nombre</label>
									<input type="text"  id="name" ng-model ="name" class="form-control edit-txtinput" value="" />

									<label for="username">Nombre de usuario</label>
									<input type="text"  id="username" ng-model ="username" class="form-control edit-txtinput" value="" />

									<label for="location">Locación</label>
									<select ng-model ="location.id" class="form-control edit-txtinput" id="location">
										<option ng-repeat="loc in location" value="{{loc.id}}" ng-selected="loc.selected == 1">{{loc.location}}</option>
									</select>

								</div>

								<div class="col-md-8 col-lg-7">

									<h2>Información:</h2>
									<textarea id="info" ng-model ="info" class="form-control edit-txtarea"></textarea>

									<h2>Links:</h2>
									<textarea id="links" ng-model ="links" class="form-control edit-txtarea"></textarea>

									<h2>Cursos:</h2>
									<input class="teachers" id="courses-search" ng-keyup="searchCourse($event)" placeholder="Busca un curso" autocomplete="off"/>
									<span class="glyphicon glyphicon-search" id="search-icons"></span>
									<div id="livesearch" class="search-window">
										<div ng-repeat="course in coursesSearch" ng-click="appendToCourses( course.id, course.name )" class="search-window-opt">{{course.name}}</div>
									</div>

									<div>
										<table class="table table-striped">
											<thead>
											<tr>
												<th>Nombre</th>
												<th>Boton</th>
											</tr>
											</thead>
											<tbody id="courses-table">
											<tr ng-repeat="course in courses" id="{{course.id}}">
												<td>{{course.name}}</td>
												<td><button type="button" class="btn btn-default" ng-click="popFromCourses($event)">Borrar</button></td>
											</tr>
											</tbody>
										</table>
									</div>
								</div>
								<div id="message-response" class="response-txt"></div>
								<input type="submit" ng-click="sendFormEdit()" class="btn btn-default edit-save-btn" value="Guardar" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
