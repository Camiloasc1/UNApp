<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
	</head>
	<body>
		<div class="container contain-menu-admin">
			<div class="row">
				<div class="jumbotron">
					<div class="col-xs-1">
						<nav class="main-menu">
							<ul>
								<li>
									<div onclick="alert('entra')">
										<i class="glyphicon glyphicon-book glyph glyph-2x"></i>
										<span class="nav-text">
											Materias
										</span>
									</div>

								</li>
								<li class="has-subnav">
									<div onclick="alert('entra')">
										<i class="glyphicon glyphicon-user glyph glyph-2x"></i>
										<span class="nav-text">
											Profesores
										</span>
									</div>

								</li>
								<li class="has-subnav">
									<div onclick="alert('entra')">
										<i class="glyphicon glyphicon-globe glyph glyph-2x"></i>
										<span class="nav-text">
											Usuarios
										</span>
									</div>
								</li>
							</ul>
						</nav>
					</div>
					<div class="col-xs-11">
						<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
						<div id="controller-list" role="navigation">
							<h2>Available Controllers:</h2>
							<ul>

								<li class="controller"><a href="/UNApp/comment/index">unapp.CommentController</a></li>

								<li class="controller"><a href="/UNApp/course/index">unapp.CourseController</a></li>

								<li class="controller"><a href="/UNApp/teacher/index">unapp.TeacherController</a></li>

								<li class="controller"><a href="/UNApp/user/index">unapp.UserController</a></li>

							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
