<%@ page import="unapp.Course" %>
<%@ page import="unapp.Location" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
<div id="list-course" class="content scaffold-list" role="main">
    <h1>Materias</h1>

    <ul class="nav nav-pills">
        <g:each in="${locations}" status="i" var="location">
            <g:if test="${i == 0}">
                <li class="active"><a data-toggle="pill" href="#${location.name}Pill">${location.name}</a></li>
            </g:if>
            <g:else>
                <li><a data-toggle="pill" href="#${location.name}Pill">${location.name}</a></li>
            </g:else>
        </g:each>
    </ul>

    <div class="tab-content">
        <g:each in="${locations}" status="i" var="location">
            <g:if test="${i == 0}">
                <div id="${location.name}Pill" class="tab-pane fade in active">
                    <g:render template="table" bean="${courses[i]}"/>
                </div>
            </g:if>
            <g:else>
                <div id="${location.name}Pill" class="tab-pane fade">
                    <g:render template="table" bean="${courses[i]}"/>
                </div>
            </g:else>
        </g:each>
    </div>

    <table>
        <thead>
        <tr>

            <g:sortableColumn property="location"
                              title="${message(code: 'course.location.label', default: 'Location')}"/>

            <g:sortableColumn property="typology"
                              title="${message(code: 'course.typology.label', default: 'Typology')}"/>

            <g:sortableColumn property="name" title="${message(code: 'course.name.label', default: 'Name')}"/>

            <g:sortableColumn property="code" title="${message(code: 'course.code.label', default: 'Code')}"/>

            <g:sortableColumn property="credits"
                              title="${message(code: 'course.credits.label', default: 'Credits')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${courseInstanceList}" status="i" var="courseInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${courseInstance.id}">${fieldValue(bean: courseInstance, field: "location")}</g:link></td>

                <td>${fieldValue(bean: courseInstance, field: "typology")}</td>

                <td onclick="window.location = '${request.contextPath}/subject/index?id=${courseInstance.id}' ">${fieldValue(bean: courseInstance, field: "name")}</td>

                <td>${fieldValue(bean: courseInstance, field: "code")}</td>

                <td>${fieldValue(bean: courseInstance, field: "credits")}</td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${courseInstanceCount ?: 0}"/>
    </div>
</div>
</body>
</html>
