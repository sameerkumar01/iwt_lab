# Quick Deployment Guide for Tomcat 10+

## Important: For Tomcat 10+

Your system has Tomcat 10+ which uses **Jakarta EE** (jakarta.servlet) instead of Java EE (javax.servlet).

## Quick Deployment Steps

Since compilation is proving difficult with classpath issues, here's the easiest approach:

### Option 1: Deploy and Let Tomcat Compile (Recommended)

1. **Copy MySQL Connector to WEB-INF/lib**:
```bash
mkdir -p webapp/WEB-INF/lib
cp lib/mysql-connector-j-9.5.0.jar webapp/WEB-INF/lib/
```

2. **Deploy to Tomcat**:
```bash
cp -r webapp "$TOMCAT_HOME/webapps/hotel-booking"
```

3. **Copy Source Files** (Tomcat will compile them):
```bash
mkdir -p "$TOMCAT_HOME/webapps/hotel-booking/WEB-INF/classes"
cp -r src/com "$TOMCAT_HOME/webapps/hotel-booking/WEB-INF/classes/"
```

4. **Start Tomcat**:
```bash
$TOMCAT_HOME/bin/startup.sh
```

5. **Access**: `http://localhost:8080/hotel-booking/`

### Option 2: Manual Compilation with All JARs

If you want to compile manually, you need ALL the jars:

```bash
javac -cp "$TOMCAT_HOME/lib/*:lib/mysql-connector-j-9.5.0.jar" \
  -d webapp/WEB-INF/classes \
  src/com/hotel/model/*.java \
  src/com/hotel/dao/*.java \
  src/com/hotel/servlet/*.java
```

Then deploy:
```bash
cp lib/mysql-connector-j-9.5.0.jar webapp/WEB-INF/lib/
cp -r webapp "$TOMCAT_HOME/webapps/hotel-booking"
$TOMCAT_HOME/bin/startup.sh
```

## Database Setup

Before starting Tomcat, make sure you've set up the database:

```bash
mysql -u root -p < database_schema.sql
# Enter password: hello123
```

## Check Logs

If there are any issues:
```bash
tail -f $TOMCAT_HOME/logs/catalana.out
```

## Important Note

All servlet files have been updated to use `jakarta.servlet` packages for Tomcat 10+ compatibility.
