package com.hotel.servlet;

import com.hotel.dao.HotelDAO;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Hotel;
import com.hotel.model.Room;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class HotelDetailsServlet extends HttpServlet {
    private HotelDAO hotelDAO = new HotelDAO();
    private RoomDAO roomDAO = new RoomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String hotelIdParam = request.getParameter("hotelId");

        if (hotelIdParam != null) {
            int hotelId = Integer.parseInt(hotelIdParam);
            Hotel hotel = hotelDAO.getHotelById(hotelId);
            List<Room> rooms = roomDAO.getRoomsByHotelId(hotelId);

            request.setAttribute("hotel", hotel);
            request.setAttribute("rooms", rooms);
            request.getRequestDispatcher("hotel_details.jsp").forward(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}
