# Tomcat Compatibility Issue & Solution

## Problem

Your Tomcat installation appears to have compatibility issues with the servlet-api.jar file. The jar contains the correct classes but javac cannot find them due to a misconfigured classpath or installation issue.

## Quick Solution: Download Correct Servlet API

Download the javax.servlet-api jar file manually:

```bash
cd lib
curl -O https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar
```

Then compile with:

```bash
javac -cp "lib/javax.servlet-api-4.0.1.jar:lib/mysql-connector-j-9.5.0.jar" \
  -d webapp/WEB-INF/classes \
  src/com/hotel/model/*.java \
  src/com/hotel/dao/*.java \
  src/com/hotel/servlet/*.java
```

## Alternative: Use Pre-compiled Classes

If compilation continues to fail, you can deploy without pre-compilation and let Tomcat's JSP engine compile them at runtime:

1. **Setup database**:
```bash
mysql -u root -p < database_schema.sql
# Password: hello123
```

2. **Copy everything to Tomcat**:
```bash
# Copy MySQL connector
cp lib/mysql-connector-j-9.5.0.jar webapp/WEB-INF/lib/

# Copy source files to WEB-INF/classes (Tomcat will compile)
mkdir -p webapp/WEB-INF/classes
cp -r src/com webapp/WEB-INF/classes/

# Deploy to Tom cat
cp -r webapp "$TOMCAT_HOME/webapps/hotel-booking"
```

3. **Start Tomcat**:
```bash
$TOMCAT_HOME/bin/startup.sh
```

4. **Access**:
```
http://localhost:8080/hotel-booking/
```

5. **Check logs if issues**:
```bash
tail -f $TOMCAT_HOME/logs/catalina.out
```

## If You Want to Use Tomcat 10+

Your Tomcat 10 uses Jakarta EE. If you want to use it, the servlet imports need to change from `javax.servlet` to `jakarta.servlet`. However, there seems to be an issue with your servlet-api.jar.

You can either:
1. Reinstall Tomcat 10 properly
2. Use Tomcat 9 instead (recommended for this project)
3. Download jakarta.servlet-api manually

To download Jakarta API for Tomcat 10:
```bash
cd lib
curl -O https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/5.0.0/jakarta.servlet-api-5.0.0.jar
```

Then update the servlet imports and compile.

## Recommended Action

**Try Option 1 first** (download javax.servlet-api), as it's the simplest and most compatible.
