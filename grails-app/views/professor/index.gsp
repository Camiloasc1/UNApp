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
                        <img src="${request.contextPath}/images/Teacher-Plain.png" class="img-rounded center-block"
                             height="250"
                             width="250">

                        <h1 class="text-center">${t.name}</h1>
                        <h3 class="text-center">${t.location.name}</h3>

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
                        <h2>Información:</h2>
                        <div class="text-justify">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus elementum metus non nulla ultricies, ac pulvinar metus aliquet. Ut eu ex varius, lacinia ipsum ut, molestie elit. Proin sit amet orci scelerisque, auctor massa a, pellentesque purus. Praesent tellus felis, tincidunt eget sapien nec, placerat semper risus. Cras ultrices, mauris at condimentum aliquet, ante lorem efficitur mi, ac viverra nunc ipsum at quam. Integer tempus dolor est, id porta eros pulvinar sed. Nam condimentum lorem lectus, sit amet imperdiet orci faucibus in. In interdum sagittis metus quis pharetra. Quisque non purus auctor, rhoncus magna eget, rutrum libero. Pellentesque mauris magna, condimentum sit amet enim hendrerit, pretium egestas risus. Cras at sapien convallis ipsum maximus egestas sed ut libero.
                        </div>

                        <h2>Links:</h2>
                        <div class="text-justify"><a href="${t.getURL()}">Pagina docente</a></div>

                        <h2>Cursos:</h2>
                        <g:each in="${t.courses}">
                            <a href="${request.contextPath}/subject/index?id=${it.id}">${it.name}</a>
                            <br/>
                        </g:each>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <div class="jumbotron col-xs-12">
                <oauth:disconnected provider="google">
                    <oauth:connect provider="google">
                        <div class="text-center">
                            <button class="btn btn-raised btn-primary">
                                <i class="fa fa-google"></i> Ingresar con Google Para Comentar
                            </button>
                        </div>
                    </oauth:connect>
                </oauth:disconnected>
                <oauth:connected provider="google">
                    <form id="comentar-form">
                        <div class="col-lg-9 col-md-8">
                            <div class="form-group">
                                <input type="hidden" id="id" name="id" value="${t.id}"/>
                                <input type="hidden" id="offset" name="offset" value="${offset}"/>
                                <textarea name="body" id="body" rows="5" class="form-control"></textarea>
                            </div>
                        </div>

                        <div class="col-lg-3 col-md-4">
                            <button type="button" onclick="subirComentario()"
                                    class="btn btn-default btn-raised btn-block">Comentar</button>
                        </div>
                    </form>
                </oauth:connected>
            </div>
        </div>
    </div>
</div>
</body>
</html>