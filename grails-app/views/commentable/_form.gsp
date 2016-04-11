<%@ page import="unapp.Commentable" %>



<div class="fieldcontain ${hasErrors(bean: commentableInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="commentable.comments.label" default="Comments" />
		
	</label>
	<g:select name="comments" from="${unapp.Comment.list()}" multiple="multiple" optionKey="id" size="5" value="${commentableInstance?.comments*.id}" class="many-to-many"/>

</div>

