package com.fashionkart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.fashionkart.dao.UserDAO;
import com.fashionkart.daoimpl.UserDAOImpl;
import com.fashionkart.model.User;

// This annotation links the HTML form action to this exact Java class
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Grab the data the user typed into the form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // 2. Package that data into our User Model
        User newUser = new User(firstName, lastName, email, password, phone, address);
        
        // 3. Ask the DAO to save it to MySQL
        UserDAO userDAO = new UserDAOImpl();
        boolean isRegistered = userDAO.registerUser(newUser);
        
        // 4. Decide where to send the user next based on success or failure
        if (isRegistered) {
            // Success! Send them to the login page (we will build this next)
            response.sendRedirect("login.jsp?msg=registered");
        } else {
            // Failure! Send them back to the registration page with an error
            response.sendRedirect("register.jsp?error=registration_failed");
        }
    }
}