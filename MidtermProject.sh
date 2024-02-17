#!/bin/bash

function display_usage() {
  echo "File Usage: $0 -f <filename> -p <permission>"
  echo "Options:"
  echo "  -f <filename>: Specify the file you want to change Permissions for."
  echo "  -p <permission>: Specify new permissions for the file."
  echo "Need Help?"
  echo "  -i Linux: Explain Linux File Permissions."
  echo "  -h: Display this help information."
}

function linux_help_info() {
  echo "Permissons work as follows: "
  echo "The first number represents the file owner"
  echo "The second number represents the user group the owner is in"
  echo "The third numebr represents any other users that are on the system"
  echo "1 = Execute, 2 = Write, and 4 = Read."
  echo "For example, if you wanted the file owner to have all perms, owner's group "
  echo "to have both read & write, but only read for everyone else would be: 764"
}

if [[ $# -eq 0 || "$1" == "-h" ]]; then
display_usage
exit 0
fi

filename=""
permissions=""

while getopts ":f:p:i:h" opt; do
    case $opt in
        f) # option f
            filename=$OPTARG
            ;;
        p) # option p
            permissions=$OPTARG
            ;;
        i) # option i
            linux_help_info
            exit 0
            ;;
        h) # option h
            display_usage
            exit 0
            ;;
        \?) # any other option
            echo "Invalid option: -$OPTARG"
            display_usage
            exit 0
            ;;
        :) # no argument
            echo "Option -$OPTARG requires an argument."
            display_usage
            exit 1
            ;;
        esac
    done

    if [[ -z $filename || -z $permissions ]]; then
    echo "Error: Missing required options."
    display_usage
    exit 1
    fi

    if [[ ! -f $filename ]]; then
    echo "Error: Input file '$filename' does not exist or is not a regular file."
    exit 1
    fi 
    
    if [[ "$permissions" = '[0-9]{3,}' ]]; then
    echo "Error: Invalid Permission. Use -i to see more information on Linux File Permissions."
    fi

    chmod $permissions $filename
    echo "Permissions Successfully Changed to: $permissions"