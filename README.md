# Hotel Booking System - MakeMyTrip Clone

A full-stack hotel booking web application built with JSP, Servlets, JDBC, and MySQL.

## Features

### 🔐 User Authentication
- User registration and login
- Admin and regular user roles
- Session management

### 🏨 Hotel Booking
- Search hotels by location
- View hotel details and amenities
- Browse available rooms
- Complete booking flow:
  - Personal details entry
  - Payment processing
  - Booking confirmation

### 📝 User Dashboard
- View all bookings
- Cancel bookings
- Booking history

### 👨‍💼 Admin Dashboard
- Add/delete hotels
- Manage rooms (add/delete)
- View hotel inventory
- Complete hotel management system

## Technology Stack

- **Frontend**: HTML, CSS, JavaScript
- **Backend**: JSP, Java Servlets, JDBC
- **Server**: Apache Tomcat
- **Database**: MySQL
- **Architecture**: MVC with DAO Pattern

## Quick Start

1. **Setup MySQL Database**
   ```bash
   mysql -u root -p < database_schema.sql
   ```

2. **Configure Database Connection**
   - Update credentials in `src/com/hotel/dao/DatabaseConnection.java`
   - Default password: `hello@123`

3. **Download MySQL Connector**
   - Place `mysql-connector-java-x.x.xx.jar` in `lib/` directory

4. **Compile Java Files**
   ```bash
   javac -cp ".:$TOMCAT_HOME/lib/servlet-api.jar:lib/mysql-connector-java-8.0.30.jar" \
     -d webapp/WEB-INF/classes \
     src/com/hotel/model/*.java \
     src/com/hotel/dao/*.java \
     src/com/hotel/servlet/*.java
   ```

5. **Deploy to Tomcat**
   ```bash
   cp -r webapp $TOMCAT_HOME/webapps/hotel-booking
   $TOMCAT_HOME/bin/startup.sh
   ```

6. **Access Application**
   ```
   http://localhost:8080/hotel-booking/
   ```

## Demo Accounts

**Admin:**
- Email: `admin@hotel.com`
- Password: `admin123`

**User:**
- Email: `user@example.com`
- Password: `user123`

## Project Structure

```
project1/
├── src/                    # Java source files
│   └── com/hotel/
│       ├── model/         # Entity classes
│       ├── dao/           # Data access layer
│       └── servlet/       # Controllers
├── webapp/                # Web application
│   ├── WEB-INF/
│   │   ├── web.xml       # Configuration
│   │   └── classes/      # Compiled classes
│   ├── css/              # Stylesheets
│   ├── js/               # JavaScript
│   └── *.jsp             # JSP pages
├── lib/                  # Dependencies
└── database_schema.sql   # Database schema
```

## Documentation

For detailed setup and deployment instructions, see [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md)

## Screenshots

- Landing page with search
- Hotel listing and details
- Booking flow (personal details → payment → success)
- User bookings dashboard
- Admin management panel

## License

This is an educational project for IWT Lab.

## Author

Developed as part of IWT (Internet and Web Technologies) Lab Project
