/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webapp1;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author AdminEtu
 */
@WebServlet(name = "ServletGenerationTableau", urlPatterns = {"/generationtableau"})
public class ServletGenerationTableau extends HttpServlet {
    
    private ServletContext context;
    private static final String cptName = "Compteur";
    
    public void init(ServletConfig config) {
        this.context = config.getServletContext();
    }
    
    private void incrementCptUse() {
        Integer cpt = 0;
        if (context.getAttribute(cptName) != null)
            cpt = (Integer)(context.getAttribute(cptName));
        
        cpt++;
        
        context.setAttribute(cptName, cpt);
    }

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            incrementCptUse();
            // Get parameters
            String premier = request.getParameter("premier");
            String dernier = request.getParameter("dernier");
            String pas = request.getParameter("pas");
            
            // Convert parameters string to int
            int parsedPremier = Integer.parseInt(premier);
            int parsedDernier = Integer.parseInt(dernier);
            int parsedPas = Integer.parseInt(pas);

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletGenerationTableau</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Génération tableau " + request.getContextPath() + "</h1>");
            out.println("<table>");
            out.println("<thead>");
            out.println("<th>Euros</th>");
            out.println("<th>Dollars</th>");
            out.println("</thead>");
            out.println("<tbody>");
            for(int i = parsedPremier; i <= parsedDernier; i = i + parsedPas) {
                out.println("<tr>");
                out.println("<td>" + i + "</td>");
                out.println("<td>" + String.format("%.02f", i * 1.08) + "</td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");
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
        processRequest(request, response);
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
        processRequest(request, response);
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
