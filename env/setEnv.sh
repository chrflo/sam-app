#!/bin/bash
usage() {
    echo "usage: set_aws_env [[[-f environment file ] | [-h]]"
}

#get the current working directory
PWD=$(pwd)

if [ $# -gt 0 ]; then
    # check for the first command like
    while [ "$1" != "" ]; do
        case $1 in
        -f | --file)
            shift
            filename=$1
            # make sure that the file path is present
            if ["$filename" == ""]; then
                usage
                exit 1
            fi
            ;;
        -h | --help)
            usage
            exit
            ;;
        *)
            usage
            exit 1
            ;;
        esac
        shift
    done
else
    # check for the local .env
    if [ -f ".env" ]; then
        filename="$PWD/.env"
    else
        echo "The .env cannot be found in the current folder. An environment file is needed to proceed."
        exit
    fi
fi

echo "Using environment file: $filename"
while IFS= read -r line; do
    # display $line or do somthing with $line (
    # TODO: maybe there is a better way to do this check)
    [[ $line =~ ^#.* ]] && continue
    [[ $line =~ ^$ ]] && continue
    echo "export $line"
    export $line # TODO: fix this to allow for work
done <"$filename"
