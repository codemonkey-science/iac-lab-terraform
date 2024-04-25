#!/bin/bash

# This script is used to run terraform locally. It checks if terraform is installed and if the necessary environment variables are set. It then initializes terraform, checks the format, plans and applies the terraform.
#
# The following environment variables are required, set in your ~/.bashrc file:
#
# export SSH_PRIVATE_KEY=`cat ~/.ssh/id_deployer`
# export API_TOKEN_ID="automation@pam!automation"
# export API_TOKEN_SECRET="<your-api-token-secret>"

# Define colors
INFO='\033[0;36m' # Cyan
SUCCESS='\033[0;32m' # Green
ERROR='\033[0;31m' # Red
WARNING='\033[0;33m' # Amber
NC='\033[0m' # No Color

# Check if terraform is installed
if ! command -v terraform &> /dev/null
then
    echo -e "${ERROR}[-] Terraform could not be found${NC}"
    echo -e "${INFO}[*] Please install Terraform. You can download it from https://www.terraform.io/downloads.html${NC}"
    exit 1
fi

# Check if the necessary environment variables are set
if [[ -z "${SSH_PRIVATE_KEY}" ]]; then
    echo -e "${ERROR}[-] SSH_PRIVATE_KEY is not set${NC}"
    echo -e "${INFO}[*] Please set it in your ~/.bashrc file${NC}"
    exit 1
fi

if [[ (-z "${API_USER}" || -z "${API_PASSWORD}") && (-z "${API_TOKEN_ID}" || -z "${API_TOKEN_SECRET}") ]]; then
    echo -e "${ERROR}[-] Either API_USER and API_PASSWORD or API_TOKEN_ID and API_TOKEN_SECRET must be set${NC}"
    echo -e "${INFO}[*] Please set them in your ~/.bashrc file${NC}"
    exit 1
fi

# Function to check command status
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${SUCCESS}[+] Command successful${NC}"
    else
        echo -e "${ERROR}[-] Command failed${NC}"
        exit 1
    fi
}

echo -e "${INFO}[*] Initializing terraform${NC}"
terraform init
check_status

echo -e "${INFO}[*] Checking terraform format${NC}"
terraform fmt -check
check_status

echo -e "${INFO}[*] Planning terraform${NC}"
terraform plan -input=false -var="ssh_private_key=${SSH_PRIVATE_KEY}" \
        -var="api_user=${API_USER}" \
        -var="api_password=${API_PASSWORD}" \
        -var="api_token_id=${API_TOKEN_ID}" \
        -var="api_token_secret=${API_TOKEN_SECRET}"
check_status

echo -e "${INFO}[*] Applying terraform${NC}"
terraform destroy -auto-approve -input=false -var="ssh_private_key=${SSH_PRIVATE_KEY}" \
        -var="api_user=${API_USER}" \
        -var="api_password=${API_PASSWORD}" \
        -var="api_token_id=${API_TOKEN_ID}" \
        -var="api_token_secret=${API_TOKEN_SECRET}"
check_status
