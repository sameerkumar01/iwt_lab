<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.hotel.model.Booking" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>My Bookings - Hotel Booking</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <%@ include file="navbar.jsp" %>

                    <div class="content">
                        <div class="container">
                            <h2>My Bookings</h2>

                            <% List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                                    if (bookings != null && !bookings.isEmpty()) {
                                    %>
                                    <div style="margin-top: 30px;">
                                        <% for (Booking booking : bookings) { %>
                                            <div class="card" style="margin-bottom: 20px;">
                                                <div class="card-body">
                                                    <div
                                                        style="display: flex; justify-content: space-between; align-items: start;">
                                                        <div>
                                                            <h3 class="card-title">
                                                                <%= booking.getHotelName() %>
                                                            </h3>
                                                            <p class="card-text">
                                                                <strong>Booking ID:</strong> #<%= booking.getBookingId()
                                                                    %><br>
                                                                    <strong>Room Type:</strong>
                                                                    <%= booking.getRoomType() %><br>
                                                                        <strong>Guest:</strong>
                                                                        <%= booking.getGuestName() %><br>
                                                                            <strong>Check-in:</strong>
                                                                            <%= booking.getCheckInDate() %><br>
                                                                                <strong>Check-out:</strong>
                                                                                <%= booking.getCheckOutDate() %><br>
                                                                                    <strong>Guests:</strong>
                                                                                    <%= booking.getNumGuests() %><br>
                                                                                        <strong>Total Amount:</strong> ₹
                                                                                        <%= String.format("%.2f",
                                                                                            booking.getTotalAmount()) %>
                                                            </p>
                                                            <% if ("confirmed".equals(booking.getBookingStatus())) { %>
                                                                <span class="badge badge-success">Confirmed</span>
                                                                <% } else { %>
                                                                    <span class="badge badge-danger">Cancelled</span>
                                                                    <% } %>
                                                        </div>
                                                        <div style="text-align: right;">
                                                            <p style="color: #666; font-size: 13px;">
                                                                Booked on: <%= booking.getBookingDate() %>
                                                            </p>
                                                            <% if ("confirmed".equals(booking.getBookingStatus())) { %>
                                                                <form id="cancelForm_<%= booking.getBookingId() %>"
                                                                    action="booking" method="post"
                                                                    style="margin-top: 15px;">
                                                                    <input type="hidden" name="action" value="cancel">
                                                                    <input type="hidden" name="bookingId"
                                                                        value="<%= booking.getBookingId() %>">
                                                                    <button type="button" class="btn btn-danger"
                                                                        onclick="confirmCancel(<%= booking.getBookingId() %>)">
                                                                        Cancel Booking
                                                                    </button>
                                                                </form>
                                                                <% } %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <% } %>
                                    </div>
                                    <% } else { %>
                                        <div class="alert alert-info" style="margin-top: 30px;">
                                            <h3>No bookings yet</h3>
                                            <p>You haven't made any bookings. Start exploring hotels and book your stay!
                                            </p>
                                            <a href="index.jsp" class="btn btn-primary" style="margin-top: 15px;">
                                                Search Hotels
                                            </a>
                                        </div>
                                        <% } %>
                        </div>
                    </div>

                    <%@ include file="footer.jsp" %>
                        <script src="js/script.js"></script>
            </body>

            </html>