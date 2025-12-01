// Form Validation
function validateSearchForm() {
    const location = document.getElementById('location').value.trim();
    const checkIn = document.getElementById('checkIn').value;
    const checkOut = document.getElementById('checkOut').value;
    
    if (!location) {
        alert('Please enter a location');
        return false;
    }
    
    if (!checkIn || !checkOut) {
        alert('Please select check-in and check-out dates');
        return false;
    }
    
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    if (checkInDate < today) {
        alert('Check-in date cannot be in the past');
        return false;
    }
    
    if (checkOutDate <= checkInDate) {
        alert('Check-out date must be after check-in date');
        return false;
    }
    
    return true;
}

function validateLoginForm() {
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;
    
    if (!email || !password) {
        alert('Please fill in all fields');
        return false;
    }
    
    if (!isValidEmail(email)) {
        alert('Please enter a valid email address');
        return false;
    }
    
    return true;
}

function validateRegisterForm() {
    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const fullName = document.getElementById('fullName').value.trim();
    const phone = document.getElementById('phone').value.trim();
    
    if (!email || !password || !confirmPassword || !fullName || !phone) {
        alert('Please fill in all fields');
        return false;
    }
    
    if (!isValidEmail(email)) {
        alert('Please enter a valid email address');
        return false;
    }
    
    if (password.length < 6) {
        alert('Password must be at least 6 characters long');
        return false;
    }
    
    if (password !== confirmPassword) {
        alert('Passwords do not match');
        return false;
    }
    
    if (!isValidPhone(phone)) {
        alert('Please enter a valid phone number');
        return false;
    }
    
    return true;
}

function validatePersonalDetailsForm() {
    const guestName = document.getElementById('guestName').value.trim();
    const guestEmail = document.getElementById('guestEmail').value.trim();
    const guestPhone = document.getElementById('guestPhone').value.trim();
    
    if (!guestName || !guestEmail || !guestPhone) {
        alert('Please fill in all fields');
        return false;
    }
    
    if (!isValidEmail(guestEmail)) {
        alert('Please enter a valid email address');
        return false;
    }
    
    if (!isValidPhone(guestPhone)) {
        alert('Please enter a valid phone number');
        return false;
    }
    
    return true;
}

function validatePaymentForm() {
    const cardNumber = document.getElementById('cardNumber').value.trim();
    const cardName = document.getElementById('cardName').value.trim();
    const expiryDate = document.getElementById('expiryDate').value.trim();
    const cvv = document.getElementById('cvv').value.trim();
    
    if (!cardNumber || !cardName || !expiryDate || !cvv) {
        alert('Please fill in all payment fields');
        return false;
    }
    
    if (cardNumber.length !== 16 || isNaN(cardNumber)) {
        alert('Please enter a valid 16-digit card number');
        return false;
    }
    
    if (cvv.length !== 3 || isNaN(cvv)) {
        alert('Please enter a valid 3-digit CVV');
        return false;
    }
    
    return true;
}

function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function isValidPhone(phone) {
    const phoneRegex = /^[0-9]{10}$/;
    return phoneRegex.test(phone);
}

// Calculate Total Amount
function calculateTotal(pricePerNight, checkIn, checkOut) {
    const checkInDate = new Date(checkIn);
    const checkOutDate = new Date(checkOut);
    const nights = Math.ceil((checkOutDate - checkInDate) / (1000 * 60 * 60 * 24));
    return pricePerNight * nights;
}

// Set Minimum Dates for Date Inputs
function setMinDates() {
    const today = new Date().toISOString().split('T')[0];
    const checkInInput = document.getElementById('checkIn');
    const checkOutInput = document.getElementById('checkOut');
    
    if (checkInInput) {
        checkInInput.min = today;
        
        checkInInput.addEventListener('change', function() {
            if (checkOutInput) {
                const nextDay = new Date(this.value);
                nextDay.setDate(nextDay.getDate() + 1);
                checkOutInput.min = nextDay.toISOString().split('T')[0];
            }
        });
    }
}

// Confirm Cancellation
function confirmCancel(bookingId) {
    if (confirm('Are you sure you want to cancel this booking?')) {
        document.getElementById('cancelForm_' + bookingId).submit();
    }
}

// Initialize on Page Load
document.addEventListener('DOMContentLoaded', function() {
    setMinDates();
    
    // Auto-hide alerts after 5 seconds
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
        setTimeout(function() {
            alert.style.display = 'none';
        }, 5000);
    });
});

// Format Currency
function formatCurrency(amount) {
    return '₹' + amount.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
}

// Room Selection
function selectRoom(roomId, roomType, pricePerNight, hotelId) {
    const checkIn = sessionStorage.getItem('checkIn') || '';
    const checkOut = sessionStorage.getItem('checkOut') || '';
    
    if (!checkIn || !checkOut) {
        alert('Please search with dates first');
        window.location.href = 'index.jsp';
        return;
    }
    
    const nights = Math.ceil((new Date(checkOut) - new Date(checkIn)) / (1000 * 60 * 60 * 24));
    const total = pricePerNight * nights;
    
    window.location.href = 'personal_details.jsp?roomId=' + roomId + 
                          '&hotelId=' + hotelId + 
                          '&checkIn=' + checkIn + 
                          '&checkOut=' + checkOut + 
                          '&total=' + total +
                          '&roomType=' + encodeURIComponent(roomType) +
                          '&pricePerNight=' + pricePerNight;
}

// Admin Functions
function toggleAddHotelForm() {
    const form = document.getElementById('addHotelForm');
    form.style.display = form.style.display === 'none' ? 'block' : 'none';
}

function toggleAddRoomForm() {
    const form = document.getElementById('addRoomForm');
    form.style.display = form.style.display === 'none' ? 'block' : 'none';
}

function deleteHotel(hotelId) {
    if (confirm('Are you sure you want to delete this hotel? This will also delete all associated rooms.')) {
        document.getElementById('deleteHotelForm_' + hotelId).submit();
    }
}

function deleteRoom(roomId) {
    if (confirm('Are you sure you want to delete this room?')) {
        document.getElementById('deleteRoomForm_' + roomId).submit();
    }
}
