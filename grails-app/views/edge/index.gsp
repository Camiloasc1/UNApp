
<%@ page import="unapp.Edge" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'edge.label', default: 'Edge')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-edge" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-edge" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="edge.degree.label" default="Degree" /></th>
					
						<th><g:message code="edge.next.label" default="Next" /></th>
					
						<th><g:message code="edge.prev.label" default="Prev" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${edgeInstanceList}" status="i" var="edgeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${edgeInstance.id}">${fieldValue(bean: edgeInstance, field: "degree")}</g:link></td>
					
						<td>${fieldValue(bean: edgeInstance, field: "next")}</td>
					
						<td>${fieldValue(bean: edgeInstance, field: "prev")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${edgeInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
