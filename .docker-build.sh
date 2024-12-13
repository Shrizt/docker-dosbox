#!/bin/bash

# Display menu options to the user
echo "Please choose an option:"
echo "1. Build :latest"
echo "2. Build :pa"
echo "3. Push :latest"
echo "4. Push :pa"
echo "5. Exit"

# Read user input
read -p "Enter your choice [1-5]: " choice

# Perform action based on the user input
case $choice in
    1)
        echo "($date): Building :latest"
	docker build -f Dockerfile . -t shrizt/dosbox
        ;;
    2)
        echo "($date): Building :latest"
        docker build -f Dockerfile-pa . -t shrizt/dosbox:pa
        ;;
    3)
        echo "($date): Push :latest:"
        docker push shrizt/dosbox:latest
        ;;
    4)
        echo "($date): Push :pa"
	docker push shrizt/dosbox:pa
        ;;
    5)
        echo "Exiting... Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid option. Please choose a number between 1 and 5."
        ;;
esac





