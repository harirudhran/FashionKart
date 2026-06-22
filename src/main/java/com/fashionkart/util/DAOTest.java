package com.fashionkart.util;

import com.fashionkart.dao.OrderDAO;
import com.fashionkart.dao.ProductDAO;
import com.fashionkart.dao.UserDAO;
import com.fashionkart.daoimpl.OrderDAOImpl;
import com.fashionkart.daoimpl.ProductDAOImpl;
import com.fashionkart.daoimpl.UserDAOImpl;
import com.fashionkart.model.Order;
import com.fashionkart.model.Product;
import com.fashionkart.model.User;

import java.util.List;

public class DAOTest {

    public static void main(String[] args) {
        
        System.out.println("=========================================");
        System.out.println("      FASHION KART - DAO TEST RUNNER     ");
        System.out.println("=========================================\n");

        // 1. Test UserDAO
        System.out.println("--- 1. FETCHING USERS ---");
        UserDAO userDAO = new UserDAOImpl();
        List<User> users = userDAO.getAllUsers();
        if (users.isEmpty()) {
            System.out.println("No users found. Did you run the SQL insert script?");
        } else {
            for (User u : users) {
                System.out.println("User ID: " + u.getUserId() + " | Name: " + u.getFirstName() + " " + u.getLastName() + " | Email: " + u.getEmail());
            }
        }

        // 2. Test ProductDAO
        System.out.println("\n--- 2. FETCHING INVENTORY ---");
        ProductDAO productDAO = new ProductDAOImpl();
        List<Product> products = productDAO.getAllProducts();
        if (products.isEmpty()) {
            System.out.println("No products found.");
        } else {
            for (Product p : products) {
                System.out.println("Item: " + p.getName() + " | Price: $" + p.getPrice() + " | Stock: " + p.getStockQuantity());
            }
        }

        // 3. Test OrderDAO (Let's see what John Doe bought)
        System.out.println("\n--- 3. FETCHING ORDERS FOR JOHN DOE (USER ID 1) ---");
        OrderDAO orderDAO = new OrderDAOImpl();
        // Passing '1' because John Doe is User ID 1 in our SQL script
        List<Order> orders = orderDAO.getOrdersByUserId(1); 
        if (orders.isEmpty()) {
            System.out.println("No orders found for this user.");
        } else {
            for (Order o : orders) {
                System.out.println("Order #" + o.getOrderId() + " | Total: $" + o.getTotalAmount() + " | Status: " + o.getOrderStatus());
            }
        }
        
        System.out.println("\n=========================================");
        System.out.println("          TEST RUN COMPLETE              ");
        System.out.println("=========================================");
    }
}