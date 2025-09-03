# Setup script for Bajaj Finserv Health Qualifier
# This script downloads Java 11 and builds the Spring Boot application

Write-Host "Setting up Java 11 and Maven for Bajaj Finserv Health Qualifier..." -ForegroundColor Green
Write-Host ""

# Check if Java is already installed
try {
    $javaVersion = java -version 2>&1
    Write-Host "Java is already installed:" -ForegroundColor Yellow
    Write-Host $javaVersion -ForegroundColor Cyan
    $javaInstalled = $true
} catch {
    $javaInstalled = $false
}

if (-not $javaInstalled) {
    Write-Host "Java not found. Downloading OpenJDK 11..." -ForegroundColor Yellow
    
    # Create temp directory
    if (-not (Test-Path "temp")) {
        New-Item -ItemType Directory -Name "temp" | Out-Null
    }
    
    Set-Location "temp"
    
    # Download OpenJDK 11 for Windows
    Write-Host "Downloading OpenJDK 11..." -ForegroundColor Yellow
    $javaUrl = "https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.20%2B8/OpenJDK11U-jdk_x64_windows_hotspot_11.0.20_8.zip"
    $javaZip = "openjdk11.zip"
    
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $javaUrl -OutFile $javaZip
    } catch {
        Write-Host "Failed to download OpenJDK 11." -ForegroundColor Red
        Write-Host "Please download manually from: https://adoptium.net/temurin/releases/?version=11" -ForegroundColor Yellow
        Read-Host "Press Enter to continue"
        exit 1
    }
    
    if (-not (Test-Path $javaZip)) {
        Write-Host "Failed to download OpenJDK 11." -ForegroundColor Red
        Read-Host "Press Enter to continue"
        exit 1
    }
    
    Write-Host "Extracting OpenJDK 11..." -ForegroundColor Yellow
    Expand-Archive -Path $javaZip -DestinationPath "." -Force
    
    # Find the extracted directory
    $javaDir = Get-ChildItem -Directory -Name "jdk-11*" | Select-Object -First 1
    
    if (-not $javaDir) {
        Write-Host "Failed to find extracted Java directory." -ForegroundColor Red
        Read-Host "Press Enter to continue"
        exit 1
    }
    
    Write-Host "Setting JAVA_HOME to $javaDir..." -ForegroundColor Yellow
    
    # Set environment variables
    [Environment]::SetEnvironmentVariable("JAVA_HOME", "$PWD\$javaDir", "User")
    $currentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    [Environment]::SetEnvironmentVariable("PATH", "$currentPath;$PWD\$javaDir\bin", "User")
    
    # Set for current session
    $env:JAVA_HOME = "$PWD\$javaDir"
    $env:PATH = "$env:PATH;$PWD\$javaDir\bin"
    
    Write-Host "Java 11 setup complete!" -ForegroundColor Green
    Write-Host ""
}

# Check if Maven is already installed
try {
    $mvnVersion = mvn -version 2>&1
    Write-Host "Maven is already installed:" -ForegroundColor Yellow
    Write-Host $mvnVersion -ForegroundColor Cyan
    $mvnInstalled = $true
} catch {
    $mvnInstalled = $false
}

if (-not $mvnInstalled) {
    Write-Host "Maven not found. Using Maven wrapper..." -ForegroundColor Yellow
    Write-Host ""
}

# Build the project
Set-Location ".."
Write-Host "Building the Spring Boot application..." -ForegroundColor Yellow
Write-Host ""

try {
    # Use Maven wrapper to build
    if (Test-Path "mvnw.cmd") {
        & .\mvnw.cmd clean package
    } else {
        Write-Host "Maven wrapper not found. Please run 'setup.bat' instead." -ForegroundColor Red
        Read-Host "Press Enter to continue"
        exit 1
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "Build successful! Running the application..." -ForegroundColor Green
        Write-Host ""
        
        # Run the application
        java -jar target/bajaj-qualifier-1.0.jar
    } else {
        Write-Host ""
        Write-Host "Build failed. Please check the error messages above." -ForegroundColor Red
    }
} catch {
    Write-Host "Error during build: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "Setup complete!" -ForegroundColor Green
Read-Host "Press Enter to continue"
