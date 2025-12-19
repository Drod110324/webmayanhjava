/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.CategoryDao;
import data.dao.ProductDao;
import data.impl.CategoryImpl;
import data.impl.ProductImpl;
import java.io.IOException;
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
@WebServlet(name = "ShopListServlet", urlPatterns = {"/shoplist"})
public class ShopListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDao productDao = new ProductImpl();
        CategoryDao categoryDao = new CategoryImpl();
        List<Category> listCategory = categoryDao.findALL();
        request.setAttribute("listCategory", listCategory);
        String idCateStr = request.getParameter("id_category");
        List<Product> listProduct;
        if (idCateStr == null || idCateStr.isEmpty()) {
            listProduct = productDao.findALL();
        } else {
            try {
                int idCategory = Integer.parseInt(idCateStr);
                listProduct = productDao.findByCategory(idCategory);
                request.setAttribute("id_category", idCategory);
                for (Category c : listCategory) {
                    if (c.getId() == idCategory) {
                        request.setAttribute("selectedCategory", c);
                        break;
                    }
                }
                
            } catch (NumberFormatException e) {
                listProduct = productDao.findALL();
            }
        }
        request.setAttribute("listProduct", listProduct);

        request.getRequestDispatcher("views/shoplist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}