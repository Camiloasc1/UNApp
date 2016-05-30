<div id="search-advance" ng-controller="CommentsFilter">
    <div class="input-group form-group">
        <input type="text" id="searchComments" class="form-control input-lg" ng-model="searchFilter[0]"
               placeholder="Buscar en comentarios" />
        <span class="input-group-btn">
            <button id="ButtonSearchComments" type="button" ng-click="advancedSearch()" class="btn btn-info btn-lg">
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
        <div>
            <div class="text-left">
                <label> Por votos: </label>
            </div>
            <div class="container">
                <input type="checkbox" id="t_up" name="t_up" style="display:none" ng-model="searchFilter[1]">
                <i class="material-icons positive-vote" onclick="selectVote(this)">
                    thumb_up
                </i>
                <input type="checkbox" id="t_dwn" name="t_dwn" style="display:none" ng-model="searchFilter[1]">
                <i class="material-icons negative-vote" onclick="selectVote(this)">
                    thumb_down
                </i>
            </div>
        </div>
        <br>
        <div class="form-group no-top">
            <g:if test="${request.forwardURI.toLowerCase().find("course")}">
                <div class="text-left">
                    <label> Por profesor(es): </label>
                </div>
                <select id="sel-materias" name="sel-materias" multiple>
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
            <select name="select-date" id="select-date">
                <option value="1">Cualquier fecha</option>
                <option value="2">Ayer</option>
                <option value="3">Hace una semana</option>
                <option value="4">Hace un mes</option>
                <option value="5">Hace un año</option>
                <option value="6">Personalizado</option>
            </select>


        </div>
        <div class="text-center" ng-show="loading">
            <br/>
            <i class="fa fa-spinner fa-pulse fa-5x"></i>
            <span class="sr-only">Cargando...</span>
        </div>
    </div>
</div>