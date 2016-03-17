<%--
  Created by IntelliJ IDEA.
  User: kevincastro
  Date: 3/16/16
  Time: 2:33 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login Index</title>

    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="${request.contextPath}/login-page/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${request.contextPath}/login-page/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="${request.contextPath}/login-page//css/form-elements.css">
    <link rel="stylesheet" href="${request.contextPath}/login-page/css/style.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="${request.contextPath}/login-page/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${request.contextPath}/login-page/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${request.contextPath}/login-page/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${request.contextPath}/login-page/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${request.contextPath}/login-page/ico/apple-touch-icon-57-precomposed.png">


</head>

<body>


<!-- Top content -->
<div class="top-content">
    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1 style="color:#5ecfff;"><strong>Iniciar sesion</strong> UN-App</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>Ingresa a nuestro sitio</h3>
                            <p>Ingresar con la cuenta google de la universidad:</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-lock"></i>
                        </div>
                    </div>
                    <div class="form-bottom">
                        <div role="form" action="" method="post" class="login-form">
                            <div class="centered">
                                <oauth:disconnected provider="google">
                                <oauth:connect provider="google">
                                    <button type="button"  class="btn  btn-link-2 ">
                                        <i class="fa fa-google "></i> Entrar con google
                                    </button>
                                </oauth:connect>
                                </oauth:disconnected>
                                <oauth:connected provider="google">
                                    <g:link controller="Login" action="revoke" id="google" title="Google">
                                        <button type="button" class="btn btn-primary">Cerrar sesion</button>
                                    </g:link>
                                </oauth:connected>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 social-login">
                    <h3 style="color:#5ecfff;">Nuestras redes:</h3>
                    <div class="social-login-buttons">
                        <a class="btn btn-link-2" href="#">
                            <i class="fa fa-facebook"></i> Facebook
                        </a>
                        <a class="btn btn-link-2" href="#">
                            <i class="fa fa-twitter"></i> Twitter
                            <a/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<!-- Javascript -->
<script src="${request.contextPath}/login-page/js/jquery-1.11.1.min.js"></script>
<script src="${request.contextPath}/login-page/bootstrap/js/bootstrap.min.js"></script>
<script src="${request.contextPath}/login-page/js/jquery.backstretch.min.js"></script>
<script src="${request.contextPath}/login-page/js/scripts.js"></script>

<!--[if lt IE 10]>
            <script src="${request.contextPath}/login-page/js/placeholder.js"></script>
        <![endif]-->

</body>

</html>