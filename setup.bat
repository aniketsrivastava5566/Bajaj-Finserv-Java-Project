@echo off
echo Setting up Java 11 and Maven for Bajaj Finserv Health Qualifier...
echo.

REM Check if Java is already installed
java -version >nul 2>&1
if %errorlevel% == 0 (
    echo Java is already installed.
    java -version
    goto :maven_check
)

echo Java not found. Downloading OpenJDK 11...
echo.

REM Create temp directory
if not exist "temp" mkdir temp
cd temp

REM Download OpenJDK 11 for Windows
echo Downloading OpenJDK 11...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.20%2B8/OpenJDK11U-jdk_x64_windows_hotspot_11.0.20_8.zip' -OutFile 'openjdk11.zip'}"

if not exist "openjdk11.zip" (
    echo Failed to download OpenJDK 11.
    echo Please download manually from: https://adoptium.net/temurin/releases/?version=11
    pause
    exit /b 1
)

echo Extracting OpenJDK 11...
powershell -Command "Expand-Archive -Path 'openjdk11.zip' -DestinationPath '.' -Force"

REM Find the extracted directory
for /d %%i in (jdk-11*) do (
    set "JAVA_DIR=%%i"
    goto :found_java
)

:found_java
if not defined JAVA_DIR (
    echo Failed to find extracted Java directory.
    pause
    exit /b 1
)

echo Setting JAVA_HOME to %JAVA_DIR%...
setx JAVA_HOME "%CD%\%JAVA_DIR%"
setx PATH "%PATH%;%CD%\%JAVA_DIR%\bin"

echo Java 11 setup complete!
echo.

:maven_check
REM Check if Maven is already installed
mvn -version >nul 2>&1
if %errorlevel% == 0 (
    echo Maven is already installed.
    mvn -version
    goto :build_project
)

echo Maven not found. Using Maven wrapper...
echo.

:build_project
cd ..
echo Building the Spring Boot application...
echo.

REM Use Maven wrapper to build
call mvnw.cmd clean package

if %errorlevel% == 0 (
    echo.
    echo Build successful! Running the application...
    echo.
    java -jar target/bajaj-qualifier-1.0.jar
) else (
    echo.
    echo Build failed. Please check the error messages above.
)

echo.
echo Setup complete!
pause
