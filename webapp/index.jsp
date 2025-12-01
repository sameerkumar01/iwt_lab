<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Booking - Find Your Perfect Stay</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="container">
            <a href="index.jsp" class="logo">🏨 HotelBooking</a>
            <div class="nav-links">
                <% if (session.getAttribute("user") != null) { 
                    String userName = (String) session.getAttribute("userName");
                    String userRole = (String) session.getAttribute("userRole");
                %>
                    <span>Welcome, <%= userName %>!</span>
                    <% if ("admin".equals(userRole)) { %>
                        <a href="admin_dashboard.jsp">Admin Dashboard</a>
                    <% } else { %>
                        <a href="myBookings">My Bookings</a>
                    <% } %>
                    <form action="logout" method="get" style="display: inline;">
                        <button type="submit" class="btn-secondary">Logout</button>
                    </form>
                <% } else { %>
                    <a href="login.jsp">Login</a>
                    <a href="register.jsp" class="btn-primary">Sign Up</a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <h1>Find Your Perfect Stay</h1>
            <p>Book hotels at the best prices across India</p>
            
            <!-- Search Box -->
            <div class="search-box">
                <form action="searchHotels" method="post" onsubmit="return validateSearchForm()" class="search-form">
                    <div class="form-group">
                        <label for="location">Where?</label>
                        <input type="text" id="location" name="location" 
                               placeholder="Enter city or location" required>
                    </div>
                    <div class="form-group">
                        <label for="checkIn">Check-in</label>
                        <input type="date" id="checkIn" name="checkIn" required>
                    </div>
                    <div class="form-group">
                        <label for="checkOut">Check-out</label>
                        <input type="date" id="checkOut" name="checkOut" required>
                    </div>
                    <div class="form-group" style="align-self: flex-end;">
                        <button type="submit" class="btn btn-primary">Search Hotels</button>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- Featured Hotels -->
    <section class="content">
        <div class="container">
            <h2>Popular Destinations</h2>
            <div class="hotel-grid">
                <div class="card">
                    <img src="https://images.unsplash.com/photo-1566073771259-6a8506099945?w=400&h=300&fit=crop" alt="Mumbai">
                    <div class="card-body">
                        <h3 class="card-title">Mumbai</h3>
                        <p class="card-text">The city that never sleeps</p>
                        <a href="searchHotels?location=Mumbai" class="btn btn-primary">Explore</a>
                    </div>
                </div>
                <div class="card">
                    <img src="https://images.unsplash.com/photo-1587474260584-136574528ed5?w=400&h=300&fit=crop" alt="Delhi">
                    <div class="card-body">
                        <h3 class="card-title">Delhi</h3>
                        <p class="card-text">The heart of India</p>
                        <a href="searchHotels?location=Delhi" class="btn btn-primary">Explore</a>
                    </div>
                </div>
                <div class="card">
                    <img src="https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400&h=300&fit=crop" alt="Goa">
                    <div class="card-body">
                        <h3 class="card-title">Goa</h3>
                        <p class="card-text">Beach paradise</p>
                        <a href="searchHotels?location=Goa" class="btn btn-primary">Explore</a>
                    </div>
                </div>
                <div class="card">
                    <img src="https://images.unsplash.com/photo-1559628376-f3fe5f782a2e?w=400&h=300&fit=crop" alt="Shimla">
                    <div class="card-body">
                        <h3 class="card-title">Shimla</h3>
                        <p class="card-text">Mountain retreat</p>
                        <a href="searchHotels?location=Shimla" class="btn btn-primary">Explore</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 HotelBooking. All rights reserved. | IWT Lab Project</p>
        </div>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
