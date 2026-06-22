<%@ page import="com.fashionkart.model.User" %>
<%@ page import="com.fashionkart.model.Order" %>
<%@ page import="com.fashionkart.dao.OrderDAO" %>
<%@ page import="com.fashionkart.daoimpl.OrderDAOImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Security Check: Ensure the user is actually logged in
    User currentUser = (User) session.getAttribute("activeUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. Fetch the user's order history from the database
    OrderDAO orderDAO = new OrderDAOImpl();
    List<Order> myOrders = orderDAO.getOrdersByUserId(currentUser.getUserId());

    // 3. Create a formatter to make the MySQL timestamp look nice
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Account | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .dashboard-container { max-width: 1100px; margin: 50px auto; padding: 0 20px; display: flex; gap: 30px; flex-wrap: wrap; }
        
        /* Left Column: Profile Details */
        .profile-section { flex: 1; min-width: 300px; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); height: fit-content; }
        .profile-avatar { text-align: center; font-size: 60px; color: var(--accent-tan); margin-bottom: 20px; }
        .profile-detail { margin-bottom: 20px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .profile-detail strong { color: var(--text-dark); display: block; font-size: 12px; text-transform: uppercase; margin-bottom: 5px; }
        .profile-detail span { color: #555; font-size: 16px; }
        
        /* Right Column: Order History */
        .orders-section { flex: 2; min-width: 500px; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }
        .section-title { color: var(--primary-green); text-transform: uppercase; border-bottom: 2px solid var(--accent-yellow); padding-bottom: 10px; margin-bottom: 25px; font-size: 20px; }
        
        .orders-table { width: 100%; border-collapse: collapse; }
        .orders-table th { background-color: var(--primary-green); color: white; padding: 12px; text-align: left; text-transform: uppercase; font-size: 13px; }
        .orders-table td { padding: 15px 12px; border-bottom: 1px solid #eee; font-size: 14px; vertical-align: middle; }
        
        /* Dynamic Status Badges */
        .status-badge { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; display: inline-block; text-align: center; min-width: 80px;}
        .status-Pending { background-color: #fff3cd; color: #856404; }
        .status-Shipped { background-color: #cce5ff; color: #004085; }
        .status-Delivered { background-color: #d4edda; color: #155724; }
        
        .empty-orders { text-align: center; color: #777; padding: 40px 20px; font-size: 16px; background: var(--bg-light); border-radius: 8px;}
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
        <% } %>
        <a href="cart.jsp" title="Cart"><i class="fas fa-shopping-bag"></i></a>
    </div>
</nav>

<div class="dashboard-container">
    
    <div class="profile-section">
        <div class="profile-avatar"><i class="fas fa-user-circle"></i></div>
        <h2 class="section-title" style="text-align: center;">My Profile</h2>
        
        <div class="profile-detail">
            <strong>Full Name</strong>
            <span><%= currentUser.getFirstName() %> <%= currentUser.getLastName() %></span>
        </div>
        <div class="profile-detail">
            <strong>Email Address</strong>
            <span><%= currentUser.getEmail() %></span>
        </div>
        <div class="profile-detail">
            <strong>Phone Number</strong>
            <span><%= (currentUser.getPhone() != null) ? currentUser.getPhone() : "Not provided" %></span>
        </div>
        <div class="profile-detail" style="border-bottom: none;">
            <strong>Default Shipping Address</strong>
            <span><%= (currentUser.getAddress() != null) ? currentUser.getAddress() : "Not provided" %></span>
        </div>
    </div>

    <div class="orders-section">
        <h2 class="section-title">Order History</h2>
        
        <% if (myOrders == null || myOrders.isEmpty()) { %>
            <div class="empty-orders">
                <i class="fas fa-box-open" style="font-size: 40px; color: #ccc; margin-bottom: 15px;"></i>
                <p>You haven't placed any orders yet.</p>
                <a href="shop.jsp" class="btn-primary" style="margin-top: 15px;">Start Shopping</a>
            </div>
        <% } else { %>
            <table class="orders-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Total Amount</th>
                        <th>Payment</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Order o : myOrders) { %>
                    <tr>
                        <td style="font-weight: bold;">#<%= o.getOrderId() %></td>
                        <td><%= sdf.format(o.getOrderDate()) %></td>
                        <td style="font-weight: bold; color: var(--primary-green);">₹<%= String.format("%.2f", o.getTotalAmount()) %></td>
                        <td><%= o.getPaymentMethod() %></td>
                        <td>
                            <span class="status-badge status-<%= o.getOrderStatus() %>">
                                <%= o.getOrderStatus() %>
                            </span>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
    
</div>

</body>
</html>