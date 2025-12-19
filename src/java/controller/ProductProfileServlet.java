/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.ProductDao;
import data.impl.ProductImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;

/**
 * @author Drod2
 */
@WebServlet(name = "ProductProfileServlet", urlPatterns = {"/product-profile"})
public class ProductProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                ProductDao productDao = new ProductImpl(); 
                Product product = productDao.findProduct(id);
                
                if (product != null) {
                    request.setAttribute("product", product);
                    List<Product> relatedProducts = productDao.findByCategory(product.getId_category());
                    relatedProducts.removeIf(p -> p.getId() == id);
                    if (relatedProducts.size() > 4) {
                        relatedProducts = relatedProducts.subList(0, 4);
                    }
                    
                    request.setAttribute("relatedProducts", relatedProducts);
                    request.getRequestDispatcher("views/productProfile.jsp").forward(request, response);
                } else {
                    response.sendRedirect("home");
                }
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("home");
            }
        } else {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}