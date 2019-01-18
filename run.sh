#!/bin/bash

CFTOOLS_HOME=~/cf-tools

function cf-tools() {
  if [ ! -z "$1" ]
    then
      case "$1" in
        "help" )
          cf-tools-help ;;
        "install-tools" )
          cf-tools-install ;;
        "config" )
          config-ok && cf-tools-config ;;
        "create-service" )
          config-ok && create-service "$@" ;;
        "create-cluster" )
          config-ok && create-cluster "$2" ;;
        "load-env" )
          export $(cat $CFTOOLS_HOME/.env | xargs) ;;
        "usage" )
          cf-tools-usage ;;
        * )
          echo "Command not recognized."
          echo "Usage:"
          cf-tools-usage ;;
      esac
    else
      echo "Command not recognized."
      echo "Usage:"
      cf-tools-usage
  fi
}

function cf-tools-usage() {
  cat <<- EOM
    cf-tools help
    cf-tools config
    cf-tools load-env
    cf-tools install-tools
    cf-tools create-cluster cluster-name
    cf-tools create-service service-name
EOM
}

function cf-tools-help() {
  cat $CFTOOLS_HOME/README.md
}

function cf-tools-install() {
  ([ `which aws` ] && echo "aws already installed") || (echo "installing aws" && pip install awscli)
  ([ `which ok` ] && echo "jq already installed") || ( echo "installing jq" && ([ `which brew` ] && brew install jq || [ `which apt-get` ] && apt-get install jq || [ `which yum` ] && yum install jq || [ `which choco` ] && choco install jq))
}

function cf-tools-config() {
  echo "Current cf-tools environment:"
  echoInfo "AWS_PROFILE: ${AWS_PROFILE}"
  echoInfo "AWS_REGION: ${AWS_REGION}"
  echoInfo "GIT_USER: ${GIT_USER}"
  [[ -z "$GIT_OAUTH_TOKEN" ]] && echoInfo "GIT_OAUTH_TOKEN: " || echoInfo "GIT_OAUTH_TOKEN: xxxxxxxx"
  echoInfo "ENV_LABEL: ${ENV_LABEL}"
}

function create-service {
  SERVICE_TYPE=go
  for i in "$@"
  do
    case $i in
        --nodejs)
        SERVICE_TYPE=nodejs
        ;;
    esac
  done
  if [ ! -z "$2" ]
    then
      if [ ! -d "./$2" ]
        then
          if [ "$SERVICE_TYPE" == "nodejs" ]
            then
              echo "Creating node service ..."
              cp -R $CFTOOLS_HOME/cloudformation/nodeapp ./$2
            else
              echo "Creating go service ..."
              cp -R $CFTOOLS_HOME/cloudformation/service ./$2
          fi
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
          cd ./$1
          git init
        else
          echo "Cluster with the same name exists in current path."
      fi
    else
      echo "Cluster name not supplied."
  fi
}

function config-ok() {
  if [[ -z "$AWS_PROFILE" || -z "$AWS_REGION"] || -z "$ENV_LABEL" ]]
    then
      echo "One of the required env variables are not set."
      cf-tools-config
      return 1
    else
      return 0
  fi
}

Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

NC='\033[0m'

function echoInfo() {
  printf "${Cyan}$1${NC}\n"
}


