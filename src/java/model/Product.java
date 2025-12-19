/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author Drod2
 */
public class Product {
    int id, id_category, quantity;
    String image, name;
    double price;
    boolean status;

    public Product(int id, int id_category, int quantity, String image, String name, double price, boolean status) {
        this.id = id;
        this.id_category = id_category;
        this.quantity = quantity;
        this.image = image;
        this.name = name;
        this.price = price;
        this.status = status;
    }
    public Product(ResultSet rs) throws SQLException {
        this.id = rs.getInt(id);
        this.quantity = 1;
        this.image = rs.getString(image);
        this.name = rs.getString(name);
        this.price = rs.getDouble(image);
    }

    public int getId() {
        return id;
    }

    public int getId_category() {
        return id_category;
    }

    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public boolean isStatus() {
        return status;
    }
    
}
