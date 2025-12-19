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
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Product;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // 1. Xử lý thêm vào giỏ hàng qua đường dẫn (GET)
        if ("add".equals(action)) {
            addToCart(request, response);
            return;
        }

        // 2. Xóa toàn bộ giỏ hàng
        if (request.getParameter("clear") != null) {
            request.getSession().setAttribute("cart", new ArrayList<>());
            response.sendRedirect("cart");
            return;
        }

        // 3. Kiểm tra đăng nhập trước khi vào giỏ hàng
        Object userSession = request.getSession().getAttribute("user");
        if (userSession != null) {
            request.getRequestDispatcher("./views/cart.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        // 1. Xử lý thêm vào giỏ hàng qua Form (POST - từ trang chi tiết)
        if ("add".equals(action)) {
            addToCart(request, response);
            return;
        }
        
        // 2. Xử lý cập nhật hoặc xóa
        updateDelete(request, response);
    }
    
    // --- HÀM LOGIC THÊM VÀO GIỎ HÀNG ---
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        
        // Kiểm tra đăng nhập
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy giỏ hàng từ Session
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = 1;
            
            // Nếu có tham số quantity (từ trang chi tiết), dùng nó. Nếu không thì mặc định là 1.
            String quantityStr = request.getParameter("quantity");
            if (quantityStr != null && !quantityStr.isEmpty()) {
                quantity = Math.max(1, Integer.parseInt(quantityStr));
            }

            boolean exists = false;
            // Kiểm tra sản phẩm đã có trong giỏ chưa
            for (Product p : cart) {
                if (p.getId() == id) {
                    p.setQuantity(p.getQuantity() + quantity);
                    exists = true;
                    break;
                }
            }

            // Nếu chưa có, lấy từ Database bỏ vào
            if (!exists) {
                ProductDao dao = new ProductImpl(); // Dùng ProductImpl
                Product p = dao.findProduct(id);
                if (p != null) {
                    p.setQuantity(quantity);
                    cart.add(p);
                }
            }

            // Lưu lại vào Session
            session.setAttribute("cart", cart);

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Quay lại trang trước đó (Hoặc về trang chủ nếu không xác định được)
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "home");
    }
    
    // --- HÀM LOGIC UPDATE / DELETE ---
    void updateDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String action = request.getParameter("action");
        String idParam = request.getParameter("id_product");
        
        if(idParam == null || idParam.trim().isEmpty()){
            response.sendRedirect("cart");
            return;
        }
        
        int id_product = -1;
        try{
            id_product = Integer.parseInt(idParam);
        }catch(NumberFormatException ex){
            response.sendRedirect("cart");
            return;
        }
        
        if("update".equals(action)){
             List<Product> cart = (List<Product>)request.getSession().getAttribute("cart");
             int quantity = Integer.parseInt(request.getParameter("quantity"));
             for(Product pro: cart) {
                 if(pro.getId() == id_product && quantity > 0){
                     pro.setQuantity(quantity); 
                     break;
                 }
             }
             request.getSession().setAttribute("cart", cart);
             
        } else if("delete".equals(action)){
            List<Product> cart = (List<Product>)request.getSession().getAttribute("cart");
            for(Product pro: cart) {
                if(pro.getId() == id_product){
                    cart.remove(pro); 
                    break;
                }
            }
            request.getSession().setAttribute("cart", cart);
        }
        
        response.sendRedirect("cart");
    }
}