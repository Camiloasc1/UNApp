<%--
  Created by IntelliJ IDEA.
  User: camiloasc1
  Date: 22/02/16
  Time: 12:44 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
</head>

<body>
    <oauth:connect provider="google">Connect to Google</oauth:connect>
    <oauth:connected provider="google">
        <br>
        <g:link controller="Login" action="revoke" id="google" title="Google">
            Revoke access
        </g:link>
    </oauth:connected>
</body>
</html>