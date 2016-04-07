<%@ page import="unapp.Course" %>



<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="course.comments.label" default="Comments" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${courseInstance?.comments?}" var="c">
    <li><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="comment" action="create" params="['course.id': courseInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'teachers', 'error')} ">
	<label for="teachers">
		<g:message code="course.teachers.label" default="Teachers" />
		
	</label>
	

</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'evaluations', 'error')} ">
	<label for="evaluations">
		<g:message code="course.evaluations.label" default="Evaluations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${courseInstance?.evaluations?}" var="e">
    <li><g:link controller="courseEvaluation" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="courseEvaluation" action="create" params="['course.id': courseInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'courseEvaluation.label', default: 'CourseEvaluation')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'location', 'error')} ">
	<label for="location">
		<g:message code="course.location.label" default="Location" />
		
	</label>
	<g:textField name="location" value="${courseInstance?.location}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'typology', 'error')} ">
	<label for="typology">
		<g:message code="course.typology.label" default="Typology" />
		
	</label>
	<g:textField name="typology" value="${courseInstance?.typology}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="course.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${courseInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'code', 'error')} required">
	<label for="code">
		<g:message code="course.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="code" required="" value="${courseInstance?.code}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: courseInstance, field: 'credits', 'error')} required">
	<label for="credits">
		<g:message code="course.credits.label" default="Credits" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="credits" type="number" value="${courseInstance.credits}" required=""/>

</div>

