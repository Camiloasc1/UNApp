
<%@ page import="unapp.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-user" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.likes}">
				<li class="fieldcontain">
					<span id="likes-label" class="property-label"><g:message code="user.likes.label" default="Likes" /></span>
					
						<g:each in="${userInstance.likes}" var="l">
						<span class="property-value" aria-labelledby="likes-label"><g:link controller="votes" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="user.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${userInstance}" field="email"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.googleID}">
				<li class="fieldcontain">
					<span id="googleID-label" class="property-label"><g:message code="user.googleID.label" default="Google ID" /></span>
					
						<span class="property-value" aria-labelledby="googleID-label"><g:fieldValue bean="${userInstance}" field="googleID"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.isAdmin}">
				<li class="fieldcontain">
					<span id="isAdmin-label" class="property-label"><g:message code="user.isAdmin.label" default="Is Admin" /></span>
					
						<span class="property-value" aria-labelledby="isAdmin-label"><g:formatBoolean boolean="${userInstance?.isAdmin}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="user.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${userInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.negativeVotes}">
				<li class="fieldcontain">
					<span id="negativeVotes-label" class="property-label"><g:message code="user.negativeVotes.label" default="Negative Votes" /></span>
					
						<span class="property-value" aria-labelledby="negativeVotes-label"><g:fieldValue bean="${userInstance}" field="negativeVotes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.positiveVotes}">
				<li class="fieldcontain">
					<span id="positiveVotes-label" class="property-label"><g:message code="user.positiveVotes.label" default="Positive Votes" /></span>
					
						<span class="property-value" aria-labelledby="positiveVotes-label"><g:fieldValue bean="${userInstance}" field="positiveVotes"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:userInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${userInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
