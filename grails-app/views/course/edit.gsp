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

	<script>
		function save_teacher(){
			var form = new FormData();
			var id = document.getElementById("id-course").value;
			var location = document.getElementById("location");
			location = location.options[location.selectedIndex].value;

			var code = document.getElementById("code").value;
			var name = document.getElementById("name").value;
			var typo = document.getElementById("typo").value;
			var descr = document.getElementById("descr").value;

			form.append("id", id );
			form.append("location", location );
			form.append("code", parseInt(code) );
			form.append("name", name );
			form.append("typo", typo );
			form.append("descr", descr );

			var teachers = document.getElementsByClassName("teacher-info");
			var id_teachers  = [];
			if( teachers.length > 0 ) {
				var json = '{"teachers": [';
				for (i = 0; i < teachers.length; i++) {
					json += '{ "value": '+teachers[i].id+'}';
					if( i < teachers.length -1 )
							json += ","
				}
				json += ']}';
				console.log(json);
				form.append( "teachers", json );
			}
			if (window.XMLHttpRequest) {
				// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp=new XMLHttpRequest();
			} else {  // code for IE6, IE5
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function() {
				if (xmlhttp.readyState==4 && xmlhttp.status==200) {
					if( xmlhttp.responseText == 1 )
							console.log("funciona");
					else
							console.log("no funciona");
				}
			}
			xmlhttp.open("POST", "course/updateCourse", true);
			xmlhttp.send(form);
		}
		function erase_teacher( e ){
			var teacher = document.getElementById(e.target.parentNode.parentNode.id);
			document.getElementById("teacher-table").removeChild(teacher);
		}
		function appendToTable( id, name ){
			var td1 = document.createElement("td");
			var td2 = document.createElement("td");
			td1.innerHTML = name;
			td2.innerHTML = '<button type="button" class="btn btn-default" onclick="erase_teacher(event)">Borrar</button>';
			var tr = document.createElement("tr");
			tr.appendChild(td1);
			tr.appendChild(td2);
			tr.id = id;
			tr.className = "teacher-info";
			document.getElementById("teacher-table").appendChild(tr);
		}

		function showResult(str) {
			document.getElementById("livesearch").innerHTML="";
			document.getElementById("livesearch").style.border="0px";

			if (window.XMLHttpRequest) {
				// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp=new XMLHttpRequest();
			} else {  // code for IE6, IE5
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function() {
				if (xmlhttp.readyState==4 && xmlhttp.status==200) {
					console.log( xmlhttp.responseText );
					var resp = JSON.parse(xmlhttp.responseText);
					for( i = 0; i < resp.length; i++ ){
						var div = document.createElement("div");

						(function(id, name) {
							div.onclick = function() {
								appendToTable( id, name );
							};
						})(resp[i].id, resp[i].name);

						div.innerHTML = resp[i].name;

						document.getElementById("livesearch").appendChild(div);
						document.getElementById("livesearch").style.border="1px solid #A5ACB2";
					}

				}
			}
			if( str.length >= 4 ) {
				xmlhttp.open("GET", "course/teacherSearch?teacher=" + str, true);
				xmlhttp.send();
			}
		}
	</script>
	</body>
</html>
