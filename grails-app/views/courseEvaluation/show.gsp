
<%@ page import="unapp.CourseEvaluation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'courseEvaluation.label', default: 'CourseEvaluation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-courseEvaluation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-courseEvaluation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list courseEvaluation">
			
				<g:if test="${courseEvaluationInstance?.author}">
				<li class="fieldcontain">
					<span id="author-label" class="property-label"><g:message code="courseEvaluation.author.label" default="Author" /></span>
					
						<span class="property-value" aria-labelledby="author-label"><g:link controller="user" action="show" id="${courseEvaluationInstance?.author?.id}">${courseEvaluationInstance?.author?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${courseEvaluationInstance?.course}">
				<li class="fieldcontain">
					<span id="course-label" class="property-label"><g:message code="courseEvaluation.course.label" default="Course" /></span>
					
						<span class="property-value" aria-labelledby="course-label"><g:link controller="course" action="show" id="${courseEvaluationInstance?.course?.id}">${courseEvaluationInstance?.course?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${courseEvaluationInstance?.overall}">
				<li class="fieldcontain">
					<span id="overall-label" class="property-label"><g:message code="courseEvaluation.overall.label" default="Overall" /></span>
					
						<span class="property-value" aria-labelledby="overall-label"><g:fieldValue bean="${courseEvaluationInstance}" field="overall"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${courseEvaluationInstance?.workEffort}">
				<li class="fieldcontain">
					<span id="workEffort-label" class="property-label"><g:message code="courseEvaluation.workEffort.label" default="Work Effort" /></span>
					
						<span class="property-value" aria-labelledby="workEffort-label"><g:fieldValue bean="${courseEvaluationInstance}" field="workEffort"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:courseEvaluationInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${courseEvaluationInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
