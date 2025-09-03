# Setup Instructions for Bajaj Finserv Health Qualifier

## Quick Setup (Automated)

### Option 1: Windows Batch File
```bash
setup.bat
```

### Option 2: PowerShell Script
```powershell
.\setup.ps1
```

## Manual Setup

### Step 1: Install Java 11
1. Download OpenJDK 11 from: https://adoptium.net/temurin/releases/?version=11
2. Extract to a folder (e.g., `C:\Java\jdk-11`)
3. Set environment variables:
   - `JAVA_HOME` = `C:\Java\jdk-11`
   - Add `%JAVA_HOME%\bin` to `PATH`

### Step 2: Install Maven (Optional)
1. Download Maven from: https://maven.apache.org/download.cgi
2. Extract to a folder (e.g., `C:\Maven\apache-maven-3.9.5`)
3. Set environment variables:
   - `M2_HOME` = `C:\Maven\apache-maven-3.9.5`
   - Add `%M2_HOME%\bin` to `PATH`

### Step 3: Build and Run
```bash
# Using Maven wrapper (recommended)
mvnw.cmd clean package
java -jar target/bajaj-qualifier-1.0.jar

# Using Maven (if installed)
mvn clean package
java -jar target/bajaj-qualifier-1.0.jar
```

## Verify Installation

### Check Java
```bash
java -version
# Should show Java 11.x.x
```

### Check Maven
```bash
mvn -version
# Should show Maven 3.x.x
```

## Troubleshooting

### Java not found
- Ensure `JAVA_HOME` is set correctly
- Restart command prompt after setting environment variables
- Check if Java is in your `PATH`

### Maven not found
- Use the Maven wrapper: `mvnw.cmd` instead of `mvn`
- Ensure `M2_HOME` is set correctly if using global Maven

### Build errors
- Ensure Java 11 is installed and in PATH
- Check internet connection for Maven dependencies
- Verify all files are in correct locations

## Project Structure
```
bajaj-qualifier/
├── src/
│   └── main/
│       ├── java/com/qualifier/Application.java
│       └── resources/application.properties
├── pom.xml
├── mvnw.cmd (Maven wrapper)
├── setup.bat (Windows setup)
├── setup.ps1 (PowerShell setup)
└── README.md
```

## Expected Output
```
Generating webhook...
Got webhook: [webhook-url]
SQL prepared for Question 2
Solution submitted!
Response: [server-response]
```
