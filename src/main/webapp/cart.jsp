<%@ page import="com.fashionkart.model.User" %>
<%@ page import="com.fashionkart.model.OrderItem" %>
<%@ page import="com.fashionkart.model.Product" %>
<%@ page import="com.fashionkart.dao.ProductDAO" %>
<%@ page import="com.fashionkart.daoimpl.ProductDAOImpl" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Check who is logged in
    User currentUser = (User) session.getAttribute("activeUser");

    // 2. Fetch the cart from the session
    @SuppressWarnings("unchecked")
    List<OrderItem> cart = (List<OrderItem>) session.getAttribute("cart");
    
    // 3. Prepare the database tool to fetch product names based on IDs in the cart
    ProductDAO productDAO = new ProductDAOImpl();
    double grandTotal = 0.0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .cart-container { padding: 50px; max-width: 1000px; margin: 0 auto; }
        .cart-title { color: var(--primary-green); text-transform: uppercase; margin-bottom: 30px; text-align: center; border-bottom: 2px solid var(--accent-yellow); padding-bottom: 10px;}
        
        .cart-table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }
        .cart-table th { background-color: var(--primary-green); color: white; padding: 15px; text-align: left; text-transform: uppercase; font-size: 14px; }
        .cart-table td { padding: 15px; border-bottom: 1px solid #eee; vertical-align: middle; }
        
        .cart-total-section { margin-top: 30px; text-align: right; background: white; padding: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }
        .cart-total-text { font-size: 20px; font-weight: bold; color: var(--text-dark); margin-bottom: 20px; }
        .cart-total-amount { color: var(--primary-green); }
        
        .btn-checkout { background-color: var(--primary-green); color: white; padding: 15px 30px; text-decoration: none; text-transform: uppercase; font-weight: bold; border-radius: 4px; display: inline-block;}
        .btn-checkout:hover { background-color: #083b2e; }
        .empty-cart-msg { text-align: center; padding: 50px; font-size: 18px; color: #777; background: white; }
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
        <% } else { %>
            <a href="login.jsp" title="Login / Register"><i class="far fa-user"></i></a>
        <% } %>
        <a href="cart.jsp" title="Cart"><i class="fas fa-shopping-bag"></i></a>
    </div>
</nav>

<div class="cart-container">
    <h2 class="cart-title">Shopping Cart</h2>
    
    <% if (cart == null || cart.isEmpty()) { %>
        <div class="empty-cart-msg">
            <p>Your cart is currently empty.</p>
            <a href="shop.jsp" class="btn-primary" style="margin-top: 20px;">Return to Shop</a>
        </div>
    <% } else { %>
        <table class="cart-table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Size</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (OrderItem item : cart) { 
                        // Fetch the product from DB to get the name
                        Product p = productDAO.getProductById(item.getProductId());
                        double itemTotal = item.getPriceAtPurchase() * item.getQuantity();
                        grandTotal += itemTotal;
                %>
                <tr>
                    <td style="font-weight: bold;"><%= p.getName() %></td>
                    <td><%= item.getSelectedSize() %></td>
                    <td>₹<%= String.format("%.2f", item.getPriceAtPurchase()) %></td>
                    <td><%= item.getQuantity() %></td>
                    <td style="font-weight: bold; color: var(--primary-green);">₹<%= String.format("%.2f", itemTotal) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        
        <div class="cart-total-section">
            <div class="cart-total-text">
                Grand Total: <span class="cart-total-amount">₹<%= String.format("%.2f", grandTotal) %></span>
            </div>
            
            <% if (currentUser != null) { %>
                <a href="checkout.jsp" class="btn-checkout">Proceed to Checkout <i class="fas fa-check"></i></a>
            <% } else { %>
                <a href="login.jsp" class="btn-checkout">Login to Checkout <i class="fas fa-lock"></i></a>
            <% } %>
        </div>
    <% } %>
</div>

</body>
</html>