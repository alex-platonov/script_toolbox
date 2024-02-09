#!/bin/bash
#The script helps to switch on and off the crontabs on the linux machine. It is  a bulk operation, not a selective one. 


# Prompt the user for action
read -p "Do you want to switch crontabs ON or OFF? (ON/OFF): " action

# Temporary file for crontab manipulation
tmp_crontab="/tmp/crontab.$$"

# Get current crontab
crontab -l > "$tmp_crontab"

if [[ "$action" == "ON" ]]; then
    # Iterate over each line to uncomment the appropriate ones
    awk '/^#[0-9*]/ {sub(/^#/, ""); print; next} {print}' "$tmp_crontab" > "${tmp_crontab}.new"
    if crontab "${tmp_crontab}.new"; then
        echo "Crontab switched ON successfully."
    else
        echo "Failed to update crontab."
    fi
elif [[ "$action" == "OFF" ]]; then
    # Iterate over each line to comment the appropriate ones
    awk '/^[0-9*]/ {print "#" $0; next} {print}' "$tmp_crontab" > "${tmp_crontab}.new"
    if crontab "${tmp_crontab}.new"; then
        echo "Crontab switched OFF successfully."
    else
        echo "Failed to update crontab."
    fi
else
    echo "Invalid action. Please enter ON or OFF."
fi

# Cleanup
rm -f "$tmp_crontab" "${tmp_crontab}.new"

