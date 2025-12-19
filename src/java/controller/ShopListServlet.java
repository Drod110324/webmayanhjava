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
        
        // 1. Khởi tạo các DAO
        // Lưu ý: Bạn cần có CategoryImpl để lấy danh mục. 
        // Nếu chưa có, xem phần bổ sung ở dưới.
        ProductDao productDao = new ProductImpl();
        CategoryDao categoryDao = new CategoryImpl();

        // 2. Lấy danh sách tất cả Danh mục (để hiển thị Sidebar và Navbar)
        List<Category> listCategory = categoryDao.findALL();
        request.setAttribute("listCategory", listCategory);

        // 3. Xử lý logic lọc sản phẩm
        String idCateStr = request.getParameter("id_category");
        List<Product> listProduct;

        if (idCateStr == null || idCateStr.isEmpty()) {
            // TRƯỜNG HỢP 1: Không chọn danh mục -> Lấy tất cả
            listProduct = productDao.findALL();
        } else {
            // TRƯỜNG HỢP 2: Có chọn danh mục -> Lọc theo ID
            try {
                int idCategory = Integer.parseInt(idCateStr);
                listProduct = productDao.findByCategory(idCategory);
                
                // Gửi lại ID category để JSP highlight (active) menu
                request.setAttribute("id_category", idCategory);
                
                // Tìm tên danh mục đang chọn để hiển thị tiêu đề (ví dụ: "Sản phẩm thuộc: Canon")
                for (Category c : listCategory) {
                    if (c.getId() == idCategory) {
                        request.setAttribute("selectedCategory", c);
                        break;
                    }
                }
                
            } catch (NumberFormatException e) {
                // Nếu ID lỗi thì lấy tất cả
                listProduct = productDao.findALL();
            }
        }

        // 4. Đẩy danh sách sản phẩm sang JSP
        request.setAttribute("listProduct", listProduct);

        // 5. Forward về trang hiển thị
        // Lưu ý: File này là file bao gồm cả Header, Footer và nội dung _shoplist.jsp
        request.getRequestDispatcher("views/shoplist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}