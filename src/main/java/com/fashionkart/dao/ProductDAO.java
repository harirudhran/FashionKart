package com.fashionkart.dao;

import com.fashionkart.model.Product;
import java.util.List;

public interface ProductDAO {
    // Core actions for the storefront
    List<Product> getAllProducts();
    List<Product> getProductsByCategory(int categoryId);
    Product getProductById(int productId);
    
    // Inventory management during checkout
    boolean updateProductStock(int productId, int quantityPurchased);
    
    // Future-proofing
    boolean addProduct(Product product);
    boolean updateProduct(Product product);
    boolean deleteProduct(int productId);
}