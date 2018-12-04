#!/bin/bash

CFTOOLS_HOME=~/cf-tools

function cf-tools() {
  if [ ! -z "$1" ]
    then
      case "$1" in
        "help" )
          help ;;
        "create-service" )
          create-service "$2" ;;
        "create-cluster" )
          create-cluster "$2" ;;
      esac
    else
      echo "Command not recognized."
      echo "Usage:"
      usage
  fi
}

function usage() {
  cat <<- EOM
    cf-tools help
    cf-tools create-service service-name
    cf-tools create-cluster cluster-name
EOM
}

function help() {
  cat $CFTOOLS_HOME/README.md
}

function create-service {
  if [ ! -z "$1" ]
    then
      if [ ! -d "./$1" ]
        then
          cp -R $CFTOOLS_HOME/cloudformation/service ./$1
        else
          echo "Service with the same name exists in current path."
      fi
    else
      echo "Service name not supplied."
  fi
}

function create-cluster() {
  if [ ! -z "$1" ]
    then
      if [ ! -d "./$1" ]
        then
          cp -R $CFTOOLS_HOME/cloudformation/cluster ./$1
        else
          echo "Cluster with the same name exists in current path."
      fi
    else
      echo "Cluster name not supplied."
  fi
}
