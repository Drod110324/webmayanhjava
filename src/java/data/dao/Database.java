/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data.dao;

import data.impl.CategoryImpl;
import data.impl.ProductImpl;
import data.impl.UserImpl;


/**
 *
 * @author Drod2
 */
public class Database {
    public static CategoryDao getCategoryDao(){
        return new CategoryImpl();
        
    }
    public static ProductDao getProductDao(){
        return new ProductImpl();
        
    }
    public static UserDao getUserDao(){
        return new UserImpl();
    }
}
