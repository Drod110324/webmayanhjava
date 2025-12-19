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
import jakarta.servlet.http.HttpSession;
import model.User;
import data.impl.UserImpl; // Import UserImpl nếu chưa có class Database tĩnh

/**
 *
 * @author Drod2
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Register Page");
        // Forward về đúng file JSP của bạn
        request.getRequestDispatcher("./views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        session.removeAttribute("err_name");
        session.removeAttribute("err_email");
        session.removeAttribute("err_phone");
        session.removeAttribute("err_repassword");
        session.removeAttribute("err_password");
        session.removeAttribute("exist_user");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        
        String Email_Regex = "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$";
        String Phone_Regex = "^\\d{10}$";
        boolean err = false;

        // 3. Validate dữ liệu
        if(name == null || name.trim().isEmpty()){
            session.setAttribute("err_name", "Vui lòng nhập họ tên!");
            err = true;
        }
        
        if(email == null || email.trim().isEmpty()){
            session.setAttribute("err_email", "Vui lòng nhập Email!");
            err = true;
        } else if(!email.matches(Email_Regex)){
            session.setAttribute("err_email", "Email không hợp lệ!");
            err = true;
        }
        
        if(phone == null || phone.trim().isEmpty()){
            session.setAttribute("err_phone", "Vui lòng nhập số điện thoại!");
            err = true;
        } else if(!phone.matches(Phone_Regex)){
            session.setAttribute("err_phone", "Số điện thoại phải có 10 chữ số!");
            err = true;
        }
        
        if(password == null || password.trim().isEmpty()){
            session.setAttribute("err_password", "Vui lòng nhập mật khẩu!");
            err = true;
        } else if(password.length() < 6){
            session.setAttribute("err_password", "Mật khẩu phải từ 6 ký tự trở lên!");
            err = true;
        }
        
        if(repassword == null || repassword.trim().isEmpty()){
            session.setAttribute("err_repassword", "Vui lòng xác nhận mật khẩu!");
            err = true;
        } else if(!repassword.equals(password)){
            session.setAttribute("err_repassword", "Mật khẩu xác nhận không khớp!");
            err = true;
        }
        
        if(err){
            response.sendRedirect("register");
            return;
        }

        if(Database.getUserDao().findUser(email) != null){
            session.setAttribute("exist_user", "Email này đã được sử dụng!");
            response.sendRedirect("register");
            return;
        }
        if(Database.getUserDao().findUser(phone) != null){
            session.setAttribute("exist_user", "Số điện thoại này đã được sử dụng!");
            response.sendRedirect("register");
            return;
        }
        
        try {
            Database.getUserDao().insertUser(name, email, phone, password);
            User user = Database.getUserDao().findUser(email);
            if(user != null){
                session.setAttribute("user", user);
                response.sendRedirect("home");
            } else {
                session.setAttribute("exist_user", "Đăng ký thất bại. Vui lòng thử lại.");
                response.sendRedirect("register");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("exist_user", "Lỗi hệ thống: " + e.getMessage());
            response.sendRedirect("register");
        }
    }
}