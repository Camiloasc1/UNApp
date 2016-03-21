<%--
  Created by IntelliJ IDEA.
  User: camiloasc1
  Date: 22/02/16
  Time: 07:06 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login Success</title>
</head>

<body>
Login Success
<table>
    <tr><th>Key</th><th>Value</th></tr>
    <g:each var="it" in="${data}">
        <tr><td>${it.key}</td><td>${it.value}</td></tr>
    </g:each>
</table>
</body>
</html>