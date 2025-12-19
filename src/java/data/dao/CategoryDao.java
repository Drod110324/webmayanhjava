/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package data.dao;

import java.util.List;
import model.Category;

/**
 *
 * @author Drod2
 */
public interface CategoryDao {
    public List<Category> findALL();
    public void insert(String name);
    public void delete(int id);
    public void update(String name, String newName);

    
}
