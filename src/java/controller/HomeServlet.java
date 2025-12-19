/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.Database;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author Drod2
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeServlet at " + request.getContextPath() + "</h1>");
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
       String id_productParam = request.getParameter("id_product");
        if(id_productParam != null && !id_productParam.trim().isEmpty()) {
//            addProductToCart(request);
            // Redirect to avoid resubmission
            String id_categoryParam = request.getParameter("id_category");
            if(id_categoryParam != null && !id_categoryParam.trim().isEmpty()) {
                response.sendRedirect("home?id_category=" + id_categoryParam);
            } else {
                response.sendRedirect("home");
            }
            return;
        }
        
        List<Category> listCategory = Database.getCategoryDao().findALL();
        request.setAttribute("listCategory", listCategory);
        
        String id_categoryParam = request.getParameter("id_category");
        
        if(id_categoryParam != null && !id_categoryParam.trim().isEmpty()) {
            try {
                int id_category = Integer.parseInt(id_categoryParam);
                List<Product> listProduct = Database.getProductDao().findByCategory(id_category);
                request.setAttribute("listProduct", listProduct);
                request.setAttribute("id_category", id_category);
//                addProductToCart(request);
                
                // Find category name
                Category selectedCategory = null;
                for(Category cat : listCategory) {
                    if(cat.getId() == id_category) {
                        selectedCategory = cat;
                        break;
                    }
                }
                request.setAttribute("selectedCategory", selectedCategory);
            } catch (NumberFormatException e) {
                // Invalid category ID, show all products
                List<Product> listProduct = Database.getProductDao().findALL();
                request.setAttribute("listProduct", listProduct);
            }
        } else {
            // No category selected, show all products
            List<Product> listProduct = Database.getProductDao().findALL();
            request.setAttribute("listProduct", listProduct);
        }
        
        request.getRequestDispatcher("./views/home.jsp").forward(request, response);
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
