<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
	</head>
	<body>
		<ul class="nav nav-tabs">
			<li class="dropdown">
				<a href="#" data-toggle="dropdown"><span class="fa fa-graduation-cap"></span> Profesores <span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#addTeacher" data-toggle="tab">Agregar</a></li>
					<li class="divider"></li>
					<li><a href="#editTeacher" data-toggle="tab">Modificar</a></li>
					<li class="divider"></li>
					<li><a href="#eraseTeacher" data-toggle="tab">Borrar</a></li>
				</ul>
			</li>
			<li class="dropdown">
				<a href="#" data-toggle="dropdown"><span class="fa fa-book"></span> Materias<span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#addCourse" data-toggle="tab">Agregar</a></li>
					<li class="divider"></li>
					<li><a href="#editCourse" data-toggle="tab">Modificar</a></li>
					<li class="divider"></li>
					<li><a href="#eraseCourse" data-toggle="tab">Borrar</a></li>
				</ul>
			</li>
			<li class="dropdown">
				<a href="#" data-toggle="dropdown"><span class="fa fa-user"></span> Usuarios <span class="caret"></span></a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#addUser" data-toggle="tab">Agregar</a></li>
					<li class="divider"></li>
					<li><a href="#editUser" data-toggle="tab">Modificar</a></li>
					<li class="divider"></li>
					<li><a href="#eraseUser" data-toggle="tab">Borrar</a></li>
				</ul>
			</li>
		</ul>

		<div class="tab-content">
			<div class="tab-pane fade" id="addTeacher">agregar profesor</div>
			<div class="tab-pane fade" id="editTeacher">modificar profesor</div>
			<div class="tab-pane fade" id="eraseTeacher"><g:render template="/teacher/erase"></g:render></div>
			<div class="tab-pane fade" id="addCourse">agregar materia</div>
			<div class="tab-pane fade" id="editCourse">modificar materia</div>
			<div class="tab-pane fade" id="eraseCourse">borrar materia</div>
			<div class="tab-pane fade" id="addUser">agregar usuario</div>
			<div class="tab-pane fade" id="editUser">modificar usuario</div>
			<div class="tab-pane fade" id="eraseUser">borrar usuario</div>
		</div>
	</body>
</html>
