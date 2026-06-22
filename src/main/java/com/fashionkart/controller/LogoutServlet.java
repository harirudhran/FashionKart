package com.fashionkart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // We use doGet here because clicking a standard HTML link sends a GET request
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Fetch the current session (passing 'false' means don't create a new one if it doesn't exist)
        HttpSession session = request.getSession(false);
        
        // 2. If a session exists, destroy it entirely
        if (session != null) {
            session.invalidate(); 
        }
        
        // 3. Send them back to the homepage
        response.sendRedirect("index.jsp");
    }
}