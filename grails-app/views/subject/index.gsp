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

                        <div class="col-xs-12 display-rating">Tu voto fue de:</div>

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
            <g:render template="commentForm"/>
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
            <g:render template="comments"/>
        </div>
    </div>
</div>
</body>
</html>