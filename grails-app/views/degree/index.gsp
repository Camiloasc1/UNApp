
<%@ page import="unapp.Degree" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'degree.label', default: 'Degree')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-degree" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-degree" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="code" title="${message(code: 'degree.code.label', default: 'Code')}" />
					
						<th><g:message code="degree.location.label" default="Location" /></th>
					
						<g:sortableColumn property="name" title="${message(code: 'degree.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="type" title="${message(code: 'degree.type.label', default: 'Type')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${degreeInstanceList}" status="i" var="degreeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${degreeInstance.id}">${fieldValue(bean: degreeInstance, field: "code")}</g:link></td>
					
						<td>${fieldValue(bean: degreeInstance, field: "location")}</td>
					
						<td>${fieldValue(bean: degreeInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: degreeInstance, field: "type")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${degreeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
