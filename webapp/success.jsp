<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking Confirmed - Hotel Booking</title>
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <%@ include file="navbar.jsp" %>

            <div class="content">
                <div class="container">
                    <div class="success-container">
                        <div class="success-icon">✓</div>
                        <h1>Booking Confirmed!</h1>
                        <p style="font-size: 18px; color: #666; margin-bottom: 30px;">
                            Your hotel reservation has been successfully confirmed.
                        </p>

                        <div style="background: white; padding: 30px; border-radius: 10px; 
                            box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 500px; margin: 0 auto;">
                            <p style="color: #666; margin-bottom: 20px;">
                                A confirmation email has been sent to your registered email address
                                with all booking details.
                            </p>

                            <div style="display: flex; gap: 15px; justify-content: center; margin-top: 30px;">
                                <a href="myBookings" class="btn btn-primary">View My Bookings</a>
                                <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
                            </div>
                        </div>

                        <div style="margin-top: 40px; padding: 20px; background: #e3f2fd; 
                            border-radius: 10px; max-width: 500px; margin: 40px auto 0;">
                            <h3 style="margin-bottom: 15px; color: #1976d2;">What's Next?</h3>
                            <ul style="text-align: left; color: #555;">
                                <li style="margin-bottom: 10px;">Check your email for booking confirmation</li>
                                <li style="margin-bottom: 10px;">View or manage your booking from "My Bookings"</li>
                                <li style="margin-bottom: 10px;">Arrive at the hotel on your check-in date</li>
                                <li>Present your booking confirmation at the reception</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <%@ include file="footer.jsp" %>
                <script src="js/script.js"></script>
    </body>

    </html>