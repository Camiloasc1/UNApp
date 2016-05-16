<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div ng-app="CommentsApp" class="container subjectInfo">
    <div class="row">
        <div class="col-xs-12">
            <div class="jumbotron">
                <div class="row">
                    <div class="col-md-4 col-lg-5">
                        <img src="${assetPath(src: 'book.png')}" class="img-rounded center-block photo-size"
                             height="250"
                             width="250">

                        <h2 class="text-center">${result.name}</h2>

                        <h3 class="text-center">${result.code}</h3>

                        <h4 class="text-center">${result.location}</h4>

                        <div class="row text-center">
                            <g:render template="starRating"/>
                        </div>
                    </div>

                    <div class="col-md-8 col-lg-7">
                        <h2>Descripción:</h2>

                        <div class="text-justify">${result.description}</div>

                        <h2>Contenidos:</h2>

                        <div class="text-justify">${result.contents}</div>

                        <h2>Profesores:</h2>
                        <g:each in="${result.teachers}" status="i" var="teacher">
                            <a href="${request.contextPath}/teacher/show?id=${teacher.id}">${teacher.name}</a>
                            <br/>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <div class="jumbotron">
                <oauth:disconnected provider="google">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="text-center">
                                <oauth:connect provider="google"
                                               redirectUrl="${request.forwardURI.replace("/UNApp", "") + ((request.queryString) ? "?" + request.queryString : "")}">
                                    <button class="btn btn-raised btn-primary">
                                        <i class="fa fa-google"></i> Ingresar con Google Para Comentar
                                    </button>
                                </oauth:connect>
                            </div>
                        </div>
                    </div>
                </oauth:disconnected>
                <oauth:connected provider="google">
                    <g:render template="/comment/commentForm"/>
                </oauth:connected>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-4">
            <div class="jumbotron">
                <h2 class="text-right">Comentarios:</h2>
                <form>
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
                        <span id="advanceSearch" onclick="AdvanceSearch()">
                            Busqueda Avanzada
                            <span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>
                        </span>
                    </div>
                    <br>
                    <div id="advanceOption" >
                        <div>
                            <div class="text-left">
                                <label> Por votos: </label>
                            </div>
                            <div class="container">
                                <i class="material-icons positive-vote" onclick="selectVote(this)">thumb_up</i>
                                <i class="material-icons negative-vote" onclick="selectVote(this)">thumb_down</i>
                            </div>
                        </div>
                        <br>
                        <div class="form-group">
                            <label for="sel1">Por materia(s):</label>
                            <select class="form-control" id="sel1">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <div class="text-left">
                                <label for="sel2"> Por fecha: </label>
                            </div>
                            <select class="form-control" id="sel2">
                                <option>Ayer</option>
                                <option>Hace una semana</option>
                                <option>Hace un mes</option>
                                <option>Hace un año</option>
                            </select>

                        </div>

                    </div>

               </form>


            </div>
            <unapp:isAdmin>
                <div class="jumbotron">
                    <h2 class="text-center"><i class="fa fa-cogs"></i> Administrar</h2>
                </div>
            </unapp:isAdmin>
        </div>

        <div class="col-lg-8">
            <g:render template="/comment/comments"/>
        </div>
    </div>
</div>
</body>
</html>