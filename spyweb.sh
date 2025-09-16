#!/bin/bash

# ███████╗ ██████╗ ██╗   ██╗██╗    ██╗███████╗██████╗ 
# ██╔════╝ ██╔══██╗╚██╗ ██╔╝██║    ██║██╔════╝██╔══██╗
# ██████╗  ██████╔╝ ╚████╔╝ ██║ █╗ ██║█████╗  ██████╔╝
# ╚════██╗ ██╔═══╝   ╚██╔╝  ██║███╗██║██╔══╝  ██╔══██╗
# ██████╔╝ ██║        ██║   ╚███╔███╔╝███████╗██████╔╝
# ╚═════╝  ╚═╝        ╚═╝    ╚══╝╚══╝ ╚══════╝╚═════╝ 
#
#           🕷️  SpyWeb - Web Security Analysis Tool  🕷️
#               Author: @medjahdi | Security Lab Tool
#                     Version: 2.0 | 2025-09-16
#
#    ╔══════════════════════════════════════════════════════╗
#    ║                    🕸️  SPIDER WEB  🕸️                ║
#    ║        /\   /\   /\   /\   /\   /\   /\   /\        ║
#    ║       /  \_/  \_/  \_/  \_/  \_/  \_/  \_/  \       ║
#    ║      |    🕷️     WEB CRAWLER     🕷️      |      ║
#    ║       \  /\_  /\_  /\_  /\_  /\_  /\_  /\_  /       ║
#    ║        \/   \/   \/   \/   \/   \/   \/   \/        ║
#    ╚══════════════════════════════════════════════════════╝

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Global variables
declare -a API_KEYS=()
declare -a EMAILS=()
declare -a PASSWORDS=()
declare -a DATABASES=()
declare -a JWT_TOKENS=()
declare -a URLS=()
declare -a PRIVATE_KEYS=()
declare -a CREDIT_CARDS=()
declare -a IP_ADDRESSES=()
declare -a CRYPTO_KEYS=()
declare -a CLOUD_KEYS=()
declare -a SOCIAL_KEYS=()
TEMP_FILE=""

