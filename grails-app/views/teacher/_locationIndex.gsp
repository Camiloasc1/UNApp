<br/>
<ul class="nav nav-pills nav-justified">
    <g:each in="${("A".."Z")}" status="i" var="letter">
        <!--
        <g:if test="${i == 13}">
            <br/>
        </g:if>
        -->
        <g:if test="${i == 0}">
            <li class="active"><a data-toggle="pill" href="#${it.name}Tab${letter}">${letter}</a></li>
        </g:if>
        <g:else>
            <li><a data-toggle="pill" href="#${it.name}Tab${letter}">${letter}</a></li>
        </g:else>
    </g:each>
</ul>

<div class="tab-content">
    <g:each in="${("A".."Z")}" status="i" var="letter">
        <g:if test="${i == 0}">
            <div id="${it.name}Tab${letter}" class="tab-pane fade in active">
                <g:render template="indexTable"
                          bean="${it.teachers.findAll { c -> c.name.toUpperCase().startsWith("${letter}") }}"/>
            </div>
        </g:if>
        <g:else>
            <div id="${it.name}Tab${letter}" class="tab-pane fade">
                <g:render template="indexTable"
                          bean="${it.teachers.findAll { c -> c.name.toUpperCase().startsWith("${letter}") }}"/>
            </div>
        </g:else>
    </g:each>
</div>