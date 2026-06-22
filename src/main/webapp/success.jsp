<%@ page import="com.fashionkart.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Check who is logged in
    User currentUser = (User) session.getAttribute("activeUser");
    
    // 2. Grab the order ID that the Servlet passed into the URL
    String orderId = request.getParameter("orderId");

    // 3. Security Check: If someone types success.jsp manually without an order, send them away
    if (orderId == null || orderId.isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Successful | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .success-container { max-width: 600px; margin: 80px auto; background: white; padding: 50px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); text-align: center; }
        .success-icon { font-size: 80px; color: #28a745; margin-bottom: 20px; }
        .success-title { color: var(--primary-green); text-transform: uppercase; margin-bottom: 15px; font-size: 28px; }
        .order-number { font-size: 20px; font-weight: bold; background: var(--bg-light); padding: 15px; border-radius: 4px; display: inline-block; margin: 20px 0; border: 1px dashed var(--primary-green); }
        .success-msg { color: #555; font-size: 16px; line-height: 1.6; margin-bottom: 30px; }
        .btn-group { display: flex; justify-content: center; gap: 20px; }
        
        /* Reusing checkout button style for consistency, adding a secondary button */
        .btn-checkout { background-color: var(--primary-green); color: white; padding: 15px 30px; text-decoration: none; text-transform: uppercase; font-weight: bold; border-radius: 4px; }
        .btn-checkout:hover { background-color: #083b2e; }
        .btn-secondary { padding: 15px 30px; background-color: var(--text-dark); color: white; text-decoration: none; border-radius: 4px; text-transform: uppercase; font-weight: bold; }
        .btn-secondary:hover { background-color: #444; }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="shop.jsp?category=1">Men</a>
        <a href="shop.jsp?category=2">Women</a>
        <a href="shop.jsp?category=3">Kids</a>
        <a href="shop.jsp?category=4">Accessories</a>
    </div>
    <a href="index.jsp" class="logo">Fashion Kart</a>
    <div class="nav-icons">
        <a href="#"><i class="fas fa-search"></i></a>
        <% if (currentUser != null) { %>
            <a href="account.jsp" title="My Account" style="font-size: 14px; text-transform: uppercase; font-weight: bold;">Hi, <%= currentUser.getFirstName() %></a>
            <a href="LogoutServlet" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
        <% } %>
        <a href="cart.jsp" title="Cart"><i class="fas fa-shopping-bag"></i></a>
    </div>
</nav>

<div class="success-container">
    <i class="fas fa-check-circle success-icon"></i>
    <h1 class="success-title">Order Confirmed!</h1>
    <p class="success-msg">Thank you for shopping with Fashion Kart. Your order has been successfully placed and our team is preparing it for shipment.</p>
    
    <div class="order-number">
        Order ID: #<%= orderId %>
    </div>
    
    <p class="success-msg" style="font-size: 14px;">You can track the status of this order in your account dashboard at any time.</p>
    
    <div class="btn-group">
        <a href="shop.jsp" class="btn-checkout">Continue Shopping</a>
        <a href="account.jsp" class="btn-secondary">View My Orders</a>
    </div>
</div>

</body>
</html>