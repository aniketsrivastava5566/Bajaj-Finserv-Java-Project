# Bajaj Finserv Health Qualifier - Project Summary

## 🎯 Project Overview
A complete Spring Boot application for the Bajaj Finserv Health Qualifier coding challenge. This is designed to be a quick 1-hour implementation that demonstrates basic Spring Boot skills.

## 📁 Complete Project Structure
```
bajaj-qualifier/
├── 📄 pom.xml                           # Maven configuration
├── 📄 README.md                         # Main documentation
├── 📄 PROJECT_SUMMARY.md               # This file
├── 📄 SETUP_INSTRUCTIONS.md            # Detailed setup guide
├── 📄 simple-setup.bat                 # Recommended setup script
├── 📄 setup.bat                        # Full Windows setup
├── 📄 setup.ps1                        # PowerShell setup
├── 📄 mvnw.cmd                         # Maven wrapper (Windows)
├── 📁 .mvn/wrapper/
│   └── 📄 maven-wrapper.properties     # Maven wrapper config
├── 📁 src/
│   └── 📁 main/
│       ├── 📁 java/com/qualifier/
│       │   └── 📄 Application.java     # Main application
│       └── 📁 resources/
│           └── 📄 application.properties # App configuration
└── 📁 temp/                            # Temporary files (created during setup)
```

## 🚀 Quick Start Guide

### 1. Install Java 11
- Go to: https://adoptium.net/temurin/releases/?version=11
- Download "Windows x64 JDK" for Java 11
- Run the installer
- Restart command prompt

### 2. Build and Run
```bash
# Option A: Use Maven wrapper (recommended)
mvnw.cmd clean package
java -jar target/bajaj-qualifier-1.0.jar

# Option B: Use simple setup script
.\simple-setup.bat

# Option C: Manual Maven (if installed)
mvn clean package
java -jar target/bajaj-qualifier-1.0.jar
```

## 🔧 What the Application Does

### Step 1: Generate Webhook
- Calls API: `https://bfhldevapigw.healthrx.co.in/hiring/generateWebhook/JAVA`
- Sends your details: name, regNo, email
- Receives webhook URL and access token

### Step 2: SQL Solution
- Your regNo ends with "64" (even number)
- Therefore, solves **Question 2**
- SQL query finds employees with count of younger colleagues in same department

### Step 3: Submit Solution
- Posts SQL solution to the webhook URL
- Uses JWT token for authentication
- Prints server response and exits

## 📋 Expected Output
```
Generating webhook...
Got webhook: [webhook-url]
SQL prepared for Question 2
Solution submitted!
Response: [server-response]
```

## 🎨 Technical Features
- **Spring Boot 2.7.14** with Java 11
- **CommandLineRunner** - executes once on startup
- **RestTemplate** for HTTP calls (no WebClient complexity)
- **Jackson** for JSON processing
- **Single main class** - everything in Application.java
- **Maven wrapper** - no need to install Maven globally
- **Minimal dependencies** - only spring-boot-starter-web

## 🛠️ Setup Options

### Automated Setup
- `simple-setup.bat` - **Recommended for beginners**
- `setup.bat` - Full Windows automation
- `setup.ps1` - PowerShell automation

### Manual Setup
- Install Java 11 manually
- Use Maven wrapper or install Maven
- Follow SETUP_INSTRUCTIONS.md

## 🔍 Troubleshooting

### Common Issues
1. **Java not found** → Install Java 11 from Adoptium
2. **Maven not found** → Use `mvnw.cmd` (Maven wrapper)
3. **Build errors** → Check Java version and internet connection

### Verification Commands
```bash
java -version    # Should show Java 11.x.x
mvnw.cmd -version # Should show Maven version
```

## 📦 Final Deliverable
- **Source code** - Complete Spring Boot application
- **Executable JAR** - `target/bajaj-qualifier-1.0.jar`
- **Setup scripts** - Multiple automation options
- **Documentation** - Comprehensive guides and troubleshooting

## 🎯 Perfect For
- **1-hour coding challenge** submission
- **Spring Boot demonstration** project
- **REST API integration** example
- **Maven project structure** reference

## 🚀 Ready to Run!
The application is complete and ready for:
1. **Immediate testing** (after Java 11 installation)
2. **Submission** to Bajaj Finserv Health
3. **Further development** and enhancement
4. **Learning** Spring Boot fundamentals

**Run `.\simple-setup.bat` to get started!** 🎉
