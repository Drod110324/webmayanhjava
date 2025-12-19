/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.ProductDao;
import data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;

/**
 *
 * @author Drod2
 */
public class ProductImpl implements ProductDao {

    @Override
    public List<Product> findALL() {
        List<Product> listProduct = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        String str = "select * from products";
        try {
            PreparedStatement sttm = con.prepareStatement(str);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int id_category = rs.getInt("id_category");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                boolean status = rs.getBoolean("status");
                listProduct.add(new Product(id, id_category, quantity, image, name, price, status));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
        }
        return listProduct;
    }

    @Override
    public List<Product> findByCategory(int id_category) {
        List<Product> listProduct = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        String str = "select * from products where id_category=?";
        try {
            PreparedStatement sttm = con.prepareStatement(str);
            sttm.setInt(1, id_category);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int id_cat = rs.getInt("id_category"); // Đổi tên biến tránh nhầm lẫn
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                boolean status = rs.getBoolean("status");
                listProduct.add(new Product(id, id_cat, quantity, image, name, price, status));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
        }
        return listProduct;
    }

    @Override
    public Product findProduct(int id_product) {
        Connection con = MySQLDriver.getConnection();
        String sql = "select * from products where id=?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, id_product);
            ResultSet rs = sttm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                int id_category = rs.getInt("id_category");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                boolean status = rs.getBoolean("status");
                return new Product(id, id_category, quantity, image, name, price, status);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
        }
        return null;
    }
    // --- CÁC HÀM MỚI ĐƯỢC THÊM VÀO ---

    @Override
    public List<Product> findByName(String keyword) {
        List<Product> listProduct = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        // Sử dụng LIKE để tìm kiếm gần đúng
        String str = "select * from products where name like ?";
        try {
            PreparedStatement sttm = con.prepareStatement(str);
            sttm.setString(1, "%" + keyword + "%");
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int id_category = rs.getInt("id_category");
                int quantity = rs.getInt("quantity");
                String image = rs.getString("image");
                String name = rs.getString("name");
                double price = rs.getDouble("price");
                boolean status = rs.getBoolean("status");
                listProduct.add(new Product(id, id_category, quantity, image, name, price, status));
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
        }
        return listProduct;
    }

    @Override
    public void add(String name, double price, int quantity, String image, int idCategory) {
        Connection con = MySQLDriver.getConnection();
        // Mặc định status là 1 (true/hoạt động) khi thêm mới
        String sql = "INSERT INTO products (name, price, quantity, image, id_category, status) VALUES (?, ?, ?, ?, ?, 1)";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, name);
            sttm.setDouble(2, price);
            sttm.setInt(3, quantity);
            sttm.setString(4, image);
            sttm.setInt(5, idCategory);
            
            sttm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
        }
    }

    @Override
    public void update(String name, double price, int quantity, String image, int idCategory, int id) {
        Connection con = MySQLDriver.getConnection();
        String sql = "UPDATE products SET name=?, price=?, quantity=?, image=?, id_category=? WHERE id=?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, name);
            sttm.setDouble(2, price);
            sttm.setInt(3, quantity);
            sttm.setString(4, image);
            sttm.setInt(5, idCategory);
            sttm.setInt(6, id);
            
            sttm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
        }
    }

    @Override
    public void delete(int productId) {
        Connection con = MySQLDriver.getConnection();
        String sql = "DELETE FROM products WHERE id=?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, productId);
            sttm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            closeConnection(con);
        }
    }
    
    // Hàm phụ trợ để đóng kết nối gọn gàng hơn
    private void closeConnection(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void update(String name, String price, String quantity, String image, String idCategory, String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}