/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.Database;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Product;
// Import Category nếu bạn đã có DAO cho nó để hiển thị dropdown
// import model.Category; 

/**
 *
 * @author Drod1103
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Quản lý Sản Phẩm");
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String keyword = request.getParameter("keyword"); 
        if ("delete".equals(action) && idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Database.getProductDao().delete(id);
                response.sendRedirect("product");
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        List<Product> listProduct;
        if ("search".equals(action) && keyword != null && !keyword.trim().isEmpty()) {
            listProduct = Database.getProductDao().findByName(keyword);
        } else {
            listProduct = Database.getProductDao().findALL();
        }
        
        request.setAttribute("listProduct", listProduct);
        request.getRequestDispatcher("./views/product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        double price = 0;
        int quantity = 0;
        int idCategory = 0;

        try {
            String priceStr = request.getParameter("price");
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                price = Double.parseDouble(priceStr.trim());
            }

            String quantityStr = request.getParameter("quantity");
            if (quantityStr != null && !quantityStr.trim().isEmpty()) {
                quantity = Integer.parseInt(quantityStr.trim());
            }

            String idCategoryStr = request.getParameter("id_category");
            if (idCategoryStr != null && !idCategoryStr.trim().isEmpty()) {
                idCategory = Integer.parseInt(idCategoryStr.trim());
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        Database.getProductDao().add(name, price, quantity, image, idCategory);
        
        response.sendRedirect(request.getContextPath() + "/product");
    }

    @Override
    public String getServletInfo() {
        return "Product Servlet";
    }
}