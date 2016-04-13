<%@ page import="unapp.Teacher" %>



<div class="fieldcontain ${hasErrors(bean: teacherInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="teacher.comments.label" default="Comments" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${teacherInstance?.comments?}" var="c">
    <li><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="comment" action="create" params="['teacher.id': teacherInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'comment.label', default: 'Comment')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: teacherInstance, field: 'username', 'error')} ">
	<label for="username">
		<g:message code="teacher.username.label" default="Username" />
		
	</label>
	<g:textField name="username" value="${teacherInstance?.username}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherInstance, field: 'courses', 'error')} ">
	<label for="courses">
		<g:message code="teacher.courses.label" default="Courses" />
		
	</label>
	<g:select name="courses" from="${unapp.Course.list()}" multiple="multiple" optionKey="id" size="5" value="${teacherInstance?.courses*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherInstance, field: 'evaluations', 'error')} ">
	<label for="evaluations">
		<g:message code="teacher.evaluations.label" default="Evaluations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${teacherInstance?.evaluations?}" var="e">
    <li><g:link controller="teacherEvaluation" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="teacherEvaluation" action="create" params="['teacher.id': teacherInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'teacherEvaluation.label', default: 'TeacherEvaluation')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: teacherInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="teacher.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${teacherInstance?.name}"/>

</div>

