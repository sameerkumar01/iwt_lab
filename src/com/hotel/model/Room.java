package com.hotel.model;

public class Room {
    private int roomId;
    private int hotelId;
    private String roomType;
    private double pricePerNight;
    private int totalRooms;
    private int availableRooms;
    private int capacity;
    private String description;

    public Room() {
    }

    public Room(int roomId, int hotelId, String roomType, double pricePerNight,
            int totalRooms, int availableRooms, int capacity, String description) {
        this.roomId = roomId;
        this.hotelId = hotelId;
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
        this.totalRooms = totalRooms;
        this.availableRooms = availableRooms;
        this.capacity = capacity;
        this.description = description;
    }

    // Getters and Setters
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getHotelId() {
        return hotelId;
    }

    public void setHotelId(int hotelId) {
        this.hotelId = hotelId;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public int getTotalRooms() {
        return totalRooms;
    }

    public void setTotalRooms(int totalRooms) {
        this.totalRooms = totalRooms;
    }

    public int getAvailableRooms() {
        return availableRooms;
    }

    public void setAvailableRooms(int availableRooms) {
        this.availableRooms = availableRooms;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isAvailable() {
        return availableRooms > 0;
    }
}
