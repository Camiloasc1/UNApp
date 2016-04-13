<%@ page import="unapp.TeacherEvaluation" %>



<div class="fieldcontain ${hasErrors(bean: teacherEvaluationInstance, field: 'author', 'error')} required">
	<label for="author">
		<g:message code="teacherEvaluation.author.label" default="Author" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="author" name="author.id" from="${unapp.User.list()}" optionKey="id" required="" value="${teacherEvaluationInstance?.author?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherEvaluationInstance, field: 'explanation', 'error')} required">
	<label for="explanation">
		<g:message code="teacherEvaluation.explanation.label" default="Explanation" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="explanation" type="number" value="${teacherEvaluationInstance.explanation}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherEvaluationInstance, field: 'gradeMethod', 'error')} required">
	<label for="gradeMethod">
		<g:message code="teacherEvaluation.gradeMethod.label" default="Grade Method" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="gradeMethod" type="number" value="${teacherEvaluationInstance.gradeMethod}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherEvaluationInstance, field: 'knowledge', 'error')} required">
	<label for="knowledge">
		<g:message code="teacherEvaluation.knowledge.label" default="Knowledge" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="knowledge" type="number" value="${teacherEvaluationInstance.knowledge}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherEvaluationInstance, field: 'overall', 'error')} required">
	<label for="overall">
		<g:message code="teacherEvaluation.overall.label" default="Overall" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="overall" type="number" value="${teacherEvaluationInstance.overall}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherEvaluationInstance, field: 'punctuality', 'error')} required">
	<label for="punctuality">
		<g:message code="teacherEvaluation.punctuality.label" default="Punctuality" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="punctuality" type="number" value="${teacherEvaluationInstance.punctuality}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: teacherEvaluationInstance, field: 'teacher', 'error')} required">
	<label for="teacher">
		<g:message code="teacherEvaluation.teacher.label" default="Teacher" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="teacher" name="teacher.id" from="${unapp.Teacher.list()}" optionKey="id" required="" value="${teacherEvaluationInstance?.teacher?.id}" class="many-to-one"/>

</div>

