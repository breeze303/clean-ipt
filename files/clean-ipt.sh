#!/bin/bash

# Function to check and flush iptables rules
flush_iptables() {
    # Check for existing iptables rules
    if iptables -L | grep -q "Chain" || iptables -t nat -L | grep -q "Chain"; then
        echo "Flushing iptables rules..."
        iptables -F
        iptables -X
        iptables -t nat -F
        iptables -t nat -X
    fi

    # Check for existing ip6tables rules
    if ip6tables -L | grep -q "Chain" || ip6tables -t nat -L | grep -q "Chain"; then
        echo "Flushing ip6tables rules..."
        ip6tables -F
        ip6tables -X
        ip6tables -t nat -F
        ip6tables -t nat -X
    fi
}

# Run the function
flush_iptables

# Exit the script
exit 0
