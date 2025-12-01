<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="container">
            <a href="index.jsp" class="logo">🏨 HotelBooking</a>
            <div class="nav-links">
                <% if (session.getAttribute("user") !=null) { String userName=(String) session.getAttribute("userName");
                    String userRole=(String) session.getAttribute("userRole"); %>
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