<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.hotel.model.Hotel" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Hotels - Search Results</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <%@ include file="navbar.jsp" %>

                    <div class="content">
                        <div class="container">
                            <% String searchLocation=(String) request.getAttribute("searchLocation"); if (searchLocation
                                !=null && !searchLocation.isEmpty()) { %>
                                <h2>Hotels in <%= searchLocation %>
                                </h2>
                                <% } else { %>
                                    <h2>All Hotels</h2>
                                    <% } %>

                                        <% List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
                                                if (hotels != null && !hotels.isEmpty()) {
                                                %>
                                                <div class="hotel-grid">
                                                    <% for (Hotel hotel : hotels) { %>
                                                        <div class="card">
                                                            <img src="<%= hotel.getImageUrl() %>"
                                                                alt="<%= hotel.getHotelName() %>">
                                                            <div class="card-body">
                                                                <h3 class="card-title">
                                                                    <%= hotel.getHotelName() %>
                                                                </h3>
                                                                <p class="card-text">
                                                                    📍 <%= hotel.getLocation() %><br>
                                                                        ⭐ <%= hotel.getRating() %> Rating
                                                                </p>
                                                                <p class="card-text">
                                                                    <%= hotel.getDescription() %>
                                                                </p>
                                                                <a href="hotelDetails?hotelId=<%= hotel.getHotelId() %>"
                                                                    class="btn btn-primary">View Details</a>
                                                            </div>
                                                        </div>
                                                        <% } %>
                                                </div>
                                                <% } else { %>
                                                    <div class="alert alert-info">
                                                        <p>No hotels found. Try searching for a different location.</p>
                                                        <a href="index.jsp" class="btn btn-primary">Back to Search</a>
                                                    </div>
                                                    <% } %>
                        </div>
                    </div>

                    <%@ include file="footer.jsp" %>
                        <script src="js/script.js"></script>
            </body>

            </html>