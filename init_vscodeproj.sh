#!/bin/bash

# This script creates a datascience workflow dir str
# project opens in a vscode editor
# use -k for a simple project dir 
# requirement git vscode python3 virtualenv


set -eo pipefail

function log(){
  echo "[+] `date '+%Y/%m/%d %H:%M:%S'`" $1
}

usage(){
	echo "Usage: `basename $0` -d <proj_dir|None> -e <env_name|None> -k [simple dir str|full dir str]";
}
gwd=`pwd`
while getopts :d:e:k options; do
  case $options in
    d) pdir=${OPTARG}  ;;
    e) edir=${OPTARG} ;;
    k) kind=true ;;
    \?) usage ; exit 1;;
  esac
done
shift $((OPTIND-1))

if [[ ! -z $pdir ]]
then
  dir_name=$pdir
  mkdir -p $dir_name; log "Created dir : $dir_name"; 
else
  dir_name="myproj_"`date '+%s'` && mkdir -p $dir_name;  log "Created dir : $dir_name"; 
fi

if [[ ! -z $edir ]]
then
  venv=$edir
  cd $dir_name ;
  python3 -m venv $venv && log "Created vir env : $venv";
  source $venv/bin/activate ;
else
  venv="venv"
  cd $dir_name ;
  python3 -m venv $venv && log "Created vir env : $venv";
  source $venv/bin/activate ;
fi

if [[ $kind = true ]]
then
  mkdir -p .vscode code
  log "Created dir : $dir_name/.vscode/ "
  log "Created dir : $dir_name/code/"
else
  mkdir -p .vscode code data analysis docs output
  log "Created dir : $dir_name/.vscode/ "
  log "Created dir : $dir_name/code/"
  log "Created dir : $dir_name/data/"
  log "Created dir : $dir_name/analysis/"
  log "Created dir : $dir_name/docs/"
  log "Created dir : $dir_name/output/"
fi


# git init

log "git init"
git init -q 2> /dev/null 

# git ignore
touch .gitignore 
echo -en ".DS_Store\n$venv" >>.gitignore

# make a readme file
touch README.md
readme_desc="--- \n\
title : $1 \n\
date : `date +'%A %b %d %Z %Y %r'` \n\
--- \n\
\n\n\
# This is a new project \n\
\n\
\n\
"
echo -en $readme_desc >>README.md

# make a python empty file
touch code/main.py

# vscode settings to activate the env
touch .vscode/settings.json
vscode_settings="\n\
{ \n\
  \"python.defaultInterpreterPath\": \"$gwd/$dir_name/$venv/bin/python\" \n\
} \n\
"

echo -en $vscode_settings >.vscode/settings.json

# open the main file in vscode
log "Opening project dir in vscode"

# Toggle
# if on M1 Mac 
code-insiders .
# if on macbookpro
# code(){ VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* }
# cd $gwd/$dir_name
# code .





