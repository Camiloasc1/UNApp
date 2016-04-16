<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="container subjectInfo">
    <div class="row">
        <div class="col-xs-12">
            <div class="jumbotron">
                <div class="row">
                    <div class="col-md-4 col-lg-5">
                        <img src="${assetPath(src: 'book.png')}" class="img-rounded center-block"
                             height="250"
                             width="250">

                        <h1 class="text-center">${result.name}</h1>

                        <h2 class="text-center">${result.code}</h2>

                        <h3 class="text-center">${result.location}</h3>

                        <div class="row text-center">
                            <ul class="star-rating">
                                <li class="star" id="1">&#9734;</li>
                                <li class="star" id="2">&#9734;</li>
                                <li class="star" id="3">&#9734;</li>
                                <li class="star" id="4">&#9734;</li>
                                <li class="star" id="5">&#9734;</li>
                            </ul>
                        </div>

                        <div class="col-xs-12 display-rating" style="text-align: center">Tu voto fue de:</div>

                    </div>

                    <div class="col-md-8 col-lg-7">
                        <h2>Descripción:</h2>

                        <div class="text-justify">${result.description}</div>

                        <h2>Contenidos:</h2>

                        <div class="text-justify">${result.contents}</div>

                        <h2>Profesores:</h2>
                        <g:each in="${result.teachers}" status="i" var="teacher">
                            <a href="#">${teacher.name}</a>
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
                <div class="row">
                    <oauth:disconnected provider="google">
                        <oauth:connect provider="google"
                                       redirectUrl="${request.forwardURI.replace("/UNApp", "") + ((request.queryString) ? "?" + request.queryString : "")}">
                            <div class="col-xs-12">
                                <div class="text-center">
                                    <button class="btn btn-raised btn-primary">
                                        <i class="fa fa-google"></i> Ingresar con Google Para Comentar
                                    </button>
                                </div>
                            </div>
                        </oauth:connect>
                    </oauth:disconnected>
                    <oauth:connected provider="google">
                        <form id="comentar-form">
                            <div class="col-lg-9 col-md-8">
                                <div class="form-group">
                                    <input type="hidden" id="id" name="id" value="${result.id}"/>
                                    <input type="hidden" id="offset" name="offset" value="${offset}"/>
                                    <textarea name="body" id="body" rows="5" class="form-control"></textarea>
                                </div>
                            </div>

                            <div class="col-lg-3 col-md-4">
                                <button type="button" onclick="subirComentario()"
                                        class="btn btn-default btn-raised btn-block">Comentar</button>
                                <!--<button type="button" class="btn btn-default btn-raised btn-block" onclick="document.getElementById('imagenComentario').click()">
                                    <i class="material-icons">photo</i>  Sube una imagen
                                </button>
                                <input type="file" id="imagenComentario" name="imagenComentario" style="display: none" /> -->
                            </div>
                        </form>
                    </oauth:connected>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-4">
            <div class="jumbotron">
                <h2 class="text-right">Comentarios:</h2>
            </div>
            <unapp:isAdmin>
                <div class="jumbotron">
                    <h2 class="text-center"><i class="fa fa-cogs"></i> Administrar</h2>
                </div>
            </unapp:isAdmin>
        </div>

        <div class="col-lg-8">
            <div class="jumbotron" id="container-comentarios">
                <div class="row">
                    <div id="comentarios-nuevos">
                        <g:each in="${result.comments}" var="comment">
                            <div class="comentario">
                                <div class="col-sm-1">
                                    <div class="thumbnail">
                                        <img class="img-responsive user-photo"
                                             src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                                    </div><!-- /thumbnail -->
                                </div><!-- /col-sm-1 -->

                                <div class="col-sm-11">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <strong>${comment.author}</strong> <span
                                                class="text-muted">${comment.date}</span>

                                            <div id="${comment.id}" style="float: right">
                                                <oauth:connected provider="google">
                                                    <i class="material-icons votes posiv-vote" onclick="upVotes(event)">thumb_up</i>
                                                </oauth:connected>
                                                <oauth:disconnected provider="google">
                                                    <i class="material-icons votes posiv-vote">thumb_up</i>
                                                </oauth:disconnected>
                                                <div class="votes content-vote positive-vote">
                                                    ${comment.positiveVotes}
                                                </div>
                                                <oauth:connected provider="google">
                                                    <i class="material-icons votes negav-vote" onclick="downVotes(event)">thumb_down</i>
                                                </oauth:connected>
                                                <oauth:disconnected provider="google">
                                                    <i class="material-icons votes negav-vote">thumb_down</i>
                                                </oauth:disconnected>
                                                <div class="votes negative-vote">
                                                    ${comment.negativeVotes}
                                                </div>
                                            </div>
                                        </div>

                                        <div class="panel-body">
                                            ${comment.body}
                                        </div><!-- /panel-body -->
                                    </div><!-- /panel panel-default -->
                                </div><!-- /sm-11 -->
                            </div>
                        </g:each>
                        <div id="comentarios-antiguos"></div>
                    </div>
                </div>

                <div class="row">
                    <div class="text-center">
                        <button class="btn btn-deafult btn-raised" type="button" name="ver-mas"
                                onclick="cargarComentariosPrev()">Ver Mas</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function upVotes(e) {
        var obj = e.target;

        $.post({
            url: "upVote",
            data: {id2: obj.parentNode.id},
            success: function (data, status) {
                var aux = $(e.target);
                var aux2 = data.split(" ");
                aux.next().html(aux2[0]);
                aux.next().next().next().html(aux2[1])
                var neg = obj.parentNode.getElementsByClassName("negav-vote")[0];
                $( neg).removeClass("sel-negav-vote");
                $(obj).addClass( "sel-posiv-vote" );
            }

        });
    }
    function downVotes(e) {
        var obj = e.target;
        $.post({
            url: "downVote",
            data: {id2: obj.parentNode.id},
            success: function (data, status) {
                var aux = $(e.target);
                var aux2 = data.split(" ");
                aux.prev().html(aux2[0]);
                aux.next().html(aux2[1]);
                var pos = obj.parentNode.getElementsByClassName("posiv-vote")[0];
                $( pos ).removeClass("sel-posiv-vote");
                $(obj).addClass( "sel-negav-vote" );
            }

        });
    }
    function subirComentario() {
        var offset = document.getElementsByClassName("comment").length;
        var body = document.getElementById("body").value;

        $.post({

            url: "comment",
            data: {id: ${result.id}, offset: offset, body: body},

            success: function (data, status) {
                //alert("Data: " + data + "\nStatus: " + status + offset);
                $("#comentarios-nuevos").prepend(data)
            }

        });

    }

    function cargarComentariosPrev() {
        var offset = document.getElementsByClassName("comentario").length;
        $.post({
            url: "cargarComentarios",
            data: {id: ${result.id}, offset: offset},

            success: function (data, status) {
                //alert("Data: " + data + "\nStatus: " + status + offset);
                $("#comentarios-nuevos").append(data)
            }
        });
    }
</script>
</body>
</html>