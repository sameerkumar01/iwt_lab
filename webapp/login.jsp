<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Hotel Booking</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <!-- Navigation -->
        <nav class="navbar">
            <div class="container">
                <a href="index.jsp" class="logo">🏨 HotelBooking</a>
                <div class="nav-links">
                    <a href="index.jsp">Home</a>
                    <a href="register.jsp">Sign Up</a>
                </div>
            </div>
        </nav>

        <!-- Login Form -->
        <div class="form-container">
            <h2>Login to Your Account</h2>

            <% if (request.getAttribute("error") !=null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                    <% if (request.getAttribute("success") !=null) { %>
                        <div class="alert alert-success">
                            <%= request.getAttribute("success") %>
                        </div>
                        <% } %>

                            <form action="login" method="post" onsubmit="return validateLoginForm()">
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                                </div>

                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" id="password" name="password"
                                        placeholder="Enter your password" required>
                                </div>

                                <button type="submit" class="btn btn-primary">Login</button>
                            </form>

                            <p style="text-align: center; margin-top: 20px;">
                                Don't have an account? <a href="register.jsp">Sign up here</a>
                            </p>

                            <div style="margin-top: 30px; padding: 15px; background: #e3f2fd; border-radius: 6px;">
                                <p style="margin: 0; font-size: 14px; color: #1976d2;"><strong>Demo Accounts:</strong>
                                </p>
                                <p style="margin: 5px 0 0 0; font-size: 13px; color: #555;">
                                    Admin: admin@hotel.com / admin123<br>
                                    User: user@example.com / user123
                                </p>
                            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <p>&copy; 2024 HotelBooking. All rights reserved.</p>
            </div>
        </footer>

        <script src="js/script.js"></script>
    </body>

    </html>