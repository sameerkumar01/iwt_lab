<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.hotel.dao.HotelDAO, com.hotel.dao.RoomDAO" %>
        <%@ page import="com.hotel.model.Hotel, com.hotel.model.Room" %>
            <%@ page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Admin Dashboard - Hotel Booking</title>
                    <link rel="stylesheet" href="css/style.css">
                </head>

                <body>
                    <% // Check if user is admin if (!"admin".equals(session.getAttribute("userRole"))) {
                        response.sendRedirect("index.jsp"); return; } HotelDAO hotelDAO=new HotelDAO(); RoomDAO
                        roomDAO=new RoomDAO(); List<Hotel> hotels = hotelDAO.getAllHotels();
                        %>

                        <%@ include file="navbar.jsp" %>

                            <div class="content">
                                <div class="container">
                                    <h2>Admin Dashboard</h2>

                                    <% if (request.getParameter("success") !=null) { %>
                                        <div class="alert alert-success">
                                            <%= request.getParameter("success") %>
                                        </div>
                                        <% } %>

                                            <!-- Add Hotel Section -->
                                            <div style="margin: 30px 0;">
                                                <button onclick="toggleAddHotelForm()" class="btn btn-primary">
                                                    + Add New Hotel
                                                </button>

                                                <div id="addHotelForm"
                                                    style="display: none; margin-top: 20px; background: white; padding: 20px; border-radius: 10px;">
                                                    <h3>Add New Hotel</h3>
                                                    <form action="admin" method="post">
                                                        <input type="hidden" name="action" value="addHotel">
                                                        <div class="form-group">
                                                            <label>Hotel Name</label>
                                                            <input type="text" name="hotelName" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Location</label>
                                                            <input type="text" name="location" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Description</label>
                                                            <textarea name="description" rows="3" required></textarea>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Amenities (comma-separated)</label>
                                                            <input type="text" name="amenities"
                                                                placeholder="WiFi, Pool, Gym" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Rating</label>
                                                            <input type="number" name="rating" min="1" max="5"
                                                                step="0.1" required>
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Image URL</label>
                                                            <input type="url" name="imageUrl"
                                                                value="https://via.placeholder.com/400x300" required>
                                                        </div>
                                                        <button type="submit" class="btn btn-success">Add Hotel</button>
                                                        <button type="button" onclick="toggleAddHotelForm()"
                                                            class="btn btn-secondary">Cancel</button>
                                                    </form>
                                                </div>
                                            </div>

                                            <!-- Hotels List -->
                                            <h3>Manage Hotels</h3>
                                            <% if (hotels !=null && !hotels.isEmpty()) { %>
                                                <% for (Hotel hotel : hotels) { %>
                                                    <div class="card" style="margin-bottom: 25px;">
                                                        <div class="card-body">
                                                            <div
                                                                style="display: flex; justify-content: space-between; align-items: start;">
                                                                <div style="flex: 1;">
                                                                    <h3 class="card-title">
                                                                        <%= hotel.getHotelName() %>
                                                                    </h3>
                                                                    <p class="card-text">
                                                                        📍 <%= hotel.getLocation() %> | ⭐ <%=
                                                                                hotel.getRating() %><br>
                                                                                <%= hotel.getDescription() %>
                                                                    </p>

                                                                    <!-- Add Room Button -->
                                                                    <button onclick="toggleAddRoomForm()"
                                                                        class="btn btn-primary"
                                                                        style="margin-top: 10px;">
                                                                        + Add Room
                                                                    </button>

                                                                    <!-- Add Room Form -->
                                                                    <div id="addRoomForm"
                                                                        style="display: none; margin-top: 15px; padding: 15px; background: #f5f7fa; border-radius: 6px;">
                                                                        <h4>Add Room to <%= hotel.getHotelName() %>
                                                                        </h4>
                                                                        <form action="admin" method="post"
                                                                            style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                                                                            <input type="hidden" name="action"
                                                                                value="addRoom">
                                                                            <input type="hidden" name="hotelId"
                                                                                value="<%= hotel.getHotelId() %>">
                                                                            <div class="form-group">
                                                                                <label>Room Type</label>
                                                                                <input type="text" name="roomType"
                                                                                    placeholder="Deluxe Room" required>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label>Price per Night</label>
                                                                                <input type="number"
                                                                                    name="pricePerNight" min="0"
                                                                                    step="0.01" required>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label>Total Rooms</label>
                                                                                <input type="number" name="totalRooms"
                                                                                    min="1" required>
                                                                            </div>
                                                                            <div class="form-group">
                                                                                <label>Capacity</label>
                                                                                <input type="number" name="capacity"
                                                                                    min="1" required>
                                                                            </div>
                                                                            <div class="form-group"
                                                                                style="grid-column: 1 / -1;">
                                                                                <label>Description</label>
                                                                                <input type="text" name="description"
                                                                                    required>
                                                                            </div>
                                                                            <div style="grid-column: 1 / -1;">
                                                                                <button type="submit"
                                                                                    class="btn btn-success">Add
                                                                                    Room</button>
                                                                                <button type="button"
                                                                                    onclick="toggleAddRoomForm()"
                                                                                    class="btn btn-secondary">Cancel</button>
                                                                            </div>
                                                                        </form>
                                                                    </div>

                                                                    <!-- Rooms List -->
                                                                    <% List<Room> rooms =
                                                                        roomDAO.getRoomsByHotelId(hotel.getHotelId());
                                                                        if (rooms != null && !rooms.isEmpty()) {
                                                                        %>
                                                                        <div style="margin-top: 15px;">
                                                                            <h4>Rooms:</h4>
                                                                            <table>
                                                                                <thead>
                                                                                    <tr>
                                                                                        <th>Room Type</th>
                                                                                        <th>Price/Night</th>
                                                                                        <th>Available</th>
                                                                                        <th>Capacity</th>
                                                                                        <th>Action</th>
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <% for (Room room : rooms) { %>
                                                                                        <tr>
                                                                                            <td>
                                                                                                <%= room.getRoomType()
                                                                                                    %>
                                                                                            </td>
                                                                                            <td>₹<%= String.format("%.0f",
                                                                                                    room.getPricePerNight())
                                                                                                    %>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%= room.getAvailableRooms()
                                                                                                    %>/<%=
                                                                                                        room.getTotalRooms()
                                                                                                        %>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%= room.getCapacity()
                                                                                                    %> guests
                                                                                            </td>
                                                                                            <td>
                                                                                                <form
                                                                                                    id="deleteRoomForm_<%= room.getRoomId() %>"
                                                                                                    action="admin"
                                                                                                    method="post"
                                                                                                    style="display: inline;">
                                                                                                    <input type="hidden"
                                                                                                        name="action"
                                                                                                        value="deleteRoom">
                                                                                                    <input type="hidden"
                                                                                                        name="roomId"
                                                                                                        value="<%= room.getRoomId() %>">
                                                                                                    <button
                                                                                                        type="button"
                                                                                                        class="btn btn-danger"
                                                                                                        style="padding: 6px 12px; font-size: 13px;"
                                                                                                        onclick="deleteRoom(<%= room.getRoomId() %>)">Delete</button>
                                                                                                </form>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                        <% } %>
                                                                </div>
                                                                <div style="margin-left: 20px;">
                                                                    <form id="deleteHotelForm_<%= hotel.getHotelId() %>"
                                                                        action="admin" method="post">
                                                                        <input type="hidden" name="action"
                                                                            value="deleteHotel">
                                                                        <input type="hidden" name="hotelId"
                                                                            value="<%= hotel.getHotelId() %>">
                                                                        <button type="button" class="btn btn-danger"
                                                                            onclick="deleteHotel(<%= hotel.getHotelId() %>)">
                                                                            Delete Hotel
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <% } %>
                                                        <% } else { %>
                                                            <div class="alert alert-info">No hotels available. Add your
                                                                first hotel!</div>
                                                            <% } %>
                                </div>
                            </div>

                            <%@ include file="footer.jsp" %>
                                <script src="js/script.js"></script>
                </body>

                </html>