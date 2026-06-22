package com.fashionkart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fashionkart.dao.ProductDAO;
import com.fashionkart.daoimpl.ProductDAOImpl;
import com.fashionkart.model.OrderItem;
import com.fashionkart.model.Product;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Get the ID of the product the user clicked
        int productId = Integer.parseInt(request.getParameter("productId"));
        
        // Note: Since we don't have size/color dropdowns on the UI yet, we set defaults. 
        // We can add dropdowns later if you decide to.
        String defaultSize = "M"; 
        String defaultColor = "Standard";

        // 2. Fetch the product details from the database so we know the price
        ProductDAO productDAO = new ProductDAOImpl();
        Product product = productDAO.getProductById(productId);

        // 3. Get the user's current session and check if they already have a cart
        HttpSession session = request.getSession();
        
        @SuppressWarnings("unchecked")
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        // 4. If they don't have a cart yet, create a new empty one
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // 5. Check if this exact item is already in their cart
        boolean itemAlreadyInCart = false;
        for (OrderItem item : cart) {
            if (item.getProductId() == productId) {
                // If it's already there, just add 1 to the quantity
                item.setQuantity(item.getQuantity() + 1);
                itemAlreadyInCart = true;
                break;
            }
        }

        // 6. If it is a brand new item, add it to the cart list
        if (!itemAlreadyInCart) {
            // orderId is 0 because the order hasn't been placed in the database yet
            OrderItem newItem = new OrderItem(0, productId, 1, product.getPrice(), defaultSize, defaultColor);
            cart.add(newItem);
        }

        // 7. Save the updated cart back into the session
        session.setAttribute("cart", cart);
        
        // 8. Send the user to the cart page to see their items
        response.sendRedirect("cart.jsp");
    }
}