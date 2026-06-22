package com.fashionkart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

import com.fashionkart.dao.OrderDAO;
import com.fashionkart.dao.OrderItemDAO;
import com.fashionkart.dao.ProductDAO;
import com.fashionkart.daoimpl.OrderDAOImpl;
import com.fashionkart.daoimpl.OrderItemDAOImpl;
import com.fashionkart.daoimpl.ProductDAOImpl;
import com.fashionkart.model.Order;
import com.fashionkart.model.OrderItem;
import com.fashionkart.model.User;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("activeUser");
        @SuppressWarnings("unchecked")
        List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

        // Failsafe check
        if (currentUser == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        // 1. Grab form data
        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        // 2. Calculate the total one last time
        double totalAmount = 0.0;
        for (OrderItem item : cart) {
            totalAmount += item.getPriceAtPurchase() * item.getQuantity();
        }

        // 3. Initialize our DAOs
        OrderDAO orderDAO = new OrderDAOImpl();
        OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
        ProductDAO productDAO = new ProductDAOImpl();

        // 4. Create the Master Order
        Order newOrder = new Order(currentUser.getUserId(), totalAmount, shippingAddress, "Pending", paymentMethod);
        
        // This is where we get the auto-generated Order ID from MySQL!
        int generatedOrderId = orderDAO.createOrder(newOrder); 

        if (generatedOrderId > 0) {
            // 5. Save every item in the cart to the database and update inventory
            for (OrderItem item : cart) {
                // Link the item to the new order
                item.setOrderId(generatedOrderId);
                
                // Save item to DB
                orderItemDAO.addOrderItem(item);
                
                // Deduct stock from the inventory!
                productDAO.updateProductStock(item.getProductId(), item.getQuantity());
            }

            // 6. Shred the temporary session cart (The order is complete!)
            session.removeAttribute("cart");

            // 7. Send user to a success page
            response.sendRedirect("success.jsp?orderId=" + generatedOrderId);
        } else {
            // If the database fails to create the order
            response.sendRedirect("checkout.jsp?error=true");
        }
    }
}