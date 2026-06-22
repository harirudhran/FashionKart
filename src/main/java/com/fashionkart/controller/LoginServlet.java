package com.fashionkart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.fashionkart.dao.UserDAO;
import com.fashionkart.daoimpl.UserDAOImpl;
import com.fashionkart.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Grab the credentials from the form
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // 2. Ask the DAO to check the database
        UserDAO userDAO = new UserDAOImpl();
        User loggedInUser = userDAO.loginUser(email, password);
        
        if (loggedInUser != null) {
            // SUCCESS! The user exists and the password matches.
            // 3. Create a session and store the entire User object inside it
            HttpSession session = request.getSession();
            session.setAttribute("activeUser", loggedInUser);
            
            // 4. Send them to the homepage
            response.sendRedirect("index.jsp");
        } else {
            // FAILURE! Bad email or password.
            // Send them back to the login page with an error flag
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}