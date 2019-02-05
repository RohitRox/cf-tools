#!/bin/bash

CFTOOLS_HOME=~/.cf-tools

function cf-tools() {
  if [ ! -z "$1" ]
    then
      case "$1" in
        "help" )
          __help ;;
        "install-tools" )
          __install ;;
        "config" )
          __ok && __config ;;
        "create-service" )
          __ok && __create-service "$@" ;;
        "create-cluster" )
          __ok && __create-cluster "$2" ;;
        "load-config" )
          export $(cat $CFTOOLS_HOME/.env | xargs) ;;
        "setenv" )
          export ENV_LABEL=$2 ;;
        "usage" )
          __usage ;;
        * )
          echo "Command not recognized."
          echo "Usage:"
          __usage ;;
      esac
    else
      __config
  fi
}

function __usage() {
  cat <<- EOM
    cf-tools help
    cf-tools config
    cf-tools load-config
    cf-tools setenv
    cf-tools install-tools
    cf-tools create-cluster cluster-name
    cf-tools create-service service-name # go service
    cf-tools create-service service-name --nodejs # node based service
EOM
}

function  __help() {
  cat $CFTOOLS_HOME/README.md
}

function __install() {
  ([ `which aws` ] && echo "aws already installed") || (echo "installing aws" && pip install awscli)
  ([ `which ok` ] && echo "jq already installed") || ( echo "installing jq" && ([ `which brew` ] && brew install jq || [ `which apt-get` ] && apt-get install jq || [ `which yum` ] && yum install jq || [ `which choco` ] && choco install jq))
}

function __config() {
  echo "Current cf-tools environment:"
  __echoInfo "AWS_PROFILE: ${AWS_PROFILE}"
  __echoInfo "AWS_REGION: ${AWS_REGION}"
  __echoInfo "GIT_USER: ${GIT_USER}"
  [[ -z "$GIT_OAUTH_TOKEN" ]] && __echoInfo "GIT_OAUTH_TOKEN: " || __echoInfo "GIT_OAUTH_TOKEN: xxxxxxxx"
  __echoInfo "ENV_LABEL: ${ENV_LABEL}"
}

function __create-service {
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

function __create-cluster() {
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

function __ok() {
  if [[ -z "$AWS_PROFILE" || -z "$AWS_REGION"] || -z "$ENV_LABEL" ]]
    then
      echo "One of the required env variables are not set."
      __config
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

function __echoInfo() {
  printf "${Cyan}$1${NC}\n"
}


