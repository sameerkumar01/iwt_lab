-- MakeMyTrip Clone Database Schema
-- Database: hotel_booking_db

CREATE DATABASE IF NOT EXISTS hotel_booking_db;
USE hotel_booking_db;

-- Users table (handles both admin and regular users)
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hotels table
CREATE TABLE IF NOT EXISTS hotels (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_name VARCHAR(200) NOT NULL,
    location VARCHAR(200) NOT NULL,
    description TEXT,
    amenities TEXT,
    rating DECIMAL(2,1),
    image_url VARCHAR(500),
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Rooms table
CREATE TABLE IF NOT EXISTS rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_type VARCHAR(100) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    total_rooms INT NOT NULL,
    available_rooms INT NOT NULL,
    capacity INT NOT NULL,
    description TEXT,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id) ON DELETE CASCADE
);

-- Bookings table
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    hotel_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    num_guests INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    guest_name VARCHAR(100) NOT NULL,
    guest_email VARCHAR(100) NOT NULL,
    guest_phone VARCHAR(15) NOT NULL,
    payment_status ENUM('pending', 'completed') DEFAULT 'completed',
    booking_status ENUM('confirmed', 'cancelled') DEFAULT 'confirmed',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Insert sample admin user (password: admin123)
INSERT INTO users (email, password, full_name, phone, role) 
VALUES ('admin@hotel.com', 'admin123', 'Admin User', '9999999999', 'admin')
ON DUPLICATE KEY UPDATE email=email;

-- Insert sample regular user (password: user123)
INSERT INTO users (email, password, full_name, phone, role) 
VALUES ('user@example.com', 'user123', 'Test User', '8888888888', 'user')
ON DUPLICATE KEY UPDATE email=email;

-- Insert sample hotels
INSERT INTO hotels (hotel_name, location, description, amenities, rating, image_url, created_by) 
VALUES 
('Grand Plaza Hotel', 'Mumbai', 'Luxury hotel in the heart of Mumbai with stunning city views', 'WiFi, Pool, Gym, Restaurant, Spa', 4.5, 'https://via.placeholder.com/400x300', 1),
('Taj Palace', 'Delhi', 'Experience royal hospitality in the capital city', 'WiFi, Pool, Gym, Restaurant, Bar, Conference Room', 4.8, 'https://via.placeholder.com/400x300', 1),
('Beach Resort', 'Goa', 'Beachfront resort with pristine beaches and water sports', 'WiFi, Beach Access, Pool, Restaurant, Water Sports', 4.3, 'https://via.placeholder.com/400x300', 1),
('Hill View Resort', 'Shimla', 'Cozy mountain retreat with panoramic Himalayan views', 'WiFi, Fireplace, Restaurant, Mountain View', 4.6, 'https://via.placeholder.com/400x300', 1),
('City Center Inn', 'Bangalore', 'Affordable comfort in the IT hub of India', 'WiFi, Restaurant, Parking', 4.0, 'https://via.placeholder.com/400x300', 1)
ON DUPLICATE KEY UPDATE hotel_name=hotel_name;

-- Insert sample rooms
INSERT INTO rooms (hotel_id, room_type, price_per_night, total_rooms, available_rooms, capacity, description) 
VALUES 
-- Grand Plaza Hotel rooms
(1, 'Deluxe Room', 3500.00, 10, 10, 2, 'Spacious room with king bed and city view'),
(1, 'Executive Suite', 6500.00, 5, 5, 4, 'Luxurious suite with separate living area'),
-- Taj Palace rooms
(2, 'Standard Room', 4000.00, 15, 15, 2, 'Comfortable room with modern amenities'),
(2, 'Royal Suite', 12000.00, 3, 3, 4, 'Premium suite with royal decor'),
-- Beach Resort rooms
(3, 'Beach View Room', 5000.00, 20, 20, 2, 'Room with direct beach view'),
(3, 'Beach Villa', 9000.00, 8, 8, 6, 'Private villa steps away from beach'),
-- Hill View Resort rooms
(4, 'Mountain View Room', 3000.00, 12, 12, 2, 'Cozy room with mountain views'),
(4, 'Cottage', 5500.00, 6, 6, 4, 'Private cottage with fireplace'),
-- City Center Inn rooms
(5, 'Standard Room', 2000.00, 25, 25, 2, 'Clean and comfortable budget room'),
(5, 'Family Room', 3500.00, 10, 10, 4, 'Spacious room for families')
ON DUPLICATE KEY UPDATE room_type=room_type;
