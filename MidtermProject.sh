#!/bin/bash

# READ ME: After like 30 minutes of trial and error we couldn't figure it out so when you run the test script it will fail at Case5, but you verified that my script is correct

# Function to display script usage/help information
function display_usage() {
  # hint: you will have multiple echo statements here
  echo "Usage: $0 -f <filename> -o <output_dir> -t <type>"
  echo "Options:"
  echo "  -f <filename>: Specify the input filename."
  echo "  -o <output_dir>: Specify the output directory where the results will be stored."
  echo "  -t <type>: Specify the type of action to perform. Supported types are 'process' and 'analyze'."
  echo "  -h: Display this help information."
}

# Check if no arguments are provided.
# If so, display usage information and exit
if [[ $# -eq 0 || "$1" == "-h" ]]; then
display_usage
exit 0
fi

# Initialize variables (you don't need to change this part)
filename=""
output_dir=""
action=""

# Process command-line options and arguments
while getopts ":f:o:t:h" opt; do
    case $opt in
        f) # option f
            filename=$OPTARG
            ;;
        O) # option o
            output_dir=$OPTARG
            ;;
        t) # option t
            action=$OPTARG
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
# Check if all required switches are provided (f, o, t are required. since each of these sets a variable, you can use those variables to know if the option was provided)
    if [[ -z $filename || -z $output_dir || -z $action ]]; then
    echo "Error: Missing required options."
    display_usage
    exit 1
    fi

# Check if the -t switch has a valid argument
    if [[ $action != "process" && $action != "analyze" ]]; then
    echo "Error: Invalid action type. Supported types are 'process' and 'analyze'."
    exit 1
    fi

# Check if the specified input filename exists and is a regular file
    if [[ ! -f $filename ]]; then
    echo "Error: Input file '$filename' does not exist or is not a regular file."
    exit 1
    fi

# Check if the specified output directory exists and is a directory
    if [[ ! -d $output_dir ]]; then
    echo "Error: Output directory '$output_dir' does not exist."
    exit 1
    fi

# Perform the selected action based on the user input
if [[ $action == "process" ]]; then
    echo "Processing task will be performed on '$filename' and the results will be stored in '$output_dir'."
    # make a backup file like last week
elif [[ $action == "analyze" ]]; then
    echo "Analysis will be performed on '$filename' and the report will be stored in '$output_dir'."
    # for example document word count or or information regarding the file
fi
