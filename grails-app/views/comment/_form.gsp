<%@ page import="unapp.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'teacher', 'error')} ">
	<label for="teacher">
		<g:message code="comment.teacher.label" default="Teacher" />
		
	</label>
	<g:select id="teacher" name="teacher.id" from="${unapp.Teacher.list()}" optionKey="id" value="${commentInstance?.teacher?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'course', 'error')} ">
	<label for="course">
		<g:message code="comment.course.label" default="Course" />
		
	</label>
	<g:select id="course" name="course.id" from="${unapp.Course.list()}" optionKey="id" value="${commentInstance?.course?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'votes', 'error')} ">
	<label for="likes">
		<g:message code="comment.likes.label" default="Likes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${commentInstance?.likes?}" var="l">
    <li><g:link controller="vote" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="vote" action="create" params="['comment.id': commentInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'votes.label', default: 'Vote')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'author', 'error')} required">
	<label for="author">
		<g:message code="comment.author.label" default="Author" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="author" name="author.id" from="${unapp.User.list()}" optionKey="id" required="" value="${commentInstance?.author?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'body', 'error')} required">
	<label for="body">
		<g:message code="comment.body.label" default="Body" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="body" required="" value="${commentInstance?.body}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="comment.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${commentInstance?.date}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'negativeVotes', 'error')} required">
	<label for="negativeVotes">
		<g:message code="comment.negativeVotes.label" default="Negative Votes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="negativeVotes" type="number" value="${commentInstance.negativeVotes}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'positiveVotes', 'error')} required">
	<label for="positiveVotes">
		<g:message code="comment.positiveVotes.label" default="Positive Votes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="positiveVotes" type="number" value="${commentInstance.positiveVotes}" required=""/>

</div>

