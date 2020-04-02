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

        ResultSet rs = ps.executeQuery("select * from CATEGORY");
        
        HttpSession userSession = request.getSession();
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String cost = request.getParameter("cost");
        String category = request.getParameter("category");
        
        if (
            title != null &&
            description != null &&
            location != null &&
            cost != null &&
            category != null
           ) {
            Integer userId = Integer.parseInt((String)userSession.getAttribute("id"));
            ps.executeUpdate("INSERT INTO "
            + "SERVICE(TITLE, DESCRIPTION, LOCATION, COST, CATEGORYID, USERID)"
            + " VALUES "
            + "('" + title + "', '" + description + "', '" + location + "', " + Float.parseFloat(cost) + ", " + Integer.parseInt(category) + ", " + userId + ")");
            
        } else {
            if (userSession.getAttribute("identifiant") != null) {
            %>
                <h1>Création de service</h1>
                <form action="creation_service.jsp" method="post">
                    <table>
                        <tr>
                            <td><label for="title">Titre : </label></td>
                            <td><input type="text" name="title" id="title" required></td>
                            <td><label for="description">Description : </label></td>
                            <td><input type="text" name="description" id="description" required></td>
                            <td><label for="location">Durée : </label></td>
                            <td>
                                <select name="location" id="location" required>
                                    <option value="heure">Heure</option>
                                    <option value="demijournee">Demi-journée</option>
                                    <option value="jour">Jour</option>
                                    <option value="semaine">Semaine</option>
                                </select>
                            </td>
                            <td><label for="cost">Coût : </label></td>
                            <td><input type="text" name="cost" id="cost" required></td>
                            <td><label for="category">Categorie : </label></td>
                            <td>
                                <select name="category" id="category" required>
                                    <option value="">Choisir</option>
                                    <%
                                    while (rs.next()) {
                                    %>
                                    <option value="<%=rs.getString("ID")%>"><%= rs.getString("NAME")%></option>
                                    <%
                                    }
                                    %>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <div>
                        <input type="submit" value="Envoyer">
                    </div>
                </form>
            <%
            } else {
            %>
                <h1>Vous n'êtes pas connecté !</h1>
                <a href='./accueil.jsp'>Retour Connexion</a>
            <%
            }
        }
        %>
    </body>
</html>
