<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
</head>

<body>
<div>
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
</div>
</body>
</html>
