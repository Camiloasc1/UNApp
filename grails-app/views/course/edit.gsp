<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>
		<div ng-app="EditCourse" class="container subjectInfo">
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


									<label for="code">Código</label>
									<input type="text" id="code" ng-model ="code" class="form-control edit-txtinput" value="" />


									<label for="location">Locación</label>
									<select ng-model ="location.id" class="form-control edit-txtinput" id="location">
										<option ng-repeat="loc in location" value="{{loc.id}}" ng-selected="loc.selected == 1">{{loc.location}}</option>
									</select>

								</div>

								<div class="col-md-8 col-lg-7">

									<h2>Descripción:</h2>
									<textarea id="descr" ng-model ="descr" class="form-control edit-txtarea"></textarea>

									<h2>Contenidos:</h2>
									<textarea id="cont" ng-model ="cont" class="form-control edit-txtarea"></textarea>

									<h2>Profesores:</h2>
									<input class="teachers" id="teacher-search" ng-keyup="searchTeacher($event)" placeholder="Busca un profesor"/>
									<span class="glyphicon glyphicon-search" id="search-icons"></span>
									<div id="livesearch" class="search-window">
										<div ng-repeat="teacher in teachersSearch" ng-click="appendToTeachers( teacher.id, teacher.name )" class="search-window-opt">{{teacher.name}}</div>
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
								</div>
								<input type="submit" ng-click="sendFormEdit(course)" class="btn btn-default edit-save-btn" value="Guardar" />
								<div id="message-response"></div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
