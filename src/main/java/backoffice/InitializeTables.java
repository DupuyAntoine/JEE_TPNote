/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package backoffice;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
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
@WebServlet(name = "InitializeTables", urlPatterns = {"/InitializeTables"})
public class InitializeTables extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
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
            // Cr?ation d'une requ?te sans param?tres
            Statement ps = con.createStatement();

            try {
                ps.executeUpdate("DROP TABLE USER");
            } catch(SQLException e) {
                System.out.println("La table est déjà créée");
            }
            
            try {
                ps.executeUpdate("DROP TABLE SERVICE");
            } catch(SQLException e) {
                System.out.println("La table est déjà créée");
            }

            try {
                ps.executeUpdate("DROP TABLE CATEGORY");
            } catch(SQLException e) {
                System.out.println("La table est déjà créée");
            }

            
            ps.executeUpdate("CREATE TABLE USER(ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, NAME VARCHAR(30), FIRSTNAME VARCHAR(30), EMAIL VARCHAR(255), PASSWORD VARCHAR(255), LEVEL INT)");
            ps.executeUpdate("CREATE TABLE SERVICE(ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, TITLE VARCHAR(30), DESCRIPTION VARCHAR(255), LOCATION ENUM('heure', 'demi-journee', 'jour', 'semaine'), COST FLOAT, USERID INT, CATEGORYID INT)");
            ps.executeUpdate("CREATE TABLE CATEGORY(ID INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, NAME VARCHAR(30), DESCRIPTION VARCHAR(100))");

            ps.executeUpdate("INSERT INTO CATEGORY(NAME, DESCRIPTION) VALUES ('Cours', 'Cours sur un domaine spécifique')");
            
            out.println("<h1>Tables user, service, category créées</h1>");
            out.println("<a href='./page2.html'>Retour accueil</a>");


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
            Logger.getLogger(InitializeTables.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(InitializeTables.class.getName()).log(Level.SEVERE, null, ex);
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
