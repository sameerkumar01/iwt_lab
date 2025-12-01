# MakeMyTrip Clone - Deployment Guide

## Prerequisites

Before deploying the application, ensure you have the following installed:

1. **Java Development Kit (JDK)** - Version 8 or higher
2. **Apache Tomcat** - Version 9.0 or higher
3. **MySQL Server** - Version 5.7 or higher
4. **MySQL JDBC Driver** - mysql-connector-java-8.0.x.jar

## Step 1: Setup MySQL Database

1. Start your MySQL server
2. Open MySQL command line or MySQL Workbench
3. Run the database schema:

```bash
mysql -u root -p < database_schema.sql
```

Or manually execute the SQL file located at: `database_schema.sql`

**Note**: The password is set to `hello123` in the DatabaseConnection.java file

## Step 2: Download MySQL Connector

1. Download MySQL Connector/J from: https://dev.mysql.com/downloads/connector/j/
2. Extract the JAR file
3. Copy `mysql-connector-java-x.x.xx.jar` to the `lib/` directory in your project

## Step 3: Compile Java Files

Navigate to your project directory and compile:

```bash
# Create classes directory
mkdir -p webapp/WEB-INF/classes

# Compile with servlet-api.jar from Tomcat
javac -cp ".:$TOMCAT_HOME/lib/servlet-api.jar:lib/mysql-connector-java-8.0.30.jar" \
  -d webapp/WEB-INF/classes \
  src/com/hotel/model/*.java \
  src/com/hotel/dao/*.java \
  src/com/hotel/servlet/*.java
```

**For Windows:**
```cmd
javac -cp ".;%TOMCAT_HOME%\lib\servlet-api.jar;lib\mysql-connector-java-8.0.30.jar" ^
  -d webapp\WEB-INF\classes ^
  src\com\hotel\model\*.java ^
  src\com\hotel\dao\*.java ^
  src\com\hotel\servlet\*.java
```

## Step 4: Copy MySQL Connector to Tomcat

Copy the MySQL connector JAR file to:
```bash
cp lib/mysql-connector-java-*.jar $TOMCAT_HOME/lib/
```

Or place it in `webapp/WEB-INF/lib/` directory

## Step 5: Deploy to Tomcat

### Option A: WAR Deployment

1. Create a WAR file:
```bash
cd webapp
jar -cvf hotel-booking.war *
```

2. Copy the WAR file to Tomcat's webapps directory:
```bash
cp hotel-booking.war $TOMCAT_HOME/webapps/
```

3. Restart Tomcat

### Option B: Direct Deployment

1. Copy the entire `webapp` folder to Tomcat's webapps directory:
```bash
cp -r webapp $TOMCAT_HOME/webapps/hotel-booking
```

2. Restart Tomcat

## Step 6: Start Tomcat

### Linux/Mac:
```bash
$TOMCAT_HOME/bin/startup.sh
```

### Windows:
```cmd
%TOMCAT_HOME%\bin\startup.bat
```

## Step 7: Access the Application

Open your browser and navigate to:
```
http://localhost:8080/hotel-booking/
```

or if deployed as ROOT:
```
http://localhost:8080/
```

## Demo Accounts

### Admin Account:
- Email: `admin@hotel.com`
- Password: `admin123`

### User Account:
- Email: `user@example.com`
- Password: `user123`

## Project Structure

```
project1/
├── src/                        # Java source files
│   └── com/hotel/
│       ├── model/             # Model classes
│       ├── dao/               # Database access objects
│       └── servlet/           # Servlet controllers
├── webapp/                    # Web application files
│   ├── WEB-INF/
│   │   ├── web.xml           # Servlet configuration
│   │   ├── classes/          # Compiled Java classes
│   │   └── lib/              # JAR dependencies
│   ├── css/
│   │   └── style.css         # Styling
│   ├── js/
│   │   └── script.js         # JavaScript
│   └── *.jsp                 # JSP pages
├── lib/                      # External libraries
│   └── mysql-connector-java.jar
└── database_schema.sql       # Database schema
```

## Features

### User Features:
- ✅ User registration and login
- ✅ Hotel search by location
- ✅ View hotel details and available rooms
- ✅ Book rooms with date selection
- ✅ View booking history
- ✅ Cancel bookings

### Admin Features:
- ✅ Admin dashboard access
- ✅ Add new hotels
- ✅ Delete hotels
- ✅ Add rooms to hotels
- ✅ Delete rooms
- ✅ Manage hotel inventory

## Troubleshooting

### Issue: ClassNotFoundException for MySQL driver
**Solution**: Ensure mysql-connector-java jar is in `$TOMCAT_HOME/lib/` or `webapp/WEB-INF/lib/`

### Issue: Connection refused to MySQL
**Solution**: 
1. Check if MySQL is running: `mysql -u root -p`
2. Verify credentials in `src/com/hotel/dao/DatabaseConnection.java`
3. Ensure database `hotel_booking_db` exists

### Issue: 404 Error - Page not found
**Solution**: 
1. Check deployment path matches URL
2. Verify Tomcat is running
3. Check web.xml servlet mappings

### Issue: Compilation errors
**Solution**: 
1. Ensure proper classpath includes servlet-api.jar
2. Check Java version compatibility
3. Verify all imports are correct

## Database Configuration

To change database credentials, edit:
`src/com/hotel/dao/DatabaseConnection.java`

```java
private static final String URL = "jdbc:mysql://localhost:3306/hotel_booking_db";
private static final String USER = "root";
private static final String PASSWORD = "your_password";
```

After changing, recompile the Java files.

## Technology Stack

- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: JSP, Servlets, JDBC
- **Server**: Apache Tomcat
- **Database**: MySQL
- **Architecture**: MVC Pattern with DAO Layer

## Support

For issues or questions, refer to:
- Apache Tomcat documentation: https://tomcat.apache.org/
- MySQL documentation: https://dev.mysql.com/doc/
- Java Servlet documentation: https://docs.oracle.com/javaee/7/api/javax/servlet/package-summary.html
