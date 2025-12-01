<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - Hotel Booking</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <!-- Navigation -->
        <nav class="navbar">
            <div class="container">
                <a href="index.jsp" class="logo">🏨 HotelBooking</a>
                <div class="nav-links">
                    <a href="index.jsp">Home</a>
                    <a href="login.jsp">Login</a>
                </div>
            </div>
        </nav>

        <!-- Registration Form -->
        <div class="form-container">
            <h2>Create New Account</h2>

            <% if (request.getAttribute("error") !=null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
                <% } %>

                    <form action="register" method="post" onsubmit="return validateRegisterForm()">
                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <input type="text" id="fullName" name="fullName" placeholder="Enter your full name"
                                required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" placeholder="Enter your email" required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" placeholder="10-digit phone number"
                                pattern="[0-9]{10}" required>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" placeholder="At least 6 characters"
                                minlength="6" required>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                placeholder="Re-enter password" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Register</button>
                    </form>

                    <p style="text-align: center; margin-top: 20px;">
                        Already have an account? <a href="login.jsp">Login here</a>
                    </p>
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