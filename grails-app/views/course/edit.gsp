<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'course.label', default: 'Course')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="container">
			<div class="jumbotron">
				<div class="row">
					<form >
						<input type="hidden" id="id-course" value="${result.courseInstance.id}" />
						<label>Locación</label>
						<select id="location">
							<g:each in="${result.locations}">
								<option value="${it.name}">${it.name}</option>
							</g:each>
						</select>
						<br />
						<label>Código</label>
						<input id="code" value="${result.courseInstance.code}" />
						<br />
						<label>Nombre</label>
						<input id="name" value="${result.courseInstance.name}" />
						<br />
						<label>Tipologia</label>
						<input id="typo" value="${result.courseInstance.typology}" />
						<br />
						<label>Descripción</label>
						<textarea id="descr">${result.courseInstance.description}</textarea>
						<br />
						<label>Profesores</label>
						<input class="teachers" onkeyup="showResult(this.value)" value=""/>
						<div id="livesearch"></div>
						<div>
							<table class="table table-striped">
								<thead>
								<tr>
									<th>Nombre</th>
									<th>Boton</th>
								</tr>
								</thead>
								<tbody id="teacher-table">
								<g:each in="${result.courseInstance.teachers}">
									<tr id="${it.id}" class="teacher-info">
										<td>${it.name}</td>
										<td><button type="button" class="btn btn-default" onclick="erase_teacher(event)">Borrar</button></td>
									</tr>
								</g:each>
								</tbody>
							</table>
						</div>
						<button type="button" class="btn btn-default" onclick="save_teacher()">Guardar</button>
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
