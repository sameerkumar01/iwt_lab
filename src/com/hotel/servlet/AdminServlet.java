package com.hotel.servlet;

import com.hotel.dao.HotelDAO;
import com.hotel.dao.RoomDAO;
import com.hotel.model.Hotel;
import com.hotel.model.Room;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AdminServlet extends HttpServlet {
    private HotelDAO hotelDAO = new HotelDAO();
    private RoomDAO roomDAO = new RoomDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        Integer userId = (Integer) session.getAttribute("userId");

        // Check if user is admin
        if (!"admin".equals(userRole)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("addHotel".equals(action)) {
            String hotelName = request.getParameter("hotelName");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String amenities = request.getParameter("amenities");
            double rating = Double.parseDouble(request.getParameter("rating"));
            String imageUrl = request.getParameter("imageUrl");

            Hotel hotel = new Hotel();
            hotel.setHotelName(hotelName);
            hotel.setLocation(location);
            hotel.setDescription(description);
            hotel.setAmenities(amenities);
            hotel.setRating(rating);
            hotel.setImageUrl(imageUrl);
            hotel.setCreatedBy(userId);

            hotelDAO.addHotel(hotel);
            response.sendRedirect("admin_dashboard.jsp?success=Hotel added successfully");

        } else if ("deleteHotel".equals(action)) {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            hotelDAO.deleteHotel(hotelId);
            response.sendRedirect("admin_dashboard.jsp?success=Hotel deleted successfully");

        } else if ("addRoom".equals(action)) {
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            String roomType = request.getParameter("roomType");
            double pricePerNight = Double.parseDouble(request.getParameter("pricePerNight"));
            int totalRooms = Integer.parseInt(request.getParameter("totalRooms"));
            int capacity = Integer.parseInt(request.getParameter("capacity"));
            String description = request.getParameter("description");

            Room room = new Room();
            room.setHotelId(hotelId);
            room.setRoomType(roomType);
            room.setPricePerNight(pricePerNight);
            room.setTotalRooms(totalRooms);
            room.setAvailableRooms(totalRooms);
            room.setCapacity(capacity);
            room.setDescription(description);

            roomDAO.addRoom(room);
            response.sendRedirect("admin_dashboard.jsp?success=Room added successfully");

        } else if ("deleteRoom".equals(action)) {
            int roomId = Integer.parseInt(request.getParameter("roomId"));
            roomDAO.deleteRoom(roomId);
            response.sendRedirect("admin_dashboard.jsp?success=Room deleted successfully");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if (!"admin".equals(userRole)) {
            response.sendRedirect("index.jsp");
            return;
        }

        List<Hotel> hotels = hotelDAO.getAllHotels();
        request.setAttribute("hotels", hotels);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
