<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Account | Fashion Kart</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .auth-wrapper { display: flex; justify-content: center; align-items: center; min-height: 80vh; padding: 40px 20px; }
        .auth-card { background: white; width: 100%; max-width: 600px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.08); overflow: hidden; }
        .auth-header { background-color: var(--text-dark); color: white; padding: 30px; text-align: center; border-bottom: 4px solid var(--accent-yellow);}
        .auth-header h2 { margin: 0; text-transform: uppercase; letter-spacing: 1px; font-size: 24px; }
        .auth-header p { margin: 10px 0 0 0; color: #ccc; font-size: 14px; }
        .auth-body { padding: 40px 40px 30px; }
        
        .row { display: flex; gap: 20px; }
        .col { flex: 1; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: var(--text-dark); font-size: 12px; text-transform: uppercase; }
        .input-icon-wrap { position: relative; }
        .input-icon-wrap i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #888; }
        
        /* Apply padding-left 45px for inputs with icons, and standard padding for inputs without icons */
        .input-icon-wrap input { width: 100%; padding: 12px 12px 12px 45px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-family: inherit; transition: border-color 0.3s; }
        .form-group textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-family: inherit; transition: border-color 0.3s; resize: vertical;}
        
        .input-icon-wrap input:focus, .form-group textarea:focus { border-color: var(--primary-green); outline: none; }
        
        .btn-submit { width: 100%; padding: 15px; background-color: var(--primary-green); color: white; border: none; font-size: 15px; font-weight: bold; text-transform: uppercase; border-radius: 30px; cursor: pointer; transition: all 0.3s; margin-top: 15px; }
        .btn-submit:hover { background-color: var(--text-dark); transform: translateY(-2px); }
        
        .auth-footer { text-align: center; margin-top: 25px; font-size: 14px; color: #666; border-top: 1px solid #eee; padding-top: 20px;}
        .auth-footer a { color: var(--primary-green); text-decoration: none; font-weight: bold; }
        .auth-footer a:hover { color: var(--text-dark); }
        
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
        <a href="login.jsp" title="Login" style="font-size: 14px; text-transform: uppercase; font-weight: bold;">Login</a>
    </div>
</nav>

<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-header">
            <h2>Create an Account</h2>
            <p>Join Fashion Kart for a premium shopping experience</p>
        </div>
        
        <div class="auth-body">
            <% if ("registration_failed".equals(request.getParameter("error"))) { %>
                <div class="error-msg"><i class="fas fa-exclamation-circle"></i> Registration failed. Email might already be in use.</div>
            <% } %>
            
            <form action="RegisterServlet" method="post">
                <div class="row">
                    <div class="col form-group">
                        <label>First Name</label>
                        <div class="input-icon-wrap">
                            <i class="fas fa-user"></i>
                            <input type="text" name="firstName" required placeholder="John">
                        </div>
                    </div>
                    <div class="col form-group">
                        <label>Last Name</label>
                        <div class="input-icon-wrap">
                            <i class="fas fa-user"></i>
                            <input type="text" name="lastName" required placeholder="Doe">
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Email Address</label>
                    <div class="input-icon-wrap">
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="email" required placeholder="name@example.com">
                    </div>
                </div>
                
                <div class="row">
                    <div class="col form-group">
                        <label>Password</label>
                        <div class="input-icon-wrap">
                            <i class="fas fa-lock"></i>
                            <input type="password" name="password" required placeholder="Create password">
                        </div>
                    </div>
                    <div class="col form-group">
                        <label>Phone Number</label>
                        <div class="input-icon-wrap">
                            <i class="fas fa-phone"></i>
                            <input type="text" name="phone" placeholder="Optional">
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Default Shipping Address</label>
                    <textarea name="address" rows="3" placeholder="Enter your full street address, city, and zip code"></textarea>
                </div>
                
                <button type="submit" class="btn-submit">Create Account <i class="fas fa-user-plus"></i></button>
            </form>
            
            <div class="auth-footer">
                Already have an account? <a href="login.jsp">Log in here</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>