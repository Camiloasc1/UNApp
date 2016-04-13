
<%@ page import="unapp.CourseEvaluation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'courseEvaluation.label', default: 'CourseEvaluation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-courseEvaluation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-courseEvaluation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="courseEvaluation.author.label" default="Author" /></th>
					
						<th><g:message code="courseEvaluation.course.label" default="Course" /></th>
					
						<g:sortableColumn property="overall" title="${message(code: 'courseEvaluation.overall.label', default: 'Overall')}" />
					
						<g:sortableColumn property="workEffort" title="${message(code: 'courseEvaluation.workEffort.label', default: 'Work Effort')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${courseEvaluationInstanceList}" status="i" var="courseEvaluationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${courseEvaluationInstance.id}">${fieldValue(bean: courseEvaluationInstance, field: "author")}</g:link></td>
					
						<td>${fieldValue(bean: courseEvaluationInstance, field: "course")}</td>
					
						<td>${fieldValue(bean: courseEvaluationInstance, field: "overall")}</td>
					
						<td>${fieldValue(bean: courseEvaluationInstance, field: "workEffort")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${courseEvaluationInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
