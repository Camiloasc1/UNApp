
<%@ page import="unapp.TeacherEvaluation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teacherEvaluation.label', default: 'TeacherEvaluation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-teacherEvaluation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-teacherEvaluation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="teacherEvaluation.author.label" default="Author" /></th>
					
						<g:sortableColumn property="explanation" title="${message(code: 'teacherEvaluation.explanation.label', default: 'Explanation')}" />
					
						<g:sortableColumn property="gradeMethod" title="${message(code: 'teacherEvaluation.gradeMethod.label', default: 'Grade Method')}" />
					
						<g:sortableColumn property="knowledge" title="${message(code: 'teacherEvaluation.knowledge.label', default: 'Knowledge')}" />
					
						<g:sortableColumn property="overall" title="${message(code: 'teacherEvaluation.overall.label', default: 'Overall')}" />
					
						<g:sortableColumn property="punctuality" title="${message(code: 'teacherEvaluation.punctuality.label', default: 'Punctuality')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${teacherEvaluationInstanceList}" status="i" var="teacherEvaluationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${teacherEvaluationInstance.id}">${fieldValue(bean: teacherEvaluationInstance, field: "author")}</g:link></td>
					
						<td>${fieldValue(bean: teacherEvaluationInstance, field: "explanation")}</td>
					
						<td>${fieldValue(bean: teacherEvaluationInstance, field: "gradeMethod")}</td>
					
						<td>${fieldValue(bean: teacherEvaluationInstance, field: "knowledge")}</td>
					
						<td>${fieldValue(bean: teacherEvaluationInstance, field: "overall")}</td>
					
						<td>${fieldValue(bean: teacherEvaluationInstance, field: "punctuality")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${teacherEvaluationInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
