<!DOCTYPE html>
<html>
<head>
	<meta name="layout" content="main">
</head>
<body>
<div class="container-fluid">
	<ul class="nav nav-pills nav-justified">
		<g:each in="${result}" status="i" var="location">
			<g:if test="${i == 0}">
				<li class="active"><a data-toggle="pill" href="#${location.name}Pill">${location.name}</a></li>
			</g:if>
			<g:else>
				<li><a data-toggle="pill" href="#${location.name}Pill">${location.name}</a></li>
			</g:else>
		</g:each>
	</ul>

	<div class="tab-content">
		<g:each in="${result}" status="i" var="location">
			<g:if test="${i == 0}">
				<div id="${location.name}Pill" class="tab-pane fade in active">
					<g:render template="locationIndex" bean="${location}"/>
				</div>
			</g:if>
			<g:else>
				<div id="${location.name}Pill" class="tab-pane fade">
					<g:render template="locationIndex" bean="${location}"/>
				</div>
			</g:else>
		</g:each>
	</div>
</div>
</body>
</html>
