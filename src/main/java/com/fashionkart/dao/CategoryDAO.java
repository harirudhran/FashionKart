package com.fashionkart.dao;

import com.fashionkart.model.Category;
import java.util.List;

public interface CategoryDAO {
    // Core actions for the storefront
    List<Category> getAllCategories();
    Category getCategoryById(int categoryId);
    
    // Future-proofing (Adding/Editing categories behind the scenes)
    boolean addCategory(Category category);
    boolean updateCategory(Category category);
    boolean deleteCategory(int categoryId);
}