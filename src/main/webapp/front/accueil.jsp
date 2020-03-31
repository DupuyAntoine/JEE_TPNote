<%-- 
    Document   : accueil
    Created on : 31 mars 2020, 11:27:28
    Author     : AdminEtu
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.Context"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>Accueil</title>
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

        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        
        HttpSession userSession = request.getSession();

        if (!email.equals("") && !pass.equals("")) {
            userSession.setAttribute("success", false);
        }

        while (rs.next()) {
            if (rs.getString("PASSWORD").equals(pass) && rs.getString("EMAIL").equals(email)) {
                userSession.setAttribute("identifiant", email);
                userSession.setAttribute("name", rs.getString("NAME"));
                userSession.setAttribute("firstname", rs.getString("FIRSTNAME"));
                userSession.setAttribute("success", true);
            }
        }
                
        if (userSession.getAttribute("identifiant") != null) {
        %>
        <div>
            <h1>Bienvenue <%= userSession.getAttribute("firstname") + " " +  userSession.getAttribute("name") %></h1>
        </div>
        <%
        } else if (userSession.getAttribute("identifiant") == null && userSession.getAttribute("success") == null) {
        %>
        <h1>Connexion</h1>
        <form action="accueil.jsp" method="post">
            <div>
                <label for="email">Email : </label>
                <input type="text" name="email" id="email" required>
            </div>
            <div>
                <label for="pass">Mot de passe : </label>
                <input type="text" name="pass" id="pass" required>
            </div>
            <div>
                <input type="submit" value="Envoyer">
            </div>
        </form>
        <div>
            <a href="./register.html">Page d'inscription</a>
        </div>
        <%
        } else if (userSession.getAttribute("success").equals(false)) {
        %>
        <h1>Erreur login</h1>
        <a href="./accueil.jsp">Retour login</a>
        <%
        }
        %>
    </body>
</html>
