<div id="search-advance">
    <div class="input-group form-group">
        <input type="text" id="searchComments" class="form-control input-lg"
               placeholder="Buscar en comentarios" />
        <span class="input-group-btn">
            <button id="ButtonSearchComments" type="button" class="btn btn-info btn-lg">
                <i class="glyphicon glyphicon-search"></i>
            </button>
        </span>

    </div>
    <div class="text-center">
        <span id="advanceSearch" onclick="AdvanceSearch(this)">
            Busqueda Avanzada
            <span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>
        </span>
    </div>
    <br>
    <div id="advanceOption" style="display: none;">
        <div id="by-votes">
            <div class="text-left">
                <label> Por votos: </label>
            </div>
            <div class="container">
                <i class="material-icons positive-vote" onclick="selectVote(this)">thumb_up</i>
                <i class="material-icons negative-vote" onclick="selectVote(this)">thumb_down</i>
            </div>
        </div>
        <br>
        <div class="form-group no-top">
            <g:if test="${request.forwardURI.toLowerCase().find("course")}">
                <div class="text-left">
                    <label> Por profesor(es): </label>
                </div>
                <select id="sel-materias" multiple="multiple">
                    <g:each in="${result.teachers}" status="i" var="teacher">
                        <option value="${teacher.id}">${teacher.name}</option>
                    </g:each>
                </select>
            </g:if>
            <g:if test="${request.forwardURI.toLowerCase().find("teacher")}">
                <div class="text-left">
                    <label> Por materia(s): </label>
                </div>
                <select id="sel-materias" multiple="multiple">
                    <g:each in="${result.courses}" status="i" var="course">
                        <option value="${course.id}">${course.name}</option>
                    </g:each>
                </select>
            </g:if>

        </div>
        <div class="form-group no-top">
            <div class="text-left">
                <label> Por fecha: </label>
            </div>
            <select id="select-date" onchange="createDate()">
                <option value="1">Cualquier fecha</option>
                <option value="2">Ayer</option>
                <option value="3">Hace una semana</option>
                <option value="4">Hace un mes</option>
                <option value="5">Hace un año</option>
                <option value="6">Personalizado</option>
            </select>


        </div>
        <div id="fecha-desde">

        </div>
        <div id="fecha-hasta">

        </div>

    </div>
</div>