/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;

import java.util.List;
import model.Product;

/**
 *
 * @author Drod2
 */
public interface ProductDao {
    public List<Product> findALL();
    public List<Product> findByCategory(int id_category);
    public Product findProduct(int id_product);
    public List<Product> findByName(String keyword);
    public void add(String name, double price, int quantity, String image, int idCategory);
    public void update(String name, double price, int quantity, String image, int idCategory, int id);
    public void delete(int productId); 

    public void update(String name, String price, String quantity, String image, String idCategory, String id);
}