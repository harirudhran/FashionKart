package com.fashionkart.dao;

import com.fashionkart.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {
    // Core checkout actions
    boolean addOrderItem(OrderItem orderItem);
    
    // User dashboard actions
    List<OrderItem> getOrderItemsByOrderId(int orderId);
}