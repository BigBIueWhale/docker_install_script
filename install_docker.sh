#!/bin/bash

# Function to print a message
print_message() {
    echo "------------------------------------------------"
    echo "$1"
    echo "------------------------------------------------"
}

# Function to handle errors
error_exit() {
    echo "Error: $1"
    exit 1
}

# Check for --username argument
if [ "$1" != "--username" ] || [ -z "$2" ]; then
    error_exit "Usage: $0 --username <username>"
fi
username="$2"

# Exit script if any command fails
set -e

# Update the system's package index
print_message "Updating package index..."
sudo apt update || error_exit "Failed to update package index"

# Upgrade packages
print_message "Upgrading packages..."
sudo apt upgrade -y || error_exit "Failed to upgrade packages"

# Install required packages
print_message "Installing required packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common || error_exit "Failed to install required packages"

# Add Docker's official GPG key
print_message "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || error_exit "Failed to add Docker's GPG key"

# Add Docker repository
print_message "Adding Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || error_exit "Failed to add Docker repository"

# Update package index again
print_message "Updating package index..."
sudo apt update || error_exit "Failed to update package index after adding Docker repository"

# Install Docker Engine
print_message "Installing Docker Engine..."
sudo apt install -y docker-ce docker-ce-cli containerd.io || error_exit "Failed to install Docker Engine"

# Verify Docker installation
print_message "Verifying Docker installation..."
sudo docker run hello-world || error_exit "Failed to run Docker hello-world container"

# Add specified user to the docker group
print_message "Adding user '$username' to the Docker group..."
sudo usermod -aG docker $username || error_exit "Failed to add user '$username' to the Docker group"
print_message "User '$username' added to the Docker group. You need to log out and log back in for this to take effect."

print_message "Docker installation completed successfully!"
print_message "Script execution completed!"

