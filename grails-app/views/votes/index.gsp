
<%@ page import="unapp.Votes" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'votes.label', default: 'Votes')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-votes" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-votes" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="votes.author.label" default="Author" /></th>
					
						<th><g:message code="votes.comment.label" default="Comment" /></th>
					
						<g:sortableColumn property="value" title="${message(code: 'votes.value.label', default: 'Value')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${votesInstanceList}" status="i" var="votesInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${votesInstance.id}">${fieldValue(bean: votesInstance, field: "author")}</g:link></td>
					
						<td>${fieldValue(bean: votesInstance, field: "comment")}</td>
					
						<td>${fieldValue(bean: votesInstance, field: "value")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${votesInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
