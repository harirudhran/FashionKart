<%@ page import="com.fashionkart.model.User" %>
<%@ page import="com.fashionkart.model.Product" %>
<%@ page import="com.fashionkart.dao.ProductDAO" %>
<%@ page import="com.fashionkart.daoimpl.ProductDAOImpl" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Check who is logged in
    User currentUser = (User) session.getAttribute("activeUser");

    // 2. Get the product ID from the URL (e.g., product.jsp?id=5)
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        response.sendRedirect("shop.jsp");
        return;
    }

    // 3. Fetch that specific product from the database
    int productId = Integer.parseInt(idParam);
    ProductDAO productDAO = new ProductDAOImpl();
    Product product = productDAO.getProductById(productId);

    // If someone types a random ID that doesn't exist, send them back to the shop
    if (product == null) {
        response.sendRedirect("shop.jsp");
        return;
    }

    // 4. Split the comma-separated sizes and colors from the database into arrays
    String[] sizes = (product.getAvailableSizes() != null) ? product.getAvailableSizes().split(",") : new String[]{"Standard"};
    String[] colors = (product.getAvailableColors() != null) ? product.getAvailableColors().split(",") : new String[]{"Standard"};
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= product.getName() %> | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .pdp-container { max-width: 1200px; margin: 50px auto; padding: 0 50px; display: flex; gap: 50px; flex-wrap: wrap; }
        
        /* Left Side: Big Image */
        .pdp-image-box { flex: 1; min-width: 400px; background-color: white; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
        .pdp-image-box img { width: 100%; height: auto; display: block; object-fit: cover; }
        
        /* Right Side: Product Details */
        .pdp-details { flex: 1; min-width: 400px; padding-top: 20px; }
        .pdp-category { text-transform: uppercase; color: var(--accent-tan); font-weight: bold; font-size: 14px; letter-spacing: 1px; margin-bottom: 10px; }
        .pdp-title { font-size: 36px; color: var(--text-dark); margin: 0 0 15px 0; line-height: 1.2; }
        .pdp-price { font-size: 28px; color: var(--primary-green); font-weight: bold; margin-bottom: 25px; }
        .pdp-desc { font-size: 16px; color: #555; line-height: 1.6; margin-bottom: 30px; border-bottom: 1px solid #eee; padding-bottom: 30px; }
        
        /* Form & Selectors */
        .selector-group { margin-bottom: 25px; }
        .selector-group label { display: block; font-weight: bold; margin-bottom: 10px; text-transform: uppercase; font-size: 13px; }
        .selector-group select { width: 100%; max-width: 300px; padding: 12px; border: 1px solid #ddd; border-radius: 6px; font-family: inherit; font-size: 15px; }
        
        .stock-status { margin-bottom: 25px; font-weight: bold; font-size: 14px; }
        .in-stock { color: #28a745; }
        .out-of-stock { color: #dc3545; }
        
        .btn-add-huge { width: 100%; max-width: 300px; padding: 18px; background-color: var(--primary-green); color: white; border: none; font-size: 16px; font-weight: bold; text-transform: uppercase; border-radius: 30px; cursor: pointer; transition: all 0.3s; margin-top: 10px; }
        .btn-add-huge:hover { background-color: var(--text-dark); transform: translateY(-2px); }
        .btn-add-huge:disabled { background-color: #ccc; cursor: not-allowed; transform: none; }
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
            <a href="account.jsp" title="My Account" style="font-size: 13px; text-transform: uppercase; font-weight: bold; color: var(--primary-green);">Hi, <%= currentUser.getFirstName() %></a>
            <a href="LogoutServlet" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
        <% } else { %>
            <a href="login.jsp" title="Login / Register"><i class="far fa-user"></i></a>
        <% } %>
        <a href="cart.jsp" title="Cart"><i class="fas fa-shopping-bag"></i></a>
    </div>
</nav>

<div class="pdp-container">
    
    <div class="pdp-image-box">
        <img src="images/<%= product.getImageUrl() %>" alt="<%= product.getName() %>" onerror="this.src='https://via.placeholder.com/600x800?text=No+Image'">
    </div>
    
    <div class="pdp-details">
        <div class="pdp-category">Fashion Kart Collection</div>
        <h1 class="pdp-title"><%= product.getName() %></h1>
        <div class="pdp-price">₹<%= String.format("%.2f", product.getPrice()) %></div>
        <p class="pdp-desc"><%= product.getDescription() %></p>
        
        <% if (product.getStockQuantity() > 0) { %>
            <div class="stock-status in-stock"><i class="fas fa-check-circle"></i> In Stock (<%= product.getStockQuantity() %> available)</div>
            
            <form action="AddToCartServlet" method="post">
                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                
                <div class="selector-group">
                    <label>Select Size</label>
                    <select name="size" required>
                        <% for(String s : sizes) { %>
                            <option value="<%= s.trim() %>"><%= s.trim() %></option>
                        <% } %>
                    </select>
                </div>
                
                <div class="selector-group">
                    <label>Select Color</label>
                    <select name="color" required>
                        <% for(String c : colors) { %>
                            <option value="<%= c.trim() %>"><%= c.trim() %></option>
                        <% } %>
                    </select>
                </div>
                
                <button type="submit" class="btn-add-huge"><i class="fas fa-shopping-cart"></i> Add to Cart</button>
            </form>
            
        <% } else { %>
            <div class="stock-status out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</div>
            <button class="btn-add-huge" disabled>Out of Stock</button>
        <% } %>
    </div>
</div>

</body>
</html>