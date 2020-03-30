/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webapp1;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

/**
 *
 * @author AdminEtu
 */
@WebServlet(name = "ServletPrintDB", urlPatterns = {"/ServletPrintDB"})
public class ServletPrintDB extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws javax.naming.NamingException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NamingException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

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

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletGenerationTableau</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Users</h1>");
            out.println("<table border='4'>");
            out.println("<thead>");
            out.println("<th>Id</th>");
            out.println("<th>Nom</th>");
            out.println("<th>Prénom</th>");
            out.println("<th>Email</th>");
            out.println("<th>Privilège</th>");
            out.println("</thead>");
            out.println("<tbody>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("ID") + "</td>");
                out.println("<td>" + rs.getString("NAME") + "</td>");
                out.println("<td>" + rs.getString("FIRSTNAME") + "</td>");
                out.println("<td>" + rs.getString("EMAIL") + "</td>");
                out.println("<td>");
                out.println("<form action='./UpdateUserLevel?userId=" + rs.getString("ID") + "' method='POST'>");
                out.println("<select name='level' id='level'>");
                out.println("<option value=\"" + rs.getString("LEVEL") + "\">" + rs.getString("LEVEL") + "</option>");
                out.println("<option value=\"0\">0</option>");
                out.println("<option value=\"1\">1</option>");
                out.println("<option value=\"2\">2</option>");
                out.println("</select>");
                out.println("<input type='submit' value='Update'>");
                out.println("</form>");
                out.println("</td>");
                out.println("<td><a href='./DeleteUser?userId=" + rs.getString("ID") + "'>Delete</a></td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
            out.println("<a href='page2.html'>Retour accueil</a>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NamingException | SQLException ex) {
            Logger.getLogger(ServletPrintDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NamingException | SQLException ex) {
            Logger.getLogger(ServletPrintDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
