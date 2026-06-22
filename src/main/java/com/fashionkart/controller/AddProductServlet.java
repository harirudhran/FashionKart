package com.fashionkart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.fashionkart.dao.ProductDAO;
import com.fashionkart.daoimpl.ProductDAOImpl;
import com.fashionkart.model.Product;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        try {
            // 1. Grab data from the form
            String name = request.getParameter("name");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
            String availableSizes = request.getParameter("availableSizes");
            String availableColors = request.getParameter("availableColors");
            
            // For now, we are just taking a string URL. Real image uploading is a bit more complex.
            String imageUrl = request.getParameter("imageUrl"); 
            if (imageUrl == null || imageUrl.isEmpty()) {
                imageUrl = "placeholder.jpg";
            }

            // 2. Package into a Product Model
            // Note: We use 0 for productId because MySQL will auto-generate it
            Product newProduct = new Product();
            newProduct.setProductId(0); 
            newProduct.setCategoryId(categoryId);
            newProduct.setName(name);
            newProduct.setDescription(description);
            newProduct.setPrice(price);
            newProduct.setStockQuantity(stockQuantity);
            newProduct.setAvailableSizes(availableSizes);
            newProduct.setAvailableColors(availableColors);
            newProduct.setImageUrl(imageUrl);

            // 3. Save to Database using your existing DAO
            ProductDAO productDAO = new ProductDAOImpl();
            boolean isAdded = productDAO.addProduct(newProduct);

            if (isAdded) {
                // Redirect back to dashboard with a success message
                response.sendRedirect("admin_dashboard.jsp?msg=product_added");
            } else {
                response.getWriter().println("Error: Could not save product to the database.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("System Error: Check console for details. Make sure you entered numbers correctly.");
        }
    }
}