/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.UserDao;
import data.driver.MySQLDriver;
import data.ultis.API;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

public class UserImpl implements UserDao {

    @Override
    public User findUser(String emailphone, String password){
        Connection con = MySQLDriver.getConnection();
        String sql;
        String hashedPassword = API.getMd5(password);
        
        if(emailphone == null || password == null){
            return null;
        }
        
        if(emailphone.contains("@"))
            sql = "select * from users where email=? and password=?";
        else 
            sql = "select * from users where phone=? and password=?";
        
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, emailphone);
            sttm.setString(2, hashedPassword);
            ResultSet rs = sttm.executeQuery();
            if(rs.next()){
                User user = new User(rs);
                rs.close();
                sttm.close();
                con.close();
                return user;
            }
            rs.close();
            sttm.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Error finding user", ex);
        } finally {
            try {
                if(con != null) con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
    @Override
    public User findUser(String emailphone){
        Connection con = MySQLDriver.getConnection();
        String sql;
        if(emailphone.contains("@"))
            sql = "select * from users where email=?";
        else 
            sql = "select * from users where phone=?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, emailphone);
            ResultSet rs = sttm.executeQuery();
            if(rs.next()){
                User user = new User(rs);
                rs.close();
                sttm.close();
                return user;
            }
            rs.close();
            sttm.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if(con != null) con.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
    
    @Override
    public void insertUser(String name, String email, String phone, String password){
        String sql = "insert into users(name, email, phone, password, role) values (?, ?, ?, ?, 'user')";
        Connection con = MySQLDriver.getConnection();
        
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            
            // Hash password with MD5 before storing
            String hashedPassword = API.getMd5(password);
            
            sttm.setString(1, name);
            sttm.setString(2, email);
            sttm.setString(3, phone);
            sttm.setString(4, hashedPassword);
            
            sttm.executeUpdate();
            sttm.close();
        } catch (SQLException e) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, "Error inserting user", e);
            throw new RuntimeException("Failed to insert user", e);
        } finally {
            try {
                if(con != null) con.close();
            } catch (SQLException e) {
                Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }

    @Override
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        String sql = "SELECT * FROM users";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                // Dùng constructor User(ResultSet rs) bạn đã viết trong Model
                list.add(new User(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException ex) {}
            }
        }
        return list;
    }

    @Override
    public void updateUser(int id, String name, String email, String phone, String role) {
        Connection con = MySQLDriver.getConnection();
        // Câu lệnh SQL cập nhật 4 trường thông tin
        String sql = "UPDATE users SET name=?, email=?, phone=?, role=? WHERE id=?";
        
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, name);
            sttm.setString(2, email);
            sttm.setString(3, phone);
            sttm.setString(4, role);
            sttm.setInt(5, id); // ID để biết sửa ai
            
            sttm.executeUpdate();
            sttm.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException ex) {}
            }
        }
    }

    @Override
    public void delete(int id) {
        Connection con = MySQLDriver.getConnection();
        String sql = "DELETE FROM users WHERE id = ?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, id);
            sttm.executeUpdate();
            sttm.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException ex) {}
            }
        }
    }
    @Override
    public void changePassword(int id, String newPassword) {
        Connection con = MySQLDriver.getConnection();
        String sql = "UPDATE users SET password=? WHERE id=?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            // Mã hóa mật khẩu mới trước khi lưu
            String hashedPassword = API.getMd5(newPassword);
            sttm.setString(1, hashedPassword);
            sttm.setInt(2, id);
            
            sttm.executeUpdate();
            sttm.close();
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (con != null) {
                try { con.close(); } catch (SQLException ex) {}
            }
        }
    }

}
