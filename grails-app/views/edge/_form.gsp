<%@ page import="unapp.Edge" %>



<div class="fieldcontain ${hasErrors(bean: edgeInstance, field: 'degree', 'error')} required">
	<label for="degree">
		<g:message code="edge.degree.label" default="Degree" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="degree" name="degree.id" from="${unapp.Degree.list()}" optionKey="id" required="" value="${edgeInstance?.degree?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: edgeInstance, field: 'next', 'error')} required">
	<label for="next">
		<g:message code="edge.next.label" default="Next" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="next" name="next.id" from="${unapp.Course.list()}" optionKey="id" required="" value="${edgeInstance?.next?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: edgeInstance, field: 'prev', 'error')} required">
	<label for="prev">
		<g:message code="edge.prev.label" default="Prev" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="prev" name="prev.id" from="${unapp.Course.list()}" optionKey="id" required="" value="${edgeInstance?.prev?.id}" class="many-to-one"/>

</div>

