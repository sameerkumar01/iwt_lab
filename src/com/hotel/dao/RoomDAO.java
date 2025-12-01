package com.hotel.dao;

import com.hotel.model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    public List<Room> getRoomsByHotelId(int hotelId) {
        List<Room> rooms = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM rooms WHERE hotel_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, hotelId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                Room room = extractRoomFromResultSet(rs);
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return rooms;
    }

    public Room getRoomById(int roomId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Room room = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM rooms WHERE room_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, roomId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                room = extractRoomFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }

        return room;
    }

    public boolean addRoom(Room room) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO rooms (hotel_id, room_type, price_per_night, total_rooms, available_rooms, capacity, description) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, room.getHotelId());
            pstmt.setString(2, room.getRoomType());
            pstmt.setDouble(3, room.getPricePerNight());
            pstmt.setInt(4, room.getTotalRooms());
            pstmt.setInt(5, room.getAvailableRooms());
            pstmt.setInt(6, room.getCapacity());
            pstmt.setString(7, room.getDescription());

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, pstmt, null);
        }
    }

    public boolean deleteRoom(int roomId) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM rooms WHERE room_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, roomId);

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, pstmt, null);
        }
    }

    public boolean updateRoomAvailability(int roomId, int availableRooms) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE rooms SET available_rooms = ? WHERE room_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, availableRooms);
            pstmt.setInt(2, roomId);

            int result = pstmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResources(conn, pstmt, null);
        }
    }

    private Room extractRoomFromResultSet(ResultSet rs) throws SQLException {
        Room room = new Room();
        room.setRoomId(rs.getInt("room_id"));
        room.setHotelId(rs.getInt("hotel_id"));
        room.setRoomType(rs.getString("room_type"));
        room.setPricePerNight(rs.getDouble("price_per_night"));
        room.setTotalRooms(rs.getInt("total_rooms"));
        room.setAvailableRooms(rs.getInt("available_rooms"));
        room.setCapacity(rs.getInt("capacity"));
        room.setDescription(rs.getString("description"));
        return room;
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
