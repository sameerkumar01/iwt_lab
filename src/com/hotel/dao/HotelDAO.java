package com.hotel.dao;

import com.hotel.model.Hotel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HotelDAO {

    public List<Hotel> searchHotelsByLocation(String location) {
        List<Hotel> hotels = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM hotels WHERE LOWER(location) LIKE LOWER(?) ORDER BY rating DESC";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + location + "%");

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Hotel hotel = extractHotelFromResultSet(rs);
                hotels.add(hotel);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return hotels;
    }

    public Hotel getHotelById(int hotelId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Hotel hotel = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM hotels WHERE hotel_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, hotelId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                hotel = extractHotelFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return hotel;
    }

    public List<Hotel> getAllHotels() {
        List<Hotel> hotels = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM hotels ORDER BY created_at DESC";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Hotel hotel = extractHotelFromResultSet(rs);
                hotels.add(hotel);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return hotels;
    }

    public boolean addHotel(Hotel hotel) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO hotels (hotel_name, location, description, amenities, rating, image_url, created_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, hotel.getHotelName());
            pstmt.setString(2, hotel.getLocation());
            pstmt.setString(3, hotel.getDescription());
            pstmt.setString(4, hotel.getAmenities());
            pstmt.setDouble(5, hotel.getRating());
            pstmt.setString(6, hotel.getImageUrl());
            pstmt.setInt(7, hotel.getCreatedBy());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, pstmt, null);
        }
    }

    public boolean deleteHotel(int hotelId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM hotels WHERE hotel_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, hotelId);

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, pstmt, null);
        }
    }

    private Hotel extractHotelFromResultSet(ResultSet rs) throws SQLException {
        Hotel hotel = new Hotel();
        hotel.setHotelId(rs.getInt("hotel_id"));
        hotel.setHotelName(rs.getString("hotel_name"));
        hotel.setLocation(rs.getString("location"));
        hotel.setDescription(rs.getString("description"));
        hotel.setAmenities(rs.getString("amenities"));
        hotel.setRating(rs.getDouble("rating"));
        hotel.setImageUrl(rs.getString("image_url"));
        hotel.setCreatedBy(rs.getInt("created_by"));
        return hotel;
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
