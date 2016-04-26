<%@ page import="unapp.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'votes', 'error')} ">
	<label for="likes">
		<g:message code="user.likes.label" default="Likes" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${userInstance?.likes?}" var="l">
    <li><g:link controller="vote" action="show" id="${l.id}">${l?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="vote" action="create" params="['user.id': userInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'votes.label', default: 'Vote')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="email" required="" value="${userInstance?.email}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'googleID', 'error')} required">
	<label for="googleID">
		<g:message code="user.googleID.label" default="Google ID" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="googleID" required="" value="${userInstance?.googleID}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'isAdmin', 'error')} ">
	<label for="isAdmin">
		<g:message code="user.isAdmin.label" default="Is Admin" />
		
	</label>
	<g:checkBox name="isAdmin" value="${userInstance?.isAdmin}" />

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="user.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${userInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'negativeVotes', 'error')} required">
	<label for="negativeVotes">
		<g:message code="user.negativeVotes.label" default="Negative Votes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="negativeVotes" type="number" value="${userInstance.negativeVotes}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'positiveVotes', 'error')} required">
	<label for="positiveVotes">
		<g:message code="user.positiveVotes.label" default="Positive Votes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="positiveVotes" type="number" value="${userInstance.positiveVotes}" required=""/>

</div>

