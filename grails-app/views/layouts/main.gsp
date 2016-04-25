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
    <base href="${request.forwardURI}">
    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-default navbar-fixed-top">
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
                <li class="page-scroll">
                    <a href="${createLink(controller: 'course', action: 'index')}"><h4>Materias</h4></a>
                </li>
                <li class="dropdown">
                    <a href="#" data-target="#" class="dropdown-toggle" data-toggle="dropdown"><h4>Nosotros
                        <span class="caret"></span></h4>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${createLink(uri: '/')}#portfolio">Desarrolladores</a></li>
                        <li><a href="${createLink(uri: '/')}#about">Acerca</a></li>
                        <li><a href="${createLink(uri: '/')}#contact">Contactenos</a></li>
                    </ul>
                </li>
                <unapp:isAdmin>
                    <li class="page-scroll">
                        <a href="${createLink(controller: 'admin', action: 'index')}"><h4><i class="fa fa-cogs"></i> Administacion</h4></a>
                    </li>
                </unapp:isAdmin>
            </ul>

            <ul class="nav navbar-nav navbar-right">
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

<div class="main-content">
    <g:layoutBody/>
</div>

<div id="footer"></div>

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
</body>
</html>

