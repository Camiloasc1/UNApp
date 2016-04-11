<%@ page import="unapp.Votes" %>



<div class="fieldcontain ${hasErrors(bean: votesInstance, field: 'author', 'error')} required">
	<label for="author">
		<g:message code="votes.author.label" default="Author" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="author" name="author.id" from="${unapp.User.list()}" optionKey="id" required="" value="${votesInstance?.author?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: votesInstance, field: 'comment', 'error')} required">
	<label for="comment">
		<g:message code="votes.comment.label" default="Comment" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="comment" name="comment.id" from="${unapp.Comment.list()}" optionKey="id" required="" value="${votesInstance?.comment?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: votesInstance, field: 'value', 'error')} required">
	<label for="value">
		<g:message code="votes.value.label" default="Value" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="value" type="number" value="${votesInstance.value}" required=""/>

</div>

