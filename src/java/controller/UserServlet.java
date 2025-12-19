/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.dao.UserDao;
import data.impl.UserImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.User;

/**
 *
 * @author Drod2
 */
// SỬA QUAN TRỌNG: Thêm chữ 's' vào urlPatterns để khớp với link gọi
@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserDao userDao = new UserImpl();
        
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        if ("delete".equals(action) && idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                userDao.delete(id);
                // Redirect về trang danh sách (users)
                response.sendRedirect("users");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 2. Load danh sách hiển thị
        List<User> listUsers = userDao.findAll();
        request.setAttribute("listUsers", listUsers);
        request.getRequestDispatcher("views/user.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDao userDao = new UserImpl();
        String action = request.getParameter("action");
        if ("update_user".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String role = request.getParameter("role");
                userDao.updateUser(id, name, email, phone, role);
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("user");
    }

    @Override
    public String getServletInfo() {
        return "User Management Servlet";
    }
}