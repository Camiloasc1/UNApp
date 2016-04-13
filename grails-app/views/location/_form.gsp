<%@ page import="unapp.Location" %>



<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="location.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${locationInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: locationInstance, field: 'url', 'error')} required">
	<label for="url">
		<g:message code="location.url.label" default="Url" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="url" required="" value="${locationInstance?.url}"/>

</div>

