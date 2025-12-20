/*
 * Search Servlet - Xử lý tìm kiếm sản phẩm
 */
package controller;

import data.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Category;
import model.Product;

/**
 *
 * @author Drod2
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy keyword từ parameter
        String keyword = request.getParameter("keyword");
        
        // Lấy danh sách category để hiển thị menu
        List<Category> listCategory = Database.getCategoryDao().findALL();
        request.setAttribute("listCategory", listCategory);
        
        List<Product> listProduct;
        
        // Nếu có keyword thì tìm kiếm, không thì hiển thị tất cả
        if (keyword != null && !keyword.trim().isEmpty()) {
            listProduct = Database.getProductDao().findByName(keyword.trim());
            request.setAttribute("keyword", keyword.trim());
            request.setAttribute("searchMessage", "Kết quả tìm kiếm cho: \"" + keyword.trim() + "\"");
        } else {
            // Nếu không có keyword, hiển thị tất cả sản phẩm
            listProduct = Database.getProductDao().findALL();
            request.setAttribute("searchMessage", "Hiển thị tất cả sản phẩm");
        }
        
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("title", "Tìm kiếm sản phẩm");
        
        // Forward đến trang home để hiển thị kết quả (dùng chung layout)
        request.getRequestDispatcher("./views/home.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Search Products Servlet";
    }
}

