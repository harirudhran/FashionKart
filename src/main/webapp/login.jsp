<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .auth-wrapper { display: flex; justify-content: center; align-items: center; min-height: 80vh; padding: 40px 20px; }
        .auth-card { background: white; width: 100%; max-width: 450px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.08); overflow: hidden; }
        .auth-header { background-color: var(--primary-green); color: white; padding: 30px; text-align: center; }
        .auth-header h2 { margin: 0; text-transform: uppercase; letter-spacing: 1px; font-size: 24px; }
        .auth-header p { margin: 10px 0 0 0; color: var(--accent-yellow); font-size: 14px; }
        .auth-body { padding: 40px 30px; }
        
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: var(--text-dark); font-size: 13px; text-transform: uppercase; }
        .input-icon-wrap { position: relative; }
        .input-icon-wrap i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #888; }
        .form-group input { width: 100%; padding: 12px 12px 12px 45px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-family: inherit; transition: border-color 0.3s; }
        .form-group input:focus { border-color: var(--primary-green); outline: none; }
        
        .btn-submit { width: 100%; padding: 15px; background-color: var(--primary-green); color: white; border: none; font-size: 15px; font-weight: bold; text-transform: uppercase; border-radius: 30px; cursor: pointer; transition: all 0.3s; margin-top: 10px; }
        .btn-submit:hover { background-color: var(--text-dark); transform: translateY(-2px); }
        
        .auth-footer { text-align: center; margin-top: 25px; font-size: 14px; color: #666; }
        .auth-footer a { color: var(--primary-green); text-decoration: none; font-weight: bold; }
        .auth-footer a:hover { color: var(--text-dark); }
        
        .success-msg { background-color: #d4edda; color: #155724; padding: 15px; border-radius: 6px; margin-bottom: 25px; text-align: center; font-size: 14px; border: 1px solid #c3e6cb; }
        .error-msg { background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 6px; margin-bottom: 25px; text-align: center; font-size: 14px; border: 1px solid #f5c6cb; }
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
        <a href="register.jsp" title="Register" style="font-size: 14px; text-transform: uppercase; font-weight: bold;">Create Account</a>
    </div>
</nav>

<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-header">
            <h2>Welcome Back</h2>
            <p>Sign in to continue your shopping</p>
        </div>
        
        <div class="auth-body">
            <% if ("registered".equals(request.getParameter("msg"))) { %>
                <div class="success-msg"><i class="fas fa-check-circle"></i> Registration successful! Please log in.</div>
            <% } %>
            <% if ("invalid".equals(request.getParameter("error"))) { %>
                <div class="error-msg"><i class="fas fa-exclamation-circle"></i> Invalid email or password. Try again.</div>
            <% } %>
            
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label>Email Address</label>
                    <div class="input-icon-wrap">
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="email" required placeholder="Enter your email">
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <div class="input-icon-wrap">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="password" required placeholder="Enter your password">
                    </div>
                </div>
                
                <button type="submit" class="btn-submit">Secure Login <i class="fas fa-sign-in-alt"></i></button>
            </form>
            
            <div class="auth-footer">
                Don't have an account? <a href="register.jsp">Register here</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>