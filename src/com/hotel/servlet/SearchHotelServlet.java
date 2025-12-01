package com.hotel.servlet;

import com.hotel.dao.HotelDAO;
import com.hotel.model.Hotel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class SearchHotelServlet extends HttpServlet {
    private HotelDAO hotelDAO = new HotelDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String location = request.getParameter("location");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");

        // Store search parameters in session
        HttpSession session = request.getSession();
        session.setAttribute("searchLocation", location);
        session.setAttribute("searchCheckIn", checkIn);
        session.setAttribute("searchCheckOut", checkOut);

        List<Hotel> hotels = hotelDAO.searchHotelsByLocation(location);

        request.setAttribute("hotels", hotels);
        request.setAttribute("searchLocation", location);
        request.getRequestDispatcher("hotels.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If accessed directly, show all hotels
        List<Hotel> hotels = hotelDAO.getAllHotels();
        request.setAttribute("hotels", hotels);
        request.getRequestDispatcher("hotels.jsp").forward(request, response);
    }
}
