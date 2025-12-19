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
        
        if ("add".equals(action)) {
            addToCart(request, response);
            return;
        }

        if (request.getParameter("clear") != null) {
            request.getSession().setAttribute("cart", new ArrayList<>());
            response.sendRedirect("cart");
            return;
        }

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
        if ("add".equals(action)) {
            addToCart(request, response);
            return;
        }
        updateDelete(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int quantity = 1;
            String quantityStr = request.getParameter("quantity");
            if (quantityStr != null && !quantityStr.isEmpty()) {
                quantity = Math.max(1, Integer.parseInt(quantityStr));
            }

            boolean exists = false;
            for (Product p : cart) {
                if (p.getId() == id) {
                    p.setQuantity(p.getQuantity() + quantity);
                    exists = true;
                    break;
                }
            }

            if (!exists) {
                ProductDao dao = new ProductImpl();
                Product p = dao.findProduct(id);
                if (p != null) {
                    p.setQuantity(quantity);
                    cart.add(p);
                }
            }
            session.setAttribute("cart", cart);

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : "home");
    }

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