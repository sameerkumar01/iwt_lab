<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.hotel.dao.HotelDAO, com.hotel.dao.RoomDAO" %>
        <%@ page import="com.hotel.model.Hotel, com.hotel.model.Room" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Payment - Hotel Booking</title>
                <link rel="stylesheet" href="css/style.css">
            </head>

            <body>
                <%@ include file="navbar.jsp" %>

                    <div class="content">
                        <div class="container">
                            <% String roomIdStr=request.getParameter("roomId"); String
                                hotelIdStr=request.getParameter("hotelId"); String
                                checkIn=request.getParameter("checkIn"); String
                                checkOut=request.getParameter("checkOut"); String
                                guestName=request.getParameter("guestName"); String
                                guestEmail=request.getParameter("guestEmail"); String
                                guestPhone=request.getParameter("guestPhone"); String
                                numGuestsStr=request.getParameter("numGuests"); if (roomIdStr !=null && hotelIdStr
                                !=null) { int roomId=Integer.parseInt(roomIdStr); int
                                hotelId=Integer.parseInt(hotelIdStr); int numGuests=Integer.parseInt(numGuestsStr);
                                HotelDAO hotelDAO=new HotelDAO(); RoomDAO roomDAO=new RoomDAO(); Hotel
                                hotel=hotelDAO.getHotelById(hotelId); Room room=roomDAO.getRoomById(roomId);
                                java.sql.Date checkInDate=java.sql.Date.valueOf(checkIn); java.sql.Date
                                checkOutDate=java.sql.Date.valueOf(checkOut); long nights=(checkOutDate.getTime() -
                                checkInDate.getTime()) / (1000 * 60 * 60 * 24); double
                                totalAmount=room.getPricePerNight() * nights; %>

                                <h2>Complete Payment</h2>

                                <div
                                    style="display: grid; grid-template-columns: 1fr 400px; gap: 30px; margin-top: 30px;">
                                    <!-- Payment Form -->
                                    <div class="form-container" style="margin: 0;">
                                        <h3>Card Details</h3>
                                        <p style="color: #666; font-size: 14px; margin-bottom: 20px;">
                                            This is a demo payment form. No actual charges will be made.
                                        </p>

                                        <form action="booking" method="post" onsubmit="return validatePaymentForm()">
                                            <input type="hidden" name="action" value="confirmBooking">
                                            <input type="hidden" name="roomId" value="<%= roomId %>">
                                            <input type="hidden" name="hotelId" value="<%= hotelId %>">
                                            <input type="hidden" name="checkIn" value="<%= checkIn %>">
                                            <input type="hidden" name="checkOut" value="<%= checkOut %>">
                                            <input type="hidden" name="numGuests" value="<%= numGuests %>">
                                            <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
                                            <input type="hidden" name="guestName" value="<%= guestName %>">
                                            <input type="hidden" name="guestEmail" value="<%= guestEmail %>">
                                            <input type="hidden" name="guestPhone" value="<%= guestPhone %>">

                                            <div class="form-group">
                                                <label for="cardNumber">Card Number</label>
                                                <input type="text" id="cardNumber" name="cardNumber"
                                                    placeholder="1234 5678 9012 3456" maxlength="16" required>
                                            </div>

                                            <div class="form-group">
                                                <label for="cardName">Cardholder Name</label>
                                                <input type="text" id="cardName" name="cardName"
                                                    placeholder="Name on card" required>
                                            </div>

                                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px;">
                                                <div class="form-group">
                                                    <label for="expiryDate">Expiry Date</label>
                                                    <input type="text" id="expiryDate" name="expiryDate"
                                                        placeholder="MM/YY" maxlength="5" required>
                                                </div>

                                                <div class="form-group">
                                                    <label for="cvv">CVV</label>
                                                    <input type="text" id="cvv" name="cvv" placeholder="123"
                                                        maxlength="3" required>
                                                </div>
                                            </div>

                                            <button type="submit" class="btn btn-success" style="margin-top: 20px;">
                                                Pay ₹<%= String.format("%.2f", totalAmount) %>
                                            </button>
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
                                            <span>Guest:</span>
                                            <strong>
                                                <%= guestName %>
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
                                        <div class="summary-row">
                                            <span>Nights:</span>
                                            <strong>
                                                <%= nights %>
                                            </strong>
                                        </div>
                                        <div class="summary-row">
                                            <span>Guests:</span>
                                            <strong>
                                                <%= numGuests %>
                                            </strong>
                                        </div>
                                        <div class="summary-row">
                                            <span>Price per night:</span>
                                            <strong>₹<%= String.format("%.0f", room.getPricePerNight()) %></strong>
                                        </div>
                                        <div class="summary-row">
                                            <span>Total Amount:</span>
                                            <strong>₹<%= String.format("%.2f", totalAmount) %></strong>
                                        </div>
                                    </div>
                                </div>

                                <% } else { %>
                                    <div class="alert alert-error">Invalid payment details.</div>
                                    <a href="index.jsp" class="btn btn-primary">Back to Home</a>
                                    <% } %>
                        </div>
                    </div>

                    <%@ include file="footer.jsp" %>
                        <script src="js/script.js"></script>
            </body>

            </html>