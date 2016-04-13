
<%@ page import="unapp.Course" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'course.label', default: 'Course')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-course" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-course" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list course">
			
				<g:if test="${courseInstance?.comments}">
				<li class="fieldcontain">
					<span id="comments-label" class="property-label"><g:message code="course.comments.label" default="Comments" /></span>
					
						<g:each in="${courseInstance.comments}" var="c">
						<span class="property-value" aria-labelledby="comments-label"><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${courseInstance?.teachers}">
				<li class="fieldcontain">
					<span id="teachers-label" class="property-label"><g:message code="course.teachers.label" default="Teachers" /></span>
					
						<g:each in="${courseInstance.teachers}" var="t">
						<span class="property-value" aria-labelledby="teachers-label"><g:link controller="teacher" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${courseInstance?.evaluations}">
				<li class="fieldcontain">
					<span id="evaluations-label" class="property-label"><g:message code="course.evaluations.label" default="Evaluations" /></span>
					
						<g:each in="${courseInstance.evaluations}" var="e">
						<span class="property-value" aria-labelledby="evaluations-label"><g:link controller="courseEvaluation" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${courseInstance?.location}">
				<li class="fieldcontain">
					<span id="location-label" class="property-label"><g:message code="course.location.label" default="Location" /></span>
					
						<span class="property-value" aria-labelledby="location-label"><g:fieldValue bean="${courseInstance}" field="location"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${courseInstance?.typology}">
				<li class="fieldcontain">
					<span id="typology-label" class="property-label"><g:message code="course.typology.label" default="Typology" /></span>
					
						<span class="property-value" aria-labelledby="typology-label"><g:fieldValue bean="${courseInstance}" field="typology"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${courseInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="course.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${courseInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${courseInstance?.code}">
				<li class="fieldcontain">
					<span id="code-label" class="property-label"><g:message code="course.code.label" default="Code" /></span>
					
						<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${courseInstance}" field="code"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${courseInstance?.credits}">
				<li class="fieldcontain">
					<span id="credits-label" class="property-label"><g:message code="course.credits.label" default="Credits" /></span>
					
						<span class="property-value" aria-labelledby="credits-label"><g:fieldValue bean="${courseInstance}" field="credits"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:courseInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${courseInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
