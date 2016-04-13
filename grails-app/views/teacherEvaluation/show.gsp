
<%@ page import="unapp.TeacherEvaluation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teacherEvaluation.label', default: 'TeacherEvaluation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-teacherEvaluation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-teacherEvaluation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list teacherEvaluation">
			
				<g:if test="${teacherEvaluationInstance?.author}">
				<li class="fieldcontain">
					<span id="author-label" class="property-label"><g:message code="teacherEvaluation.author.label" default="Author" /></span>
					
						<span class="property-value" aria-labelledby="author-label"><g:link controller="user" action="show" id="${teacherEvaluationInstance?.author?.id}">${teacherEvaluationInstance?.author?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${teacherEvaluationInstance?.explanation}">
				<li class="fieldcontain">
					<span id="explanation-label" class="property-label"><g:message code="teacherEvaluation.explanation.label" default="Explanation" /></span>
					
						<span class="property-value" aria-labelledby="explanation-label"><g:fieldValue bean="${teacherEvaluationInstance}" field="explanation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teacherEvaluationInstance?.gradeMethod}">
				<li class="fieldcontain">
					<span id="gradeMethod-label" class="property-label"><g:message code="teacherEvaluation.gradeMethod.label" default="Grade Method" /></span>
					
						<span class="property-value" aria-labelledby="gradeMethod-label"><g:fieldValue bean="${teacherEvaluationInstance}" field="gradeMethod"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teacherEvaluationInstance?.knowledge}">
				<li class="fieldcontain">
					<span id="knowledge-label" class="property-label"><g:message code="teacherEvaluation.knowledge.label" default="Knowledge" /></span>
					
						<span class="property-value" aria-labelledby="knowledge-label"><g:fieldValue bean="${teacherEvaluationInstance}" field="knowledge"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teacherEvaluationInstance?.overall}">
				<li class="fieldcontain">
					<span id="overall-label" class="property-label"><g:message code="teacherEvaluation.overall.label" default="Overall" /></span>
					
						<span class="property-value" aria-labelledby="overall-label"><g:fieldValue bean="${teacherEvaluationInstance}" field="overall"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teacherEvaluationInstance?.punctuality}">
				<li class="fieldcontain">
					<span id="punctuality-label" class="property-label"><g:message code="teacherEvaluation.punctuality.label" default="Punctuality" /></span>
					
						<span class="property-value" aria-labelledby="punctuality-label"><g:fieldValue bean="${teacherEvaluationInstance}" field="punctuality"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teacherEvaluationInstance?.teacher}">
				<li class="fieldcontain">
					<span id="teacher-label" class="property-label"><g:message code="teacherEvaluation.teacher.label" default="Teacher" /></span>
					
						<span class="property-value" aria-labelledby="teacher-label"><g:link controller="teacher" action="show" id="${teacherEvaluationInstance?.teacher?.id}">${teacherEvaluationInstance?.teacher?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:teacherEvaluationInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${teacherEvaluationInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
