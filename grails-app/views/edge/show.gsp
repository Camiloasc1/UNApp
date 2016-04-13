
<%@ page import="unapp.Edge" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'edge.label', default: 'Edge')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-edge" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-edge" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list edge">
			
				<g:if test="${edgeInstance?.degree}">
				<li class="fieldcontain">
					<span id="degree-label" class="property-label"><g:message code="edge.degree.label" default="Degree" /></span>
					
						<span class="property-value" aria-labelledby="degree-label"><g:link controller="degree" action="show" id="${edgeInstance?.degree?.id}">${edgeInstance?.degree?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${edgeInstance?.next}">
				<li class="fieldcontain">
					<span id="next-label" class="property-label"><g:message code="edge.next.label" default="Next" /></span>
					
						<span class="property-value" aria-labelledby="next-label"><g:link controller="course" action="show" id="${edgeInstance?.next?.id}">${edgeInstance?.next?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${edgeInstance?.prev}">
				<li class="fieldcontain">
					<span id="prev-label" class="property-label"><g:message code="edge.prev.label" default="Prev" /></span>
					
						<span class="property-value" aria-labelledby="prev-label"><g:link controller="course" action="show" id="${edgeInstance?.prev?.id}">${edgeInstance?.prev?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:edgeInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${edgeInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
