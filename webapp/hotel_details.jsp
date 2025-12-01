<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.hotel.model.Hotel, com.hotel.model.Room" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Hotel Details</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <%@ include file="navbar.jsp" %>

                    <div class="content">
                        <div class="container">
                            <% Hotel hotel=(Hotel) request.getAttribute("hotel"); if (hotel !=null) { %>
                                <!-- Hotel Header -->
                                <div class="hotel-header">
                                    <img src="<%= hotel.getImageUrl() %>" alt="<%= hotel.getHotelName() %>"
                                        class="hotel-image">
                                    <h1>
                                        <%= hotel.getHotelName() %>
                                    </h1>
                                    <p style="color: #666; font-size: 16px; margin: 10px 0;">
                                        📍 <%= hotel.getLocation() %>
                                    </p>
                                    <span class="rating">⭐ <%= hotel.getRating() %></span>
                                    <p style="margin: 15px 0;">
                                        <%= hotel.getDescription() %>
                                    </p>

                                    <% if (hotel.getAmenities() !=null) { %>
                                        <div class="amenities">
                                            <% String[] amenities=hotel.getAmenities().split(","); for (String amenity :
                                                amenities) { %>
                                                <span class="amenity-tag">
                                                    <%= amenity.trim() %>
                                                </span>
                                                <% } %>
                                        </div>
                                        <% } %>
                                </div>

                                <!-- Available Rooms -->
                                <h2 style="margin: 30px 0 20px 0;">Available Rooms</h2>
                                <% List<Room> rooms = (List<Room>) request.getAttribute("rooms");
                                        if (rooms != null && !rooms.isEmpty()) {
                                        for (Room room : rooms) {
                                        %>
                                        <div class="room-card">
                                            <div class="room-info">
                                                <h3>
                                                    <%= room.getRoomType() %>
                                                </h3>
                                                <p>
                                                    <%= room.getDescription() %>
                                                </p>
                                                <p>👥 Capacity: <%= room.getCapacity() %> guests</p>
                                                <p>
                                                    <% if (room.isAvailable()) { %>
                                                        <span class="badge badge-success">
                                                            <%= room.getAvailableRooms() %> rooms available
                                                        </span>
                                                        <% } else { %>
                                                            <span class="badge badge-danger">No rooms available</span>
                                                            <% } %>
                                                </p>
                                            </div>
                                            <div class="room-price">
                                                <div class="price">₹<%= String.format("%.0f", room.getPricePerNight())
                                                        %>
                                                </div>
                                                <div class="per-night">per night</div>
                                                <% if (room.isAvailable()) { %>
                                                    <a href="personal_details.jsp?roomId=<%= room.getRoomId() %>&hotelId=<%= hotel.getHotelId() %>"
                                                        class="btn btn-primary" style="margin-top: 10px;">Book Now</a>
                                                    <% } else { %>
                                                        <button class="btn btn-secondary" disabled
                                                            style="margin-top: 10px;">
                                                            Fully Booked
                                                        </button>
                                                        <% } %>
                                            </div>
                                        </div>
                                        <% } } else { %>
                                            <div class="alert alert-info">No rooms available at this hotel.</div>
                                            <% } } else { %>
                                                <div class="alert alert-error">Hotel not found.</div>
                                                <% } %>
                        </div>
                    </div>

                    <%@ include file="footer.jsp" %>
                        <script src="js/script.js"></script>
            </body>

            </html>