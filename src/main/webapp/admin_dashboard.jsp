<%@ page import="com.fashionkart.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security Check: Make sure someone is at least logged in before seeing the admin panel
    User currentUser = (User) session.getAttribute("activeUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .admin-container { padding: 40px 50px; max-width: 1000px; margin: auto; }
        .admin-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid var(--primary-green); padding-bottom: 20px; margin-bottom: 30px; }
        .admin-title { color: var(--text-dark); text-transform: uppercase; margin: 0; }
        
        .admin-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
        .admin-card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); text-align: center; text-decoration: none; color: var(--text-dark); transition: transform 0.2s; border: 1px solid #eee; }
        .admin-card:hover { transform: translateY(-5px); border-color: var(--primary-green); }
        .admin-card i { font-size: 40px; color: var(--primary-green); margin-bottom: 15px; }
        .admin-card h3 { margin: 0 0 10px 0; text-transform: uppercase; font-size: 16px; }
        .admin-card p { color: #777; font-size: 13px; margin: 0; }
        
        .success-msg { background-color: #d4edda; color: #155724; padding: 15px; border-radius: 4px; margin-bottom: 20px; text-align: center; font-weight: bold; }
    </style>
</head>
<body>

<nav class="navbar" style="background-color: var(--text-dark);">
    <a href="admin_dashboard.jsp" class="logo" style="color: white;">Fashion Kart <span style="color: var(--accent-yellow); font-size: 14px;">ADMIN</span></a>
    <div class="nav-icons">
        <a href="index.jsp" style="color: white; font-size: 14px; margin-right: 20px;"><i class="fas fa-store"></i> Return to Store</a>
        <a href="LogoutServlet" title="Logout" style="color: white;"><i class="fas fa-sign-out-alt"></i></a>
    </div>
</nav>

<div class="admin-container">
    <div class="admin-header">
        <h1 class="admin-title">Control Panel</h1>
        <span>Welcome back, <strong><%= currentUser.getFirstName() %></strong></span>
    </div>

    <% if ("product_added".equals(request.getParameter("msg"))) { %>
        <div class="success-msg"><i class="fas fa-check-circle"></i> New product successfully added to the catalog!</div>
    <% } %>

    <div class="admin-grid">
        <a href="add_product.jsp" class="admin-card">
            <i class="fas fa-plus-circle"></i>
            <h3>Add New Product</h3>
            <p>Publish a new item to the storefront.</p>
        </a>
        
        <a href="#" class="admin-card" style="opacity: 0.6; cursor: not-allowed;">
            <i class="fas fa-list"></i>
            <h3>Manage Categories</h3>
            <p>Add or edit clothing departments.</p>
        </a>
        <a href="#" class="admin-card" style="opacity: 0.6; cursor: not-allowed;">
            <i class="fas fa-shipping-fast"></i>
            <h3>View All Orders</h3>
            <p>Track customer purchases and shipping.</p>
        </a>
    </div>
</div>

</body>
</html>