<%@ page import="com.fashionkart.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
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
    <title>Add Product | Admin</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .form-container { max-width: 600px; margin: 40px auto; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .form-header { text-align: center; color: var(--primary-green); text-transform: uppercase; margin-bottom: 30px; border-bottom: 2px solid var(--accent-yellow); padding-bottom: 10px;}
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; font-size: 14px; }
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; font-family: inherit; }
        .row { display: flex; gap: 20px; }
        .col { flex: 1; }
        .btn-submit { width: 100%; padding: 15px; background-color: var(--primary-green); color: white; border: none; font-size: 16px; font-weight: bold; text-transform: uppercase; border-radius: 4px; cursor: pointer; margin-top: 10px;}
        .btn-submit:hover { background-color: #083b2e; }
        .btn-back { display: block; text-align: center; margin-top: 15px; color: #777; text-decoration: none; font-size: 14px; }
        .btn-back:hover { color: var(--text-dark); }
    </style>
</head>
<body style="background-color: var(--bg-light);">

<div class="form-container">
    <h2 class="form-header">Add New Product</h2>
    
    <form action="AddProductServlet" method="post">
        
        <div class="form-group">
            <label>Product Name</label>
            <input type="text" name="name" required placeholder="e.g., Premium Leather Jacket">
        </div>
        
        <div class="form-group">
            <label>Category</label>
            <select name="categoryId" required>
                <option value="1">Men's Wear</option>
                <option value="2">Women's Wear</option>
                <option value="3">Kids & Infants</option>
                <option value="4">Accessories</option>
            </select>
        </div>
        
        <div class="form-group">
            <label>Description</label>
            <textarea name="description" rows="3" required placeholder="Brief description of the product..."></textarea>
        </div>
        
        <div class="row">
            <div class="col form-group">
                <label>Price (₹)</label>
                <input type="number" step="0.01" name="price" required placeholder="0.00">
            </div>
            <div class="col form-group">
                <label>Stock Quantity</label>
                <input type="number" name="stockQuantity" required placeholder="100">
            </div>
        </div>
        
        <div class="row">
            <div class="col form-group">
                <label>Available Sizes (Comma separated)</label>
                <input type="text" name="availableSizes" required placeholder="S, M, L, XL">
            </div>
            <div class="col form-group">
                <label>Available Colors (Comma separated)</label>
                <input type="text" name="availableColors" required placeholder="Red, Blue, Black">
            </div>
        </div>
        
        <div class="form-group">
            <label>Image URL</label>
            <input type="text" name="imageUrl" placeholder="e.g., leather_jacket.jpg (Optional for now)">
        </div>
        
        <button type="submit" class="btn-submit">Publish Product <i class="fas fa-upload"></i></button>
        <a href="admin_dashboard.jsp" class="btn-back"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </form>
</div>

</body>
</html>