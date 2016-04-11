<%@ page import="unapp.Degree" %>



<div class="fieldcontain ${hasErrors(bean: degreeInstance, field: 'code', 'error')} required">
	<label for="code">
		<g:message code="degree.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="code" type="number" value="${degreeInstance.code}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: degreeInstance, field: 'courses', 'error')} ">
	<label for="courses">
		<g:message code="degree.courses.label" default="Courses" />
		
	</label>
	<g:select name="courses" from="${unapp.Course.list()}" multiple="multiple" optionKey="id" size="5" value="${degreeInstance?.courses*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: degreeInstance, field: 'location', 'error')} required">
	<label for="location">
		<g:message code="degree.location.label" default="Location" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="location" name="location.id" from="${unapp.Location.list()}" optionKey="id" required="" value="${degreeInstance?.location?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: degreeInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="degree.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${degreeInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: degreeInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="degree.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="type" required="" value="${degreeInstance?.type}"/>

</div>

