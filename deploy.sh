#!/bin/bash

# Deployment script for Hotel Booking System

echo "==== Hotel Booking System - Deployment Script ===="
echo ""

# Check if TOMCAT_HOME is set
if [ -z "$TOMCAT_HOME" ]; then
    echo "ERROR: TOMCAT_HOME is not set!"
    echo "Please set it with: export TOMCAT_HOME=\"/opt/homebrew/opt/tomcat/libexec\""
    exit 1
fi

echo "1. Copying MySQL connector to WEB-INF/lib..."
cp -v lib/mysql-connector-j-9.5.0.jar webapp/WEB-INF/lib/

echo ""
echo "2. Deploying application to Tomcat..."
rm -rf "$TOMCAT_HOME/webapps/hotel-booking"
cp -r webapp "$TOMCAT_HOME/webapps/hotel-booking"

echo ""
echo "3. Deployment complete!"
echo ""
echo "Next steps:"
echo "  1. Make sure MySQL is running"
echo "  2. Run the database schema: mysql -u root -p < database_schema.sql"
echo "  3. Start Tomcat: $TOMCAT_HOME/bin/startup.sh"
echo "  4. Access the application at: http://localhost:8080/hotel-booking/"
echo ""
echo "Demo credentials:"
echo "  Admin: admin@hotel.com / admin123"
echo "  User: user@example.com / user123"
echo ""
echo "To view logs: tail -f $TOMCAT_HOME/logs/catalina.out"