# Display banner
show_banner() {
    clear
    echo -e "${RED}${BOLD}"
    echo "███████╗  ██████╗ ██╗   ██╗██╗    ██╗███████╗██████╗ "
    echo "██╔════╝  ██╔══██╗╚██╗ ██╔╝██║    ██║██╔════╝██╔══██╗"
    echo "██████╗   ██████╔╝ ╚████╔╝ ██║ █╗ ██║█████╗  ██████╔╝"
    echo "╚════██╗  ██╔═══╝   ╚██╔╝  ██║███╗██║██╔══╝  ██╔══██╗"
    echo "██████╔╝  ██║        ██║   ╚███╔███╔╝███████╗██████╔╝"
    echo "╚═════╝   ╚═╝        ╚═╝    ╚══╝╚══╝ ╚══════╝╚═════╝ "
    echo -e "${NC}"
    echo -e "${CYAN}${BOLD}        🕷️  SpyWeb - Web Security Analysis Tool  🕷️${NC}"
    echo -e "${WHITE}               Author: @medjahdi | Security Lab Tool${NC}"
    echo -e "${YELLOW}                     Version: 2.0 | 2025-09-16${NC}"
    echo ""
    echo -e "${RED}    ╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}    ║                    🕸️  SPIDER WEB  🕸️                ║${NC}"
    echo -e "${RED}    ║        /\\   /\\   /\\   /\\   /\\   /\\   /\\   /\\        ║${NC}"
    echo -e "${RED}    ║       /  \\_/  \\_/  \\_/  \\_/  \\_/  \\_/  \\_/  \\       ║${NC}"
    echo -e "${RED}    ║      |    🕷️     WEB CRAWLER     🕷️      |      ║${NC}"
    echo -e "${RED}    ║       \\  /\\_  /\\_  /\\_  /\\_  /\\_  /\\_  /\\_  /       ║${NC}"
    echo -e "${RED}    ║        \\/   \\/   \\/   \\/   \\/   \\/   \\/   \\/        ║${NC}"
    echo -e "${RED}    ╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Display usage
show_usage() {
    echo -e "${YELLOW}${BOLD}USAGE:${NC}"
    echo -e "${WHITE}  SpyWeb -f <URL>${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}EXAMPLES:${NC}"
    echo -e "${GREEN}  SpyWeb -f example.com/js/script.js${NC}"
    echo -e "${GREEN}  SpyWeb -f https://example.com/config.php${NC}"
    echo -e "${GREEN}  SpyWeb -f http://site.com/app.py${NC}"
    echo -e "${GREEN}  SpyWeb -f https://api.example.com/swagger.yaml${NC}"
    echo ""
    echo -e "${YELLOW}${BOLD}SUPPORTED FILE TYPES:${NC}"
    echo -e "${CYAN}  📄 Web Files: JavaScript (.js), PHP (.php), HTML (.html), CSS (.css)${NC}"
    echo -e "${CYAN}  📋 Data Files: JSON (.json), XML (.xml), YAML (.yml/.yaml), CSV (.csv)${NC}"
    echo -e "${CYAN}  ⚙️  Config Files: .env, .ini, .conf, .cfg, .properties, .toml${NC}"
    echo -e "${CYAN}  🐍 Python Files: .py, .pyw, requirements.txt, setup.py${NC}"
    echo -e "${CYAN}  ☕ Java Files: .java, .class, .jar, .war, .gradle, pom.xml${NC}"
    echo -e "${CYAN}  🟦 TypeScript: .ts, .tsx, package.json, tsconfig.json${NC}"
    echo -e "${CYAN}  🔧 Build Files: Makefile, Dockerfile, docker-compose.yml${NC}"
    echo -e "${CYAN}  📱 Mobile: .swift, .kt, .dart, AndroidManifest.xml${NC}"
    echo -e "${CYAN}  🌐 DevOps: .sh, .bat, .ps1, .tf, .yml (CI/CD)${NC}"
    echo -e "${CYAN}  💾 Database: .sql, .db, .sqlite, .mdb${NC}"
    echo -e "${CYAN}  📚 Documentation: .md, .rst, .txt, README files${NC}"
    echo -e "${CYAN}  🔐 Security: .pem, .key, .crt, .p12, .jks${NC}"
    echo ""
}

# Clean up function
cleanup() {
    if [[ -n "$TEMP_FILE" && -f "$TEMP_FILE" ]]; then
        rm -f "$TEMP_FILE"
    fi
}

# Trap to ensure cleanup on exit
trap cleanup EXIT

# Extract unique values from grep results
extract_values() {
    local pattern="$1"
    local file="$2"
    local array_name="$3"
    
    local values
    mapfile -t values < <(grep -o -i -E "$pattern" "$file" 2>/dev/null | sort -u)
    
    for value in "${values[@]}"; do
        if [[ -n "$value" ]]; then
            eval "${array_name}+=(\"$value\")"
        fi
    done
}

# Search for sensitive patterns
search_patterns() {
    local file="$1"
    
    echo -e "${BLUE}${BOLD}🔍 Scanning for sensitive information...${NC}"
    echo -e "${PURPLE}════════════════════════════════════════${NC}"
    
    # Enhanced API Keys patterns
    extract_values "(api[_-]?key|apikey|api[_-]?secret|access[_-]?token|secret[_-]?key|private[_-]?key|auth[_-]?token|bearer[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "API_KEYS"
    
    # AWS Keys (Enhanced)
    extract_values "AKIA[0-9A-Z]{16}" "$file" "CLOUD_KEYS"
    extract_values "(aws[_-]?access[_-]?key[_-]?id|aws[_-]?secret[_-]?access[_-]?key)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "CLOUD_KEYS"
    
    # Google API Keys (Enhanced)
    extract_values "AIza[0-9A-Za-z_-]{35}" "$file" "CLOUD_KEYS"
    extract_values "(google[_-]?api[_-]?key|gcp[_-]?key)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "CLOUD_KEYS"
    
    # GitHub Tokens (Enhanced)
    extract_values "gh[ps]_[a-zA-Z0-9]{36}" "$file" "CLOUD_KEYS"
    extract_values "(github[_-]?token|gh[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "CLOUD_KEYS"
    
    # Azure Keys
    extract_values "(azure[_-]?key|azure[_-]?secret)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "CLOUD_KEYS"
    
    # Digital Ocean
    extract_values "(do[_-]?api[_-]?key|digitalocean[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "CLOUD_KEYS"
    
    # Heroku
    extract_values "(heroku[_-]?api[_-]?key|heroku[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "CLOUD_KEYS"
    
    # Social Media API Keys
    extract_values "(twitter[_-]?api[_-]?key|twitter[_-]?secret|facebook[_-]?app[_-]?secret|instagram[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "SOCIAL_KEYS"
    extract_values "(slack[_-]?token|discord[_-]?token|telegram[_-]?bot[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "SOCIAL_KEYS"
    
    # Cryptocurrency Keys
    extract_values "(bitcoin[_-]?private[_-]?key|btc[_-]?key|eth[_-]?private[_-]?key|wallet[_-]?seed)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "CRYPTO_KEYS"
    
    # Email addresses (Enhanced)
    extract_values "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" "$file" "EMAILS"
    
    # Passwords and secrets (Enhanced)
    extract_values "(password|passwd|pwd|secret|token|passphrase)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "PASSWORDS"
    extract_values "(db[_-]?password|database[_-]?password|root[_-]?password|admin[_-]?password)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "PASSWORDS"
    
    # Database connections (Enhanced)
    extract_values "(mysql|postgresql|mongodb|redis|database|mariadb|oracle|mssql)[_-]?(host|url|connection|string|uri)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "DATABASES"
    extract_values "(connection[_-]?string|database[_-]?url|db[_-]?uri)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "DATABASES"
    
    # JWT Tokens (Enhanced)
    extract_values "eyJ[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*\.[a-zA-Z0-9_-]*" "$file" "JWT_TOKENS"
    
    # URLs and endpoints (Enhanced)
    extract_values "https?://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}[/a-zA-Z0-9._?&=-]*" "$file" "URLS"
    extract_values "ftp://[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}[/a-zA-Z0-9._-]*" "$file" "URLS"
    
    # Private keys (Enhanced)
    extract_values "-----BEGIN (RSA |EC |DSA |OPENSSH |PRIVATE )?PRIVATE KEY-----" "$file" "PRIVATE_KEYS"
    extract_values "-----BEGIN (CERTIFICATE|PUBLIC KEY)-----" "$file" "PRIVATE_KEYS"
    
    # Credit card patterns
    extract_values "[0-9]{4}[-\s]?[0-9]{4}[-\s]?[0-9]{4}[-\s]?[0-9]{4}" "$file" "CREDIT_CARDS"
    
    # IP Addresses (Enhanced)
    extract_values "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" "$file" "IP_ADDRESSES"
    
    # Additional sensitive patterns for different file types
    
    # Docker secrets
    extract_values "(docker[_-]?password|registry[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "API_KEYS"
    
    # CI/CD tokens
    extract_values "(ci[_-]?token|deploy[_-]?key|build[_-]?token)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "API_KEYS"
    
    # Webhook URLs
    extract_values "https?://hooks\.[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}[/a-zA-Z0-9._?&=-]*" "$file" "URLS"
    
    # SMTP credentials
    extract_values "(smtp[_-]?password|mail[_-]?password|email[_-]?password)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "PASSWORDS"
    
    # FTP credentials
    extract_values "(ftp[_-]?password|ftp[_-]?user)[\"'\s]*[:=][\"'\s]*[^\"'\s\n]+" "$file" "PASSWORDS"
    
    # S3 bucket URLs
    extract_values "https?://[a-zA-Z0-9.-]*\.s3[a-zA-Z0-9.-]*\.amazonaws\.com[/a-zA-Z0-9._?&=-]*" "$file" "URLS"
}

# Display findings
display_findings() {
    local total_findings=0
    
    # API Keys
    if [[ ${#API_KEYS[@]} -gt 0 ]]; then
        echo -e "\n${RED}${BOLD}🔑 API KEYS & TOKENS (${#API_KEYS[@]} found):${NC}"
        for key in "${API_KEYS[@]}"; do
            echo -e "${WHITE}  • ${key}${NC}"
            ((total_findings++))
        done
    fi
    
    # Cloud Provider Keys
    if [[ ${#CLOUD_KEYS[@]} -gt 0 ]]; then
        echo -e "\n${RED}${BOLD}☁️ CLOUD PROVIDER KEYS (${#CLOUD_KEYS[@]} found):${NC}"
        for key in "${CLOUD_KEYS[@]}"; do
            echo -e "${WHITE}  • ${key}${NC}"
            ((total_findings++))
        done
    fi
    
    # Social Media Keys
    if [[ ${#SOCIAL_KEYS[@]} -gt 0 ]]; then
        echo -e "\n${BLUE}${BOLD}📱 SOCIAL MEDIA KEYS (${#SOCIAL_KEYS[@]} found):${NC}"
        for key in "${SOCIAL_KEYS[@]}"; do
            echo -e "${WHITE}  • ${key}${NC}"
            ((total_findings++))
        done
    fi
    
    # Cryptocurrency Keys
    if [[ ${#CRYPTO_KEYS[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}${BOLD}₿ CRYPTOCURRENCY KEYS (${#CRYPTO_KEYS[@]} found):${NC}"
        for key in "${CRYPTO_KEYS[@]}"; do
            echo -e "${WHITE}  • ${key}${NC}"
            ((total_findings++))
        done
    fi
    
    # Emails
    if [[ ${#EMAILS[@]} -gt 0 ]]; then
        echo -e "\n${GREEN}${BOLD}📧 EMAIL ADDRESSES (${#EMAILS[@]} found):${NC}"
        for email in "${EMAILS[@]}"; do
            echo -e "${WHITE}  • ${email}${NC}"
            ((total_findings++))
        done
    fi
    
    # Passwords
    if [[ ${#PASSWORDS[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}${BOLD}🔐 PASSWORDS & SECRETS (${#PASSWORDS[@]} found):${NC}"
        for password in "${PASSWORDS[@]}"; do
            echo -e "${WHITE}  • ${password}${NC}"
            ((total_findings++))
        done
    fi
    
    # Database connections
    if [[ ${#DATABASES[@]} -gt 0 ]]; then
        echo -e "\n${PURPLE}${BOLD}🗄️ DATABASE CONNECTIONS (${#DATABASES[@]} found):${NC}"
        for db in "${DATABASES[@]}"; do
            echo -e "${WHITE}  • ${db}${NC}"
            ((total_findings++))
        done
    fi
    
    # JWT Tokens
    if [[ ${#JWT_TOKENS[@]} -gt 0 ]]; then
        echo -e "\n${RED}${BOLD}🎫 JWT TOKENS (${#JWT_TOKENS[@]} found):${NC}"
        for token in "${JWT_TOKENS[@]}"; do
            echo -e "${WHITE}  • ${token}${NC}"
            ((total_findings++))
        done
    fi
    
    # URLs
    if [[ ${#URLS[@]} -gt 0 ]]; then
        echo -e "\n${BLUE}${BOLD}🔗 URLS & ENDPOINTS (${#URLS[@]} found):${NC}"
        for url in "${URLS[@]}"; do
            echo -e "${WHITE}  • ${url}${NC}"
            ((total_findings++))
        done
    fi
    
    # Private Keys
    if [[ ${#PRIVATE_KEYS[@]} -gt 0 ]]; then
        echo -e "\n${RED}${BOLD}🔒 PRIVATE KEYS & CERTIFICATES (${#PRIVATE_KEYS[@]} found):${NC}"
        for key in "${PRIVATE_KEYS[@]}"; do
            echo -e "${WHITE}  • ${key}${NC}"
            ((total_findings++))
        done
    fi
    
    # Credit Cards
    if [[ ${#CREDIT_CARDS[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}${BOLD}💳 CREDIT CARD PATTERNS (${#CREDIT_CARDS[@]} found):${NC}"
        for card in "${CREDIT_CARDS[@]}"; do
            echo -e "${WHITE}  • ${card}${NC}"
            ((total_findings++))
        done
    fi
    
    # IP Addresses
    if [[ ${#IP_ADDRESSES[@]} -gt 0 ]]; then
        echo -e "\n${CYAN}${BOLD}🌐 IP ADDRESSES (${#IP_ADDRESSES[@]} found):${NC}"
        for ip in "${IP_ADDRESSES[@]}"; do
            echo -e "${WHITE}  • ${ip}${NC}"
            ((total_findings++))
        done
    fi
    
    return $total_findings
}

# Download and analyze file
analyze_file() {
    local url="$1"
    
    # Add protocol if missing
    if [[ ! "$url" =~ ^https?:// ]]; then
        url="http://$url"
    fi
    
    echo -e "${YELLOW}${BOLD}🕸️ SpyWeb is crawling: ${WHITE}$url${NC}"
    echo -e "${BLUE}Downloading file...${NC}"
    
    # Create temporary file
    TEMP_FILE=$(mktemp)
    
    # Download file with curl
    if command -v curl >/dev/null 2>&1; then
        if curl -s -L --max-redirs 5 --connect-timeout 10 "$url" -o "$TEMP_FILE"; then
            if [[ -s "$TEMP_FILE" ]]; then
                echo -e "${GREEN}✅ File downloaded successfully${NC}"
                file_size=$(wc -c < "$TEMP_FILE")
                echo -e "${CYAN}📊 File size: ${file_size} bytes${NC}"
                
                # Detect file type
                file_type=$(file -b --mime-type "$TEMP_FILE" 2>/dev/null || echo "unknown")
                echo -e "${CYAN}📄 File type: ${file_type}${NC}"
                echo ""
                
                search_patterns "$TEMP_FILE"
                display_findings
                return $?
            else
                echo -e "${RED}❌ Error: Downloaded file is empty${NC}"
                return 1
            fi
        else
            echo -e "${RED}❌ Error: Failed to download file${NC}"
            return 1
        fi
    elif command -v wget >/dev/null 2>&1; then
        if wget -q --timeout=10 --tries=3 "$url" -O "$TEMP_FILE"; then
            if [[ -s "$TEMP_FILE" ]]; then
                echo -e "${GREEN}✅ File downloaded successfully${NC}"
                file_size=$(wc -c < "$TEMP_FILE")
                echo -e "${CYAN}📊 File size: ${file_size} bytes${NC}"
                
                # Detect file type
                file_type=$(file -b --mime-type "$TEMP_FILE" 2>/dev/null || echo "unknown")
                echo -e "${CYAN}📄 File type: ${file_type}${NC}"
                echo ""
                
                search_patterns "$TEMP_FILE"
                display_findings
                return $?
            else
                echo -e "${RED}❌ Error: Downloaded file is empty${NC}"
                return 1
            fi
        else
            echo -e "${RED}❌ Error: Failed to download file${NC}"
            return 1
        fi
    else
        echo -e "${RED}❌ Error: Neither curl nor wget is available${NC}"
        return 1
    fi
}

# Display summary
show_summary() {
    local total_findings=$1
    
    echo ""
    echo -e "${PURPLE}════════════════════════════════════════${NC}"
    echo -e "${BOLD}${WHITE}📊 SCAN SUMMARY:${NC}"
    echo -e "${YELLOW}Total findings: ${BOLD}${total_findings}${NC}"
    
    if [[ $total_findings -gt 0 ]]; then
        echo -e "${RED}${BOLD}⚠️  SECURITY ALERT: Sensitive information detected!${NC}"
        echo -e "${YELLOW}Please review and secure the identified data.${NC}"
    else
        echo -e "${GREEN}${BOLD}✅ No obvious sensitive patterns detected.${NC}"
        echo -e "${CYAN}Note: This doesn't guarantee the file is completely safe.${NC}"
    fi
    
    echo -e "${PURPLE}════════════════════════════════════════${NC}"
    echo -e "${WHITE}Scan completed by SpyWeb 🕷️ - @medjahdi${NC}"
}

# Main function
main() {
    show_banner
    
    # Check if URL parameter is provided
    if [[ $# -eq 0 ]] || [[ "$1" != "-f" ]] || [[ -z "$2" ]]; then
        show_usage
        echo -e "${RED}❌ Error: Please provide a URL with -f flag${NC}"
        exit 1
    fi
    
    local url="$2"
    
    # Validate URL format
    if [[ ! "$url" =~ ^(https?://)?[a-zA-Z0-9.-]+\.[a-zA-Z]{2,} ]]; then
        echo -e "${RED}❌ Error: Invalid URL format${NC}"
        echo -e "${YELLOW}Example: SpyWeb -f example.com/file.js${NC}"
        exit 1
    fi
    
    # Start analysis
    analyze_file "$url"
    local total_findings=$?
    
    # Show summary
    show_summary $total_findings
}

# Check if script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
