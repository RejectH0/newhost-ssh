#!/bin/bash

# Define the path to the known_hosts file
KNOWN_HOSTS_FILE="${HOME}/.ssh/known_hosts"

# Define the keys of the remote host to retrieve
# no spaces between comma delimited, e.g., "rsa,dsa,ed25519"
# default is just ed25519 because it's way more efficient.
ALGO="ed25519"

# Function to get the IP address from the user
get_ip_address() {
    if [[ -n "$1" ]]; then
        ip_address=$1
        echo "Using IP address from command line: $ip_address"
    else
        read -p "Enter the IP address of the server: " ip_address
    fi 
    if ! validate_ip_format "$ip_address"; then
        echo "Invalid IP address format."
        exit 1
    fi
    if check_existing_entry "$ip_address"; then
        # Since check_existing_entry already displays the entry, no need to repeat it here
        exit 0
    fi
    if ! check_ip_reachability "$ip_address"; then
        echo "IP address is not reachable."
        exit 1
    fi
}

# Function to validate the IP address format
validate_ip_format() {
    local ip=$1
    local stat=1

    if [[ $ip =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
           && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

# Function to check if the IP address is already in known_hosts
check_existing_entry() {
    local ip=$1
    # Hash the IP and store the output in a variable
    local hashed_ip_output
    hashed_ip_output=$(ssh-keygen -H -F "$ip" 2>/dev/null)

    if [[ -n "$hashed_ip_output" ]]; then
        echo "Entry for IP $ip exists in known_hosts:"
        echo "$hashed_ip_output"
        return 0
    else
        return 1
    fi
}

# Function to check if the IP address is reachable
check_ip_reachability() {
    local ip=$1
    ping -c 3 "$ip" > /dev/null 2>&1
    return $?
}

# Function to add the SSH key
add_ssh_key() {
    local ip=$1
    local ssh_key_output
    ssh_key_output=$(ssh-keyscan -H -t "$ALGO" "$ip" 2>&1 | grep -v '^#')

    if [[ -z "$ssh_key_output" ]]; then
        echo "Failed to get SSH key from $ip."
        exit 1
    fi

    # Append the output to known_hosts
    echo "$ssh_key_output" >> $KNOWN_HOSTS_FILE
}

# Main script execution
get_ip_address "$1"
add_ssh_key "$ip_address"
echo "SSH key added successfully for $ip_address."

