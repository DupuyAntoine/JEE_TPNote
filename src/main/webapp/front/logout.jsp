<%-- 
    Document   : logout
    Created on : 2 avr. 2020, 16:51:05
    Author     : AdminEtu
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Déconnexion</title>
    </head>
    <body>
        <%
        HttpSession userSession = request.getSession();
        if (userSession != null) {
            userSession.invalidate();
            response.sendRedirect("./accueil.jsp");
        }
        %>
    </body>
</html>
