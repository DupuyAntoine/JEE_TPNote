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
        <title>Recherche de service</title>
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
        Object refRecherchee = initCtx.lookup("jdbc/tp3");
        DataSource ds = (DataSource)refRecherchee;
        Connection con = ds.getConnection();

        Statement ps = con.createStatement();
        Statement ps2 = con.createStatement();
        
        HttpSession userSession = request.getSession();
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String cost = request.getParameter("cost");
        String category = request.getParameter("category");
        Integer userId = Integer.parseInt((String)userSession.getAttribute("id"));
        
        String sql = "SELECT * FROM SERVICE WHERE USERID=" + userId;
        if (title != null) {
            if (!title.equals("")) sql += " AND TITLE='" + title + "'";
        }
        if (description != null) {
            if (!description.equals("")) sql += " AND DESCRIPTION='" + description + "'";
        }
        if (location != null) {
            if (!location.equals("")) sql += " AND LOCATION='" + location + "'";
        }
        if (cost != null) {
            if (!cost.equals("")) sql += " AND COST=" + Float.parseFloat(cost);
        }
        if (category != null) {
            if (!category.equals("")) sql += " AND CATEGORYID=" + Integer.parseInt(category);
        }
        
        ResultSet results = ps.executeQuery(sql + ";");
        ResultSet rs = ps2.executeQuery("select * from CATEGORY");
        if (userSession.getAttribute("identifiant") != null) {
        %>
            <h1>Recherche de service</h1>
            <form action="recherche.jsp" method="post">
                <table>
                    <tr>
                        <td><label for="title">Titre : </label></td>
                        <td><input type="text" name="title" id="title"></td>
                        <td><label for="description">Description : </label></td>
                        <td><input type="text" name="description" id="description"></td>
                        <td><label for="location">Durée : </label></td>
                        <td>
                            <select name="location" id="location">
                                <option value="heure">Heure</option>
                                <option value="demijournee">Demi-journée</option>
                                <option value="jour">Jour</option>
                                <option value="semaine">Semaine</option>
                            </select>
                        </td>
                        <td><label for="cost">Coût : </label></td>
                        <td><input type="text" name="cost" id="cost"></td>
                        <td><label for="category">Categorie : </label></td>
                        <td>
                            <select name="category" id="category">
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
                    <input type="submit" value="Rechercher">
                </div>
            </form>
            <br/>
            <table>
                <thead>
                    <th>ID</th>
                    <th>Titre</th>
                    <th>Description</th>
                    <th>Durée</th>
                    <th>Coût</th>
                </thead>
                <tbody>
                    <%
                    while (results.next()) {
                    %>
                    <tr>
                        <td><%=results.getString("ID") %></td>
                        <td><%=results.getString("TITLE") %></td>
                        <td><%=results.getString("DESCRIPTION") %></td>
                        <td><%=results.getString("LOCATION") %></td>
                        <td><%=results.getString("COST") %></td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
            <br/>
            <a href="./accueil.jsp">Retour</a>
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
