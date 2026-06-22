<%@ page import="com.fashionkart.model.User" %>
<%@ page import="com.fashionkart.model.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Security Check: Ensure user is logged in and cart exists
    User currentUser = (User) session.getAttribute("activeUser");
    @SuppressWarnings("unchecked")
    List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");

    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    // Calculate total for display
    double grandTotal = 0.0;
    for (OrderItem item : cart) {
        grandTotal += item.getPriceAtPurchase() * item.getQuantity();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .checkout-container { max-width: 600px; margin: 50px auto; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .checkout-title { color: var(--primary-green); text-transform: uppercase; text-align: center; border-bottom: 2px solid var(--accent-yellow); padding-bottom: 10px; margin-bottom: 30px; }
        .summary-box { background: var(--bg-light); padding: 15px; border-radius: 4px; margin-bottom: 20px; text-align: center; font-size: 18px; font-weight: bold; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; }
        .form-group textarea, .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-family: inherit; }
        .btn-confirm { width: 100%; padding: 15px; background-color: var(--primary-green); color: white; border: none; font-size: 16px; font-weight: bold; text-transform: uppercase; border-radius: 4px; cursor: pointer; }
        .btn-confirm:hover { background-color: #083b2e; }
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
        <% if (currentUser != null) { %>
            <a href="account.jsp" title="My Account" style="font-size: 14px; text-transform: uppercase; font-weight: bold;">Hi, <%= currentUser.getFirstName() %></a>
            <a href="LogoutServlet" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
        <% } %>
        <a href="cart.jsp" title="Cart"><i class="fas fa-shopping-bag"></i></a>
    </div>
</nav>

<div class="checkout-container">
    <h2 class="checkout-title">Secure Checkout</h2>
    
    <div class="summary-box">
        Amount to Pay: <span style="color: var(--primary-green);">₹<%= String.format("%.2f", grandTotal) %></span>
    </div>

    <form action="CheckoutServlet" method="post">
        <div class="form-group">
            <label>Shipping Address:</label>
            <textarea name="shippingAddress" rows="4" required><%= currentUser.getAddress() %></textarea>
        </div>
        
        <div class="form-group">
            <label>Payment Method:</label>
            <select name="paymentMethod" required>
                <option value="Credit Card">Credit/Debit Card</option>
                <option value="UPI">UPI</option>
                <option value="Cash on Delivery">Cash on Delivery</option>
            </select>
        </div>
        
        <button type="submit" class="btn-confirm">Place Order <i class="fas fa-lock"></i></button>
    </form>
</div>

</body>
</html>