#!/bin/bash
usage() {
    echo "usage: quick start [[[-d function | api] | [-h]]"
}

if [ $# -gt 0 ]; then
    # check for the first command like
    while [ "$1" != "" ]; do
        case $1 in
        -d | --debug)
            shift
            shopt -s nocasematch
            if [ $1 == 'api' ]; then
                echo "Starting API Debug on port 5858"
                sam build --use-container && sam local start-api -d 5858
            elif [ $1 == 'function' ]; then
                echo "Starting Function Debug on port 5858 using event file"
                sam build --use-container && sam local invoke -d 5858 -e event.json
            else
                echo "Invalid Debug Option"
                usage
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
    sam build --use-container && sam local start-api
fi

# to debug using event.json
# sam local invoke -d 5858 -e event.json

# if you want to debug without the event json and use the API
# sam local start-api -d 5858
# it will wait, prior to calling the lambda, for you to attach the debugger

# to set the vscode debug
# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-using-debugging.html
# https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-using-debugging-nodejs.html
