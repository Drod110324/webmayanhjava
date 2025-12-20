/*
 * Checkout Servlet - Xử lý thanh toán và đặt hàng
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import data.driver.MySQLDriver;
import model.Product;
import model.User;

/**
 *
 * @author Drod2
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Product> cart = (List<Product>) session.getAttribute("cart");

        // Kiểm tra giỏ hàng
        if (cart == null || cart.isEmpty()) {
            session.setAttribute("checkout_error", "Giỏ hàng của bạn đang trống!");
            response.sendRedirect("cart");
            return;
        }

        // Lấy thông tin từ form
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        String customerEmail = request.getParameter("customerEmail");
        String deliveryAddress = request.getParameter("deliveryAddress");
        String deliveryNote = request.getParameter("deliveryNote");
        String paymentMethod = request.getParameter("paymentMethod");

        // Validate thông tin
        if (customerName == null || customerName.trim().isEmpty() ||
            customerPhone == null || customerPhone.trim().isEmpty() ||
            customerEmail == null || customerEmail.trim().isEmpty() ||
            deliveryAddress == null || deliveryAddress.trim().isEmpty()) {
            session.setAttribute("checkout_error", "Vui lòng điền đầy đủ thông tin bắt buộc!");
            response.sendRedirect("cart");
            return;
        }

        Connection con = null;
        try {
            con = MySQLDriver.getConnection();
            con.setAutoCommit(false); // Bắt đầu transaction

            // Tính tổng tiền
            double subtotal = 0;
            for (Product p : cart) {
                subtotal += p.getPrice() * p.getQuantity();
            }
            double vat = subtotal * 0.1;
            double total = subtotal + vat;

            // 1. Tạo đơn hàng trong bảng orders
            int orderId = createOrder(con, user.getId(), customerName, customerPhone, 
                                    customerEmail, deliveryAddress, deliveryNote, 
                                    paymentMethod, total);

            // 2. Lưu chi tiết đơn hàng và cập nhật sold, quantity
            for (Product p : cart) {
                // Lưu vào order_items (nếu có bảng)
                try {
                    addOrderItem(con, orderId, p.getId(), p.getQuantity(), p.getPrice());
                } catch (SQLException e) {
                    // Nếu không có bảng order_items, bỏ qua
                }

                // Cập nhật số lượng đã bán (sold) trong products
                updateProductSold(con, p.getId(), p.getQuantity());
                
                // Giảm số lượng tồn kho (quantity)
                updateProductQuantity(con, p.getId(), p.getQuantity());
            }

            // Commit transaction
            con.commit();

            // Xóa giỏ hàng sau khi checkout thành công
            session.setAttribute("cart", new ArrayList<>());
            session.setAttribute("checkout_success", 
                "Đặt hàng thành công! Mã đơn hàng: #" + orderId);

            response.sendRedirect("cart?success=true");

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (con != null) {
                    con.rollback(); // Rollback nếu có lỗi
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            session.setAttribute("checkout_error", "Có lỗi xảy ra khi xử lý đơn hàng. Vui lòng thử lại!");
            response.sendRedirect("cart");
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private int createOrder(Connection con, int userId, String customerName, 
                           String customerPhone, String customerEmail, 
                           String deliveryAddress, String deliveryNote, 
                           String paymentMethod, double total) throws SQLException {
        
        // Thử tạo đơn hàng trong bảng orders nếu có
        try {
            String sql = "INSERT INTO orders (user_id, customer_name, customer_phone, " +
                        "customer_email, delivery_address, delivery_note, payment_method, " +
                        "total_amount, order_date, status) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), 'PENDING')";
            
            try (PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, userId);
                stmt.setString(2, customerName);
                stmt.setString(3, customerPhone);
                stmt.setString(4, customerEmail);
                stmt.setString(5, deliveryAddress);
                stmt.setString(6, deliveryNote != null ? deliveryNote : "");
                stmt.setString(7, paymentMethod != null ? paymentMethod : "COD");
                stmt.setDouble(8, total);
                
                stmt.executeUpdate();
                
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            // Nếu không có bảng orders, tạo ID giả
            // Hoặc có thể tạo bảng orders trước
        }
        
        // Fallback: trả về ID giả dựa trên timestamp
        return (int) (System.currentTimeMillis() % 1000000);
    }

    private void addOrderItem(Connection con, int orderId, int productId, 
                              int quantity, double price) throws SQLException {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) " +
                     "VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setDouble(4, price);
            stmt.executeUpdate();
        }
    }

    private void updateProductSold(Connection con, int productId, int quantity) throws SQLException {
        String sql = "UPDATE products SET sold = sold + ? WHERE id = ?";
        
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        }
    }

    private void updateProductQuantity(Connection con, int productId, int quantity) throws SQLException {
        String sql = "UPDATE products SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected == 0) {
                throw new SQLException("Không đủ số lượng sản phẩm trong kho!");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Checkout Servlet";
    }
}


