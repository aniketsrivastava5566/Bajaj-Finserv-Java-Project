@echo off
echo ========================================
echo Bajaj Finserv Health Qualifier Setup
echo ========================================
echo.

echo This script will help you set up the environment and build the project.
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %errorlevel% == 0 (
    echo ✓ Java is already installed
    java -version
    goto :build_project
) else (
    echo ✗ Java is NOT installed
    echo.
    echo Please install Java 11 manually:
    echo 1. Go to: https://adoptium.net/temurin/releases/?version=11
    echo 2. Download "Windows x64 JDK" for Java 11
    echo 3. Run the installer
    echo 4. Restart this script
    echo.
    pause
    exit /b 1
)

:build_project
echo.
echo Building the Spring Boot application...
echo.

REM Use Maven wrapper to build
if exist "mvnw.cmd" (
    echo Using Maven wrapper...
    call mvnw.cmd clean package
) else (
    echo Maven wrapper not found. Checking for Maven...
    mvn -version >nul 2>&1
    if %errorlevel% == 0 (
        echo Using system Maven...
        mvn clean package
    ) else (
        echo Maven not found. Please install Maven or use the Maven wrapper.
        echo.
        echo To install Maven:
        echo 1. Go to: https://maven.apache.org/download.cgi
        echo 2. Download the binary zip
        echo 3. Extract to C:\Maven
        echo 4. Add C:\Maven\bin to your PATH
        echo.
        pause
        exit /b 1
    )
)

if %errorlevel% == 0 (
    echo.
    echo ✓ Build successful!
    echo.
    echo Running the application...
    echo.
    java -jar target/bajaj-qualifier-1.0.jar
) else (
    echo.
    echo ✗ Build failed!
    echo Please check the error messages above.
    echo.
    pause
    exit /b 1
)

echo.
echo Setup complete!
pause
