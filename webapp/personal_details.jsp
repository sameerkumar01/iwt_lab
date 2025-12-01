<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.hotel.dao.HotelDAO, com.hotel.dao.RoomDAO" %>
        <%@ page import="com.hotel.model.Hotel, com.hotel.model.Room" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Personal Details - Hotel Booking</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <%@ include file="navbar.jsp" %>

                    <div class="content">
                        <div class="container">
                            <% // Check if user is logged in if (session.getAttribute("user")==null) {
                                session.setAttribute("redirectUrl", request.getRequestURL() + "?" +
                                request.getQueryString()); response.sendRedirect("login.jsp"); } else { String
                                roomIdStr=request.getParameter("roomId"); String
                                hotelIdStr=request.getParameter("hotelId"); if (roomIdStr !=null && hotelIdStr !=null) {
                                int roomId=Integer.parseInt(roomIdStr); int hotelId=Integer.parseInt(hotelIdStr);
                                HotelDAO hotelDAO=new HotelDAO(); RoomDAO roomDAO=new RoomDAO(); Hotel
                                hotel=hotelDAO.getHotelById(hotelId); Room room=roomDAO.getRoomById(roomId); String
                                checkIn=(String) session.getAttribute("searchCheckIn"); String checkOut=(String)
                                session.getAttribute("searchCheckOut"); if (checkIn==null)
                                checkIn=request.getParameter("checkIn"); if (checkOut==null)
                                checkOut=request.getParameter("checkOut"); %>

                                <h2>Enter Guest Details</h2>

                                <div
                                    style="display: grid; grid-template-columns: 1fr 400px; gap: 30px; margin-top: 30px;">
                                    <!-- Guest Details Form -->
                                    <div class="form-container" style="margin: 0;">
                                        <form action="payment.jsp" method="post"
                                            onsubmit="return validatePersonalDetailsForm()">
                                            <input type="hidden" name="roomId" value="<%= roomId %>">
                                            <input type="hidden" name="hotelId" value="<%= hotelId %>">
                                            <input type="hidden" name="checkIn" value="<%= checkIn %>">
                                            <input type="hidden" name="checkOut" value="<%= checkOut %>">

                                            <div class="form-group">
                                                <label for="guestName">Full Name</label>
                                                <input type="text" id="guestName" name="guestName"
                                                    value="<%= session.getAttribute(" userName") %>" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="guestEmail">Email</label>
                                                <input type="email" id="guestEmail" name="guestEmail"
                                                    value="<%= session.getAttribute(" userEmail") %>" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="guestPhone">Phone Number</label>
                                                <input type="tel" id="guestPhone" name="guestPhone" pattern="[0-9]{10}"
                                                    placeholder="10-digit phone number" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="numGuests">Number of Guests</label>
                                                <input type="number" id="numGuests" name="numGuests" min="1"
                                                    max="<%= room.getCapacity() %>" value="1" required>
                                            </div>

                                            <button type="submit" class="btn btn-primary">Proceed to Payment</button>
                                        </form>
                                    </div>

                                    <!-- Booking Summary -->
                                    <div class="booking-summary">
                                        <h3 style="margin-bottom: 20px;">Booking Summary</h3>
                                        <div class="summary-row">
                                            <span>Hotel:</span>
                                            <strong>
                                                <%= hotel.getHotelName() %>
                                            </strong>
                                        </div>
                                        <div class="summary-row">
                                            <span>Room Type:</span>
                                            <strong>
                                                <%= room.getRoomType() %>
                                            </strong>
                                        </div>
                                        <div class="summary-row">
                                            <span>Check-in:</span>
                                            <strong>
                                                <%= checkIn %>
                                            </strong>
                                        </div>
                                        <div class="summary-row">
                                            <span>Check-out:</span>
                                            <strong>
                                                <%= checkOut %>
                                            </strong>
                                        </div>
                                        <% if (checkIn !=null && checkOut !=null) { java.sql.Date
                                            checkInDate=java.sql.Date.valueOf(checkIn); java.sql.Date
                                            checkOutDate=java.sql.Date.valueOf(checkOut); long
                                            nights=(checkOutDate.getTime() - checkInDate.getTime()) / (1000 * 60 * 60 *
                                            24); double total=room.getPricePerNight() * nights; %>
                                            <div class="summary-row">
                                                <span>Nights:</span>
                                                <strong>
                                                    <%= nights %>
                                                </strong>
                                            </div>
                                            <div class="summary-row">
                                                <span>Price per night:</span>
                                                <strong>₹<%= String.format("%.0f", room.getPricePerNight()) %></strong>
                                            </div>
                                            <div class="summary-row">
                                                <span>Total Amount:</span>
                                                <strong>₹<%= String.format("%.2f", total) %></strong>
                                            </div>
                                            <% } %>
                                    </div>
                                </div>

                                <% } else { %>
                                    <div class="alert alert-error">Invalid booking details.</div>
                                    <a href="index.jsp" class="btn btn-primary">Back to Home</a>
                                    <% } } %>
                        </div>
                    </div>

                    <%@ include file="footer.jsp" %>
                        <script src="js/script.js"></script>
            </body>

            </html>