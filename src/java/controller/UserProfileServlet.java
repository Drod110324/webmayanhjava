package controller;

import data.dao.Database;
import data.impl.UserImpl;
import data.ultis.API;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "UserProfileServlet", urlPatterns = {"/profile"})
public class UserProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        request.getRequestDispatcher("views/UserProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // 1. XỬ LÝ CẬP NHẬT THÔNG TIN CƠ BẢN
        if ("update_info".equals(action)) {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            
            // Gọi hàm update cũ của bạn (giữ nguyên email và role)
            Database.getUserDao().updateUser(user.getId(), name, user.getEmail(), phone, user.getRole());
            
            // Cập nhật lại Session để hiển thị ngay tên mới trên Navbar
            user.setName(name);
            user.setPhone(phone);
            session.setAttribute("user", user);
            
            request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
        } 
        
        // 2. XỬ LÝ ĐỔI MẬT KHẨU
        else if ("change_pass".equals(action)) {
            String oldPass = request.getParameter("old_pass");
            String newPass = request.getParameter("new_pass");
            String confirmPass = request.getParameter("confirm_pass");
            
            String hashedOldPass = API.getMd5(oldPass);

            // Kiểm tra mật khẩu cũ
            if (!hashedOldPass.equals(user.getPassword())) {
                request.setAttribute("errorMessage", "Mật khẩu cũ không chính xác!");
            } 
            // Kiểm tra xác nhận mật khẩu
            else if (!newPass.equals(confirmPass)) {
                request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            } 
            else if (newPass.length() < 6) {
                request.setAttribute("errorMessage", "Mật khẩu mới phải từ 6 ký tự trở lên!");
            } 
            else {
                // Thực hiện đổi mật khẩu
                Database.getUserDao().changePassword(user.getId(), newPass);
                
                // Cập nhật lại mật khẩu trong session hiện tại
                user.setPassword(API.getMd5(newPass));
                session.setAttribute("user", user);
                
                request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
            }
        }
        
        request.getRequestDispatcher("views/userprofile.jsp").forward(request, response);
    }
}