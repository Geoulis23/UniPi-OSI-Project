#!/bin/bash

FILENAME=".clients.txt"

# Menu
# show_menu() {
#     echo "1. Αναζήτηση στις εγγραφές"
#     echo "2. Νέος πελάτης"
#     echo "3. Διαγραφή πελάτη"
#     echo "4. Εμφάνιση όλων των πελατών"
#     echo "5. Έξοδος"
#     echo -n "Επιλέξτε μια επιλογή: "
# }

# Αναζήτηση στις εγγραφές
search_clients() {
    echo -n "Εισάγετε κείμενο για αναζήτηση: "
    read search_term
    grep -i "$search_term" $FILENAME || echo "Δεν βρέθηκαν εγγραφές."
}

# Νέος πελάτης
add_client() {
    echo -n "Εισάγετε Όνομα: "
    read name
    echo -n "Εισάγετε Επώνυμο: "
    read surname
    echo -n "Εισάγετε Διεύθυνση: "
    read address
    echo -n "Εισάγετε Τηλ.: "
    read phone
    echo -n "Εισάγετε Φαξ: "
    read fax
    echo -n "Εισάγετε email: "
    read email

    new_entry="$name;$surname;$address;$phone;$fax;$email"
    
    if grep -q "$new_entry" $FILENAME; then
        echo "Η εγγραφή υπάρχει ήδη."
    else
        echo $new_entry >> $FILENAME
        echo "Η εγγραφή προστέθηκε επιτυχώς."
    fi
}

# Διαγραφή πελάτη
delete_client() {
    echo -n "Εισάγετε κριτήρια για διαγραφή: "
    read criteria
    grep -i "$criteria" $FILENAME
    echo -n "Επιβεβαίωση διαγραφής (y/n): "
    read confirm
    if [ "$confirm" = "y" ]; then
        grep -vi "$criteria" $FILENAME > temp && mv temp $FILENAME
        echo "Η εγγραφή διαγράφηκε επιτυχώς."
    else
        echo "Η διαγραφή ακυρώθηκε."
    fi
}

# Εμφάνιση όλων των πελατών
display_clients() {
    if [ -f $FILENAME ]; then
        cat $FILENAME
    else
        echo "Δεν υπάρχουν εγγραφές."
    fi
}

# Main script
while true; do
    echo "1. Αναζήτηση στις εγγραφές"
    echo "2. Νέος πελάτης"
    echo "3. Διαγραφή πελάτη"
    echo "4. Εμφάνιση όλων των πελατών"
    echo "5. Έξοδος"
    echo -n "Επιλέξτε μια επιλογή: "
    read choice
    case $choice in
        1) search_clients ;;
        2) add_client ;;
        3) delete_client ;;
        4) display_clients ;;
        5) exit 0 ;;
        *) echo "Λάθος επιλογή. Προσπαθήστε ξανά." ;;
    esac
done
