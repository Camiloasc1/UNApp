<%--
  Created by IntelliJ IDEA.
  User: camiloasc1
  Date: 22/02/16
  Time: 12:44 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Login</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-sm-6">
            <p>Para acceder a la plataforma ingrese con su cuenta institucional (@unal.edu.co)</p>
        </div>
        <div class="col-sm-6">
            <oauth:disconnected provider="google">
                <oauth:connect provider="google">
                    <button type="button" class="btn btn-primary">Login With Google</button>
                </oauth:connect>
            </oauth:disconnected>
            <oauth:connected provider="google">
                <g:link controller="Login" action="revoke" id="google" title="Google">
                    <button type="button" class="btn btn-primary">Log Out</button>
                </g:link>
            </oauth:connected>
        </div>
    </div>
</div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</body>
</html>