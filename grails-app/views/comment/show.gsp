
<%@ page import="unapp.Comment" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'comment.label', default: 'Comment')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-comment" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-comment" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list comment">
			
				<g:if test="${commentInstance?.teacher}">
				<li class="fieldcontain">
					<span id="teacher-label" class="property-label"><g:message code="comment.teacher.label" default="Teacher" /></span>
					
						<span class="property-value" aria-labelledby="teacher-label"><g:link controller="teacher" action="show" id="${commentInstance?.teacher?.id}">${commentInstance?.teacher?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.course}">
				<li class="fieldcontain">
					<span id="course-label" class="property-label"><g:message code="comment.course.label" default="Course" /></span>
					
						<span class="property-value" aria-labelledby="course-label"><g:link controller="course" action="show" id="${commentInstance?.course?.id}">${commentInstance?.course?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.likes}">
				<li class="fieldcontain">
					<span id="likes-label" class="property-label"><g:message code="comment.likes.label" default="Likes" /></span>
					
						<g:each in="${commentInstance.likes}" var="l">
						<span class="property-value" aria-labelledby="likes-label"><g:link controller="votes" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.author}">
				<li class="fieldcontain">
					<span id="author-label" class="property-label"><g:message code="comment.author.label" default="Author" /></span>
					
						<span class="property-value" aria-labelledby="author-label"><g:link controller="user" action="show" id="${commentInstance?.author?.id}">${commentInstance?.author?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.body}">
				<li class="fieldcontain">
					<span id="body-label" class="property-label"><g:message code="comment.body.label" default="Body" /></span>
					
						<span class="property-value" aria-labelledby="body-label"><g:fieldValue bean="${commentInstance}" field="body"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="comment.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${commentInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.negativeVotes}">
				<li class="fieldcontain">
					<span id="negativeVotes-label" class="property-label"><g:message code="comment.negativeVotes.label" default="Negative Votes" /></span>
					
						<span class="property-value" aria-labelledby="negativeVotes-label"><g:fieldValue bean="${commentInstance}" field="negativeVotes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${commentInstance?.positiveVotes}">
				<li class="fieldcontain">
					<span id="positiveVotes-label" class="property-label"><g:message code="comment.positiveVotes.label" default="Positive Votes" /></span>
					
						<span class="property-value" aria-labelledby="positiveVotes-label"><g:fieldValue bean="${commentInstance}" field="positiveVotes"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:commentInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${commentInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
