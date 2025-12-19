/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.impl;

import data.dao.CategoryDao;
import data.driver.MySQLDriver;
import java.util.List;
import model.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author Drod2
 */
public class CategoryImpl implements CategoryDao {
    @Override
    public List<Category> findALL(){
        List<Category> listCategory = new ArrayList<>();
        Connection con = MySQLDriver.getConnection();
        String str = "select * from categories";
        try {
            PreparedStatement sttm = con.prepareStatement(str);
            ResultSet rs = sttm.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                String name =rs.getString("name");
                listCategory.add(new Category(id, name));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CategoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listCategory;
    }
    @Override
    public void insert(String name){
        Connection con = MySQLDriver.getConnection();
        String sql = "INSERT INTO categories (name) VALUES (?)";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, name);
            sttm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public void delete(int id){
        Connection con = MySQLDriver.getConnection();
        String sql = "DELETE FROM categories WHERE id = ?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setInt(1, id);
            sttm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public void update(int id, String newName){
        Connection con = MySQLDriver.getConnection();
        String sql = "UPDATE categories SET name = ? WHERE id = ?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, newName);
            sttm.setInt(2, id);
            sttm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void update(String name, String newName) {
        Connection con = MySQLDriver.getConnection();
        String sql = "UPDATE categories SET name = ? WHERE name = ?";
        try {
            PreparedStatement sttm = con.prepareStatement(sql);
            sttm.setString(1, newName);
            sttm.setString(2, name);
            sttm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CategoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
