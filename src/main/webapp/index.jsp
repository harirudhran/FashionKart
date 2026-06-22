<%@ page import="com.fashionkart.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("activeUser");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Fashion Kart | Your Style Awaits</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            <a href="account.jsp" title="My Account" style="font-size: 13px; text-transform: uppercase; font-weight: bold; color: var(--primary-green);">Hi, <%= currentUser.getFirstName() %></a>
            <a href="LogoutServlet" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
        <% } else { %>
            <a href="login.jsp" title="Login / Register"><i class="far fa-user"></i></a>
        <% } %>
        <a href="cart.jsp" title="Cart"><i class="fas fa-shopping-bag"></i></a>
    </div>
</nav>

<section class="hero-container">
    <div class="hero-text">
        <h1>Your Style<br>Awaits</h1>
        <p>Discover premium collections crafted for everyday elegance. Find the style that perfectly defines you.</p>
        <a href="shop.jsp" class="btn-primary">Explore Collection <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="hero-image-area" style="background-image: url('https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');"></div>
</section>

<section class="categories-section">
    <h2 class="section-title">Shop by Category</h2>
    <div class="category-grid">
        
        <a href="shop.jsp?category=1" class="category-card" style="background-image: url('https://images.unsplash.com/photo-1617137968427-85924c800a22?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');">
            <div class="category-name">Men's Fashion<span>Explore Formal & Casual</span></div>
        </a>
        
        <a href="shop.jsp?category=2" class="category-card" style="background-image: url('https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');">
            <div class="category-name">Women's Fashion<span>Explore Trendy Styles</span></div>
        </a>
        
        <a href="shop.jsp?category=3" class="category-card" style="background-image: url('https://images.unsplash.com/photo-1519241047957-be31d7379a5d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');">
            <div class="category-name">Kids Collection<span>Explore Comfort</span></div>
        </a>
        
        <a href="shop.jsp?category=4" class="category-card" style="background-image: url('https://images.unsplash.com/photo-1511499767150-a48a237f0083?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');">
            <div class="category-name">Accessories<span>Explore Daily Essentials</span></div>
        </a>
        
    </div>
</section>

<section class="promo-banner">
    <div class="promo-text">
        <h2>Trendy<br>Collection</h2>
        <p>The products are really amazing and very comfortable. Discover our amazing new season collection here at affordable prices.</p>
        <a href="shop.jsp" class="btn-outline">Shop Now</a>
    </div>
    <div class="promo-images">
        <div class="promo-img-box" style="background-image: url('https://images.unsplash.com/photo-1550614000-4b95d415d111?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');"></div>
        <div class="promo-img-box" style="background-image: url('https://images.unsplash.com/photo-1520975954732-57dd22299614?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80');"></div>
    </div>
</section>

<footer class="footer">
    <a href="#" class="footer-logo">Fashion Kart</a>
    <p>&copy; 2026 Fashion Kart Inc. All rights reserved.</p>
</footer>

</body>
</html>