package com.hotel.servlet;

import com.hotel.dao.BookingDAO;
import com.hotel.model.Booking;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class MyBookingsServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Booking> bookings = bookingDAO.getBookingsByUserId(userId);
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("my_bookings.jsp").forward(request, response);
    }
}
