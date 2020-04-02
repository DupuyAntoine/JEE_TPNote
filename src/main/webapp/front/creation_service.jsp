<%-- 
    Document   : creation_service
    Created on : 2 avr. 2020, 14:19:47
    Author     : AdminEtu
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Context initCtx=null;
        try {
            initCtx = new InitialContext();
        } catch (NamingException ex) {
            System.out.println("Erreur de chargement du service de nommage");
        }
        // Connexion ? la base de donn?es enregistr?e dans le serveur de nom sous le nom "sample"
        Object refRecherchee = initCtx.lookup("jdbc/__default");
        DataSource ds = (DataSource)refRecherchee;
        Connection con = ds.getConnection();

        Statement ps = con.createStatement();

        ResultSet rs = ps.executeQuery("select * from USER");
        
        HttpSession userSession = request.getSession();

        if (userSession.getAttribute("identifiant") != null) {
        %>
            <h1>Page accueil service!</h1>
        <%
        } else {
        %>
            <h1>Vous n'êtes pas connecté !</h1>
            <a href='./accueil.jsp'>Retour Connexion</a>
        <%
        }
        %>
    </body>
</html>
