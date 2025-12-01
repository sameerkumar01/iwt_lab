package com.hotel.dao;

import com.hotel.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public boolean createBooking(Booking booking) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO bookings (user_id, hotel_id, room_id, check_in_date, check_out_date, num_guests, total_amount, guest_name, guest_email, guest_phone, payment_status, booking_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, booking.getUserId());
            pstmt.setInt(2, booking.getHotelId());
            pstmt.setInt(3, booking.getRoomId());
            pstmt.setDate(4, booking.getCheckInDate());
            pstmt.setDate(5, booking.getCheckOutDate());
            pstmt.setInt(6, booking.getNumGuests());
            pstmt.setDouble(7, booking.getTotalAmount());
            pstmt.setString(8, booking.getGuestName());
            pstmt.setString(9, booking.getGuestEmail());
            pstmt.setString(10, booking.getGuestPhone());
            pstmt.setString(11, booking.getPaymentStatus());
            pstmt.setString(12, booking.getBookingStatus());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, pstmt, null);
        }
    }

    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT b.*, h.hotel_name, r.room_type FROM bookings b " +
                    "JOIN hotels h ON b.hotel_id = h.hotel_id " +
                    "JOIN rooms r ON b.room_id = r.room_id " +
                    "WHERE b.user_id = ? ORDER BY b.booking_date DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Booking booking = extractBookingFromResultSet(rs);
                booking.setHotelName(rs.getString("hotel_name"));
                booking.setRoomType(rs.getString("room_type"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return bookings;
    }

    public Booking getBookingById(int bookingId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Booking booking = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT b.*, h.hotel_name, r.room_type FROM bookings b " +
                    "JOIN hotels h ON b.hotel_id = h.hotel_id " +
                    "JOIN rooms r ON b.room_id = r.room_id " +
                    "WHERE b.booking_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookingId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                booking = extractBookingFromResultSet(rs);
                booking.setHotelName(rs.getString("hotel_name"));
                booking.setRoomType(rs.getString("room_type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return booking;
    }

    public boolean cancelBooking(int bookingId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE bookings SET booking_status = 'cancelled' WHERE booking_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bookingId);

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, pstmt, null);
        }
    }

    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setHotelId(rs.getInt("hotel_id"));
        booking.setRoomId(rs.getInt("room_id"));
        booking.setCheckInDate(rs.getDate("check_in_date"));
        booking.setCheckOutDate(rs.getDate("check_out_date"));
        booking.setNumGuests(rs.getInt("num_guests"));
        booking.setTotalAmount(rs.getDouble("total_amount"));
        booking.setGuestName(rs.getString("guest_name"));
        booking.setGuestEmail(rs.getString("guest_email"));
        booking.setGuestPhone(rs.getString("guest_phone"));
        booking.setPaymentStatus(rs.getString("payment_status"));
        booking.setBookingStatus(rs.getString("booking_status"));
        booking.setBookingDate(rs.getString("booking_date"));
        return booking;
    }

    private void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
