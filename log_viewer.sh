#!/bin/bash

# Function to check if a file exists and is readable
file_exists() {
    if [ -e "$1" ] && [ -r "$1" ]; then
        return 0
    else
        return 1
    fi
}

# Function to display the menu of log files
display_menu() {
    clear
    echo "Available log files on this system:"
    local index=0
    for log_file in "${log_files[@]}"; do
        index=$((index + 1))
        echo "$index. $log_file"
    done
    echo "0. Exit"
    echo
    read -p "Enter the number of your choice: " choice
}

# Function to display log file information
display_log_info() {
    clear
    echo "Log File Information:"
    echo "File: $1"
    echo "Size: $(du -h "$1" | cut -f 1)"
    echo "Lines: $(wc -l < "$1")"
    echo "Last Modified: $(date -r "$1")"
    read -p "Press Enter to view the log file..."
}

# Function to display log entries in real-time
display_log_real_time() {
    while true; do
        clear
        echo "--------------------------------------------------"
        echo "Log Entries from: $1"
        echo "--------------------------------------------------"
        tail -f "$1" &
        tail_pid=$!
        echo "--------------------------------------------------"
        echo "Press 'q' to return to the menu or 's' to search."
        read -n 1 input
        if [ "$input" == "q" ]; then
            kill $tail_pid  # Stop tail when 'q' is pressed
            return 0
        elif [ "$input" == "s" ]; then
            read -p "Enter a search term: " search_term
            grep "$search_term" "$1"
            read -n 1 -p "Press any key to continue..."
            kill $tail_pid  # Stop tail after searching
        fi
    done
}

# List of common log file locations
log_files=(
    "/var/log/auth.log"
    "/var/log/syslog"
    "/var/log/audit/audit.log"
    "/var/log/nginx/access.log"
    "/var/log/apache2/access.log"
    "/var/log/mail.log"
    "/var/log/secure"
    "/var/log/sudo.log"
    "/var/log/dmesg"
    "/var/log/kern.log"
    "/var/log/daemon.log"
    "/var/log/cron.log"
    "/var/log/httpd/access_log" # Example: Apache HTTP Server
    "/var/log/mysqld.log"      # Example: MySQL
    "/var/log/postgresql/postgresql.log" # Example: PostgreSQL
    "/var/log/ufw.log"         # Example: UFW (Uncomplicated Firewall)
)

# If no log files were found, exit
if [ ${#log_files[@]} -eq 0 ]; then
    echo "No common log files found on this system."
    exit 1
fi

# Main loop to display the menu and allow the user to select a log file
while true; do
    display_menu

    case $choice in
        0)
            echo "Exiting."
            exit 0
            ;;
        [1-9]*)
            index=$((choice - 1))
            selected_log_file="${log_files[index]}"
            if file_exists "$selected_log_file"; then
                display_log_info "$selected_log_file"
                display_log_real_time "$selected_log_file"
            else
                echo "The selected log file does not exist: $selected_log_file"
            fi
            ;;
        *)
            echo "Invalid choice. Try again."
            ;;
    esac

    read -p "Press Enter to continue..."
done
