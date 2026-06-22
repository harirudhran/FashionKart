package com.fashionkart.dao;

import com.fashionkart.model.Order;
import java.util.List;

public interface OrderDAO {
    // Core checkout actions
    int createOrder(Order order); // Returns the generated Order ID
    
    // User dashboard actions
    List<Order> getOrdersByUserId(int userId);
    Order getOrderById(int orderId);
    
    // Future-proofing (e.g., changing status from Pending to Shipped)
    boolean updateOrderStatus(int orderId, String status);
}