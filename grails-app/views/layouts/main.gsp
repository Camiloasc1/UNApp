<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- <title><g:layoutTitle default="UNApp"/></title> -->
    <title>UNApp</title>

    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
    <!-- Bootstrap Material Design -->
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/css/bootstrap-material-design.css">
    <link rel="stylesheet" type="text/css" href="${request.contextPath}/css/ripples.min.css">
    <!-- Material Design Fonts -->
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700">
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/icon?family=Material+Icons">
    <!-- UNApp -->
    <asset:stylesheet src="unapp.css"/>
    <!-- HTML5 base -->
    <base href="${createLink(uri: '/')}">
    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-default">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainNavbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <!--<a class="navbar-brand" href="${createLink(uri: '/')}">UN-App</a>-->
            <a class="navbar-brand" href="${createLink(uri: '/')}">
                <img class="navbar-logo" src="${assetPath(src: 'unapp_logo.png')}" alt="UNApp logo">
            </a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="nav navbar-nav">
                <li class="hidden">
                    <a href="#page-top"></a>
                </li>
                <li class="page-scroll">
                    <a href="${createLink(controller: 'teacher', action: 'index')}"><h4>Profesores</h4></a>
                </li>
                <!--
                <form class="navbar-form navbar-left" method="get" action="teacher/search">
                    <div class="form-group is-empty">
                        <input type="text" name="query" class="form-control col-md-8" style="text-align: center"
                               placeholder="Buscar un profesor">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i>
                        </button>
                        <span class="material-input"></span>
                    </div>
                </form>
                -->
                <li class="page-scroll">
                    <a href="${createLink(controller: 'course', action: 'index')}"><h4>Materias</h4></a>
                </li>
                <li class="page-scroll">
                    <a href="${createLink( uri: '/about' )}"><h4>Acerca</h4></a>
                </li>
            <!--
                <form class="navbar-form navbar-left" method="get" action="course/search">
                    <div class="form-group is-empty">
                        <input type="text" name="query" class="form-control col-md-8" style="text-align: center"
                               placeholder="Buscar una materia">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i>
                        </button>
                        <span class="material-input"></span>
                    </div>
                </form>
                -->
                <unapp:isAdmin>
                    <li class="page-scroll">
                        <a href="${createLink(controller: 'admin', action: 'index')}"><h4><i class="fa fa-cogs"></i> Administacion</h4></a>
                    </li>
                </unapp:isAdmin>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li class="page-scroll">
                    <oauth:connected provider="google">
                        <a href="${request.contextPath}/user/show?id=${session.user.id}"><h4><i class="fa fa-user"></i> Mi cuenta </h4></a>
                    </oauth:connected>
                </li>
                <li>
                    <oauth:disconnected provider="google">
                        <oauth:connect provider="google"
                                       redirectUrl="${request.forwardURI.replace("/UNApp", "") + ((request.queryString) ? "?" + request.queryString : "")}">
                            <h4><i class="fa fa-google"></i> Ingresar con Google</h4>
                        </oauth:connect>
                    </oauth:disconnected>
                    <oauth:connected provider="google">
                        <g:link controller="Login" action="revoke" id="google" title="Google">
                            <h4><i class="fa fa-google"></i> Cerrar Sesion</h4>
                        </g:link>
                    </oauth:connected>
                </li>
            </ul>
        </div>
    </div>
</nav>

<g:layoutBody/>

<div id="footer">

    <footer class="footer-distributed">

        <div class="footer-right">

            <a href="https://www.facebook.com/UNapp-1700543420198446"><i class="fa fa-facebook"></i></a>
            <a href="https://twitter.com/unapp2016"><i class="fa fa-twitter"></i></a>
            <a href="https://github.com/UN-app/UNApp"><i class="fa fa-github"></i></a>

        </div>

        <div class="footer-left">

            <p class="footer-links">
                <a href="${createLink(uri: '/')}">Home</a>
                <a href="${createLink(uri: '/about')}">Acerca</a>
            </p>

            <p>UNapp &copy; 2016</p>
        </div>

    </footer>

</div>


<!-- AngularJS -->
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<!-- Material Design for Bootstrap -->
<script src="${request.contextPath}/js/material.min.js"></script>
<script src="${request.contextPath}/js/ripples.min.js"></script>
<script>
    $.material.init();
</script>
<!-- UNApp -->
<asset:javascript src="unapp.js"/>
<!-- AngularComments -->
<asset:javascript src="AngularComments.js"/>
<!-- AngularSearch -->
<asset:javascript src="AngularSearch.js"/>
<!-- AngularEditCourse -->
<asset:javascript src="AngularEditCourse.js"/>
<!-- AngularCreateCourse -->
<asset:javascript src="AngularCreateCourse.js"/>
<!-- AngularEditTeacher -->
<asset:javascript src="AngularEditTeacher.js"/>
<!-- AngularCreateTeacher -->
<asset:javascript src="AngularCreateTeacher.js"/>
</body>
</html>

