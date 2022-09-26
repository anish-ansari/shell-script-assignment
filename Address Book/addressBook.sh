#! /bin/bash

function menu() {
  while IFS= read -r menu; do
    echo "$menu"
  done <menu.txt
  read operation
}

function search() {
  clear
  echo "What do you want to search?"

  select item in "First name" "Last name" "Email" "Phone" "Back to main menu"; do

    case $item in
    "First name")
      read -p "Enter data: " data
      if grep -q -wi "$data" records.txt; then
        echo "Data found"
        details=($(grep $data records.txt))
        echo "${details[@]}"
        break
      else
        echo "No such entry found"
      fi
      ;;

    "Last name")
      read -p "Enter data: " data
      if grep -q -wi "$data" records.txt; then
        echo "Data found"
        details=($(grep $data records.txt))
        echo "${details[@]}"
        break
      else
        echo "No such entry found"
      fi
      ;;

    "Email")
      read -p "Enter data: " data
      if grep -q -wi "$data" records.txt; then
        echo "Data found"
        details=($(grep $data records.txt))
        echo "${details[@]}"
        break
      else
        echo "No such entry found"
      fi
      ;;

    "Phone")
      read -p "Enter data: " data
      if grep -q -wi "$data" records.txt; then
        echo "Data found"
        details=($(grep $data records.txt))
        echo "${details[@]}"
        break
      else
        echo "No such entry found"
      fi
      ;;

    "Back to main menu")
      echo "Returning to main menu..."
      sleep 1
      clear
      main
      ;;

    *)
      echo "Wrong input. Try again"
      sleep 2
      clear
      search
      ;;
    esac
  done
}

function add() {
  read -p "First name: " fname
  read -p "Last name: " lname
  read -p "Email: " email
  read -p "Phone: " phone

  local flag="N"
  local details=($fname $lname $email $phone)
  echo
  echo ${details[@]}
  echo
  read -p "Confirm save? [Y/N]: " flag

  if [ $flag == "Y" ]; then
    echo "Saving..."
    sleep 1
    echo ${details[@]} >>records.txt
    echo "Returning to main menu..."
    sleep 1
    clear
    main
  else
    echo "Returning to main menu..."
    sleep 1
    clear
    main

  fi
}

function remove() {
  clear
  search
  local flag="N"
  read -p "Do you want to delete? [Y/N] " flag

  if [ $flag == "Y" ]; then
    sed -i -e "/$data/d" records.txt
    echo "Deleting..."
    sleep 1
    echo "Record deleted successfully"
    echo
    echo "Returning to main menu..."
    sleep 1
    menu
  else
    echo "Rolling back..."
    sleep 1
    clear
    remove
  fi
}

function edit() {
  clear
  search
  local flag="N"
  read -p "Do you want to edit? [Y/N] " flag

  if [ $flag == "Y" ]; then
    sub_edit
    echo "Record edited successfully"
    echo "Returning to main menu..."
    sleep 1
    clear
    main
  else
    echo "Rolling back..."
    sleep 1
    remove
  fi
}

function sub_edit() {
  echo "What do you want to edit?"
  local newdata=""

  select item in "First name" "Last name" "Email" "Phone" "Back to main menu"; do

    case $item in
    "First name")
      read -p "Previous first name: " olddata
      read -p "New first name: " newdata
      sed -i "s/${olddata}/${newdata}/g" records.txt
      break
      ;;

    "Last name")
      read -p "Previous last name: " olddata
      read -p "New last name: " newdata
      sed -i "s/${olddata}/${newdata}/g" records.txt
      break
      ;;

    "Email")
      read -p "Previous email: " olddata
      read -p "New email: " newdata
      sed -i "s/${olddata}/${newdata}/g" records.txt
      break
      ;;

    "Phone")
      read -p "Previous phone: " olddata
      read -p "New phone: " newdata
      sed -i "s/${olddata}/${newdata}/g" records.txt
      break
      ;;

    "Back to main menu")
      echo "Returning to main menu..."
      sleep 1
      clear
      menu
      ;;

    *)
      echo "Wrong input. Try again"
      sleep 1
      clear
      sub_edit
      ;;

    esac
  done
}

function main() {
  menu

  echo "you entered $operation"

  if (($operation == 1)); then
    search
  elif (($operation == 2)); then
    add
  elif (($operation == 3)); then
    remove
  elif (($operation == 4)); then
    edit
  elif (($operation == 5)); then
    echo "Exiting..."
    sleep 1
    exit
  else
    echo "Wrong input. Try again"
    sleep 2
    clear
    main
  fi
}

main
