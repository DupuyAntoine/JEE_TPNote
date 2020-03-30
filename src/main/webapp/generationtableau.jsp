<%-- 
    Document   : generationtableau
    Created on : 23 mars 2020, 16:24:23
    Author     : AdminEtu
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>JSP!</h1>
        <table>
            <thead>
                <th>Euros</th>
                <th>Dollars</th>
            </thead>
            <tbody>
            <% 
            ServletContext context = request.getServletContext();
            String cptName = "Compteur";
            Integer cpt = 0;

            if (context.getAttribute(cptName) != null)
                cpt = (Integer)(context.getAttribute(cptName));
            
            cpt++;
            context.setAttribute(cptName, cpt);

            // Get parameters
            String premier = request.getParameter("premier");
            String dernier = request.getParameter("dernier");
            String pas = request.getParameter("pas");
            
            // Convert parameters string to int
            int parsedPremier = Integer.parseInt(premier);
            int parsedDernier = Integer.parseInt(dernier);
            int parsedPas = Integer.parseInt(pas);

            for(int i = parsedPremier; i <= parsedDernier; i = i + parsedPas) {
            %>
                <tr>
                    <td><%= i %></td>
                    <td><%= String.format("%.02f", i * 1.08) %></td>
                </tr>
            <%
            }
            %>
            </tbody>
        </table>
    </body>
</html>
