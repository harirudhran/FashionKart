<%@ page import="com.fashionkart.model.User" %>
<%@ page import="com.fashionkart.model.Product" %>
<%@ page import="com.fashionkart.dao.ProductDAO" %>
<%@ page import="com.fashionkart.daoimpl.ProductDAOImpl" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User currentUser = (User) session.getAttribute("activeUser");
    String categoryParam = request.getParameter("category");
    
    ProductDAO productDAO = new ProductDAOImpl();
    List<Product> products;
    String pageTitle = "All Collection";
    
    if (categoryParam != null && !categoryParam.isEmpty()) {
        int categoryId = Integer.parseInt(categoryParam);
        products = productDAO.getProductsByCategory(categoryId);
        if(categoryId == 1) pageTitle = "Men's Collection";
        if(categoryId == 2) pageTitle = "Women's Collection";
        if(categoryId == 3) pageTitle = "Kids Collection";
        if(categoryId == 4) pageTitle = "Accessories";
    } else {
        products = productDAO.getAllProducts();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shop | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .shop-container { padding: 40px 50px; }
        .shop-header { text-align: center; margin-bottom: 40px; color: var(--primary-green); text-transform: uppercase; }
        
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 30px; }
        
        .product-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); transition: transform 0.3s; border: 1px solid #eee; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 15px rgba(0,0,0,0.1); }
        
        /* UPDATED IMAGE STYLING */
        .product-image-container { width: 100%; height: 320px; background-color: var(--bg-light); overflow: hidden; position: relative; }
        .product-image-container img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease; }
        .product-card:hover .product-image-container img { transform: scale(1.05); }
        
        .product-info { padding: 20px; text-align: center; }
        .product-name { font-weight: bold; font-size: 16px; margin-bottom: 10px; color: var(--text-dark); }
        .product-price { color: var(--primary-green); font-size: 18px; font-weight: bold; margin-bottom: 15px; }
        
        .btn-add-cart { display: block; width: 100%; padding: 12px; background-color: var(--primary-green); color: white; border: none; border-radius: 4px; cursor: pointer; text-transform: uppercase; font-size: 12px; font-weight: bold; transition: background 0.2s; }
        .btn-add-cart:hover { background-color: #083b2e; }
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
            <a href="account.jsp" title="My Account" style="font-size: 14px; text-transform: uppercase; font-weight: bold; color: var(--primary-green);">Hi, <%= currentUser.getFirstName() %></a>
            <a href="LogoutServlet" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
        <% } else { %>
            <a href="login.jsp" title="Login / Register"><i class="far fa-user"></i></a>
        <% } %>
        <a href="cart.jsp" title="Cart"><i class="fas fa-shopping-bag"></i></a>
    </div>
</nav>

<div class="shop-container">
    <h1 class="shop-header"><%= pageTitle %></h1>
    
    <div class="product-grid">
        <% if(products != null && !products.isEmpty()) {
               for(Product p : products) { %>
            <div class="product-card">
                
                <div class="product-image-container">
                    <img src="images/<%= p.getImageUrl() %>" alt="<%= p.getName() %>" onerror="this.src='https://via.placeholder.com/400x500?text=No+Image'">
                </div>
                
                <div class="product-info">
                    <div class="product-name"><%= p.getName() %></div>
                    <div class="product-price">₹<%= String.format("%.2f", p.getPrice()) %></div>
                    
                    <form action="AddToCartServlet" method="post">
                        <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                        <button type="submit" class="btn-add-cart"><i class="fas fa-cart-plus"></i> Add to Cart</button>
                    </form>
                </div>
            </div>
        <%     }
           } else { %>
            <p style="text-align:center; grid-column: 1 / -1; font-size: 18px; color: #777;">No products found in this category.</p>
        <% } %>
    </div>
</div>

</body>
</html>