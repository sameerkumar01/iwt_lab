package com.hotel.servlet;

import com.hotel.dao.BookingDAO;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Booking;
import com.hotel.model.Room;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();
    private RoomDAO roomDAO = new RoomDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Check if user is logged in
        if (userId == null) {
            session.setAttribute("redirectUrl", "personal_details.jsp?" + request.getQueryString());
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("cancel".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            boolean cancelled = bookingDAO.cancelBooking(bookingId);

            if (cancelled) {
                // Update room availability
                Booking booking = bookingDAO.getBookingById(bookingId);
                Room room = roomDAO.getRoomById(booking.getRoomId());
                roomDAO.updateRoomAvailability(room.getRoomId(), room.getAvailableRooms() + 1);
            }

            response.sendRedirect("myBookings");
        } else if ("confirmBooking".equals(action)) {
            // Create booking
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            String checkIn = request.getParameter("checkIn");
            String checkOut = request.getParameter("checkOut");
            int numGuests = Integer.parseInt(request.getParameter("numGuests"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            String guestName = request.getParameter("guestName");
            String guestEmail = request.getParameter("guestEmail");
            String guestPhone = request.getParameter("guestPhone");

            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setHotelId(hotelId);
            booking.setRoomId(roomId);
            booking.setCheckInDate(Date.valueOf(checkIn));
            booking.setCheckOutDate(Date.valueOf(checkOut));
            booking.setNumGuests(numGuests);
            booking.setTotalAmount(totalAmount);
            booking.setGuestName(guestName);
            booking.setGuestEmail(guestEmail);
            booking.setGuestPhone(guestPhone);
            booking.setPaymentStatus("completed");
            booking.setBookingStatus("confirmed");

            boolean created = bookingDAO.createBooking(booking);

            if (created) {
                // Update room availability
                Room room = roomDAO.getRoomById(roomId);
                roomDAO.updateRoomAvailability(roomId, room.getAvailableRooms() - 1);

                session.setAttribute("bookingSuccess", true);
                response.sendRedirect("success.jsp");
            } else {
                request.setAttribute("error", "Booking failed. Please try again.");
                request.getRequestDispatcher("payment.jsp").forward(request, response);
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}
