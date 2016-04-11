<%@ page import="unapp.CourseEvaluation" %>



<div class="fieldcontain ${hasErrors(bean: courseEvaluationInstance, field: 'author', 'error')} required">
	<label for="author">
		<g:message code="courseEvaluation.author.label" default="Author" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="author" name="author.id" from="${unapp.User.list()}" optionKey="id" required="" value="${courseEvaluationInstance?.author?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: courseEvaluationInstance, field: 'course', 'error')} required">
	<label for="course">
		<g:message code="courseEvaluation.course.label" default="Course" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="course" name="course.id" from="${unapp.Course.list()}" optionKey="id" required="" value="${courseEvaluationInstance?.course?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: courseEvaluationInstance, field: 'overall', 'error')} required">
	<label for="overall">
		<g:message code="courseEvaluation.overall.label" default="Overall" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="overall" type="number" value="${courseEvaluationInstance.overall}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: courseEvaluationInstance, field: 'workEffort', 'error')} required">
	<label for="workEffort">
		<g:message code="courseEvaluation.workEffort.label" default="Work Effort" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="workEffort" type="number" value="${courseEvaluationInstance.workEffort}" required=""/>

</div>

