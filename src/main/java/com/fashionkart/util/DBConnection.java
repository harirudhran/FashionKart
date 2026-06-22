package com.fashionkart.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    // Database credentials - Update the password to match your MySQL setup!
    private static final String URL = "jdbc:mysql://localhost:3306/fashion_store";
    private static final String USER = "root";
    private static final String PASSWORD = "root"; 

    public static Connection getConnection() {
        Connection connection = null;
        try {
            // 1. Load the MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 2. Open the connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connection to Fashion Kart Database established successfully!");
            
        } catch (ClassNotFoundException e) {
            System.out.println("Error: MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error: Could not connect to the database.");
            e.printStackTrace();
        }
        return connection;
    }

}