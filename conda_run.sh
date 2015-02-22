#!/bin/bash

#'activate and deactivate anaconda distribution'

case $1 in
run)
  echo "Activate Anaconda Environment"
  source $HOME/anaconda3/bin/activate ~/anaconda3/
  ;;
*)
  source $HOME/anaconda3/bin/deactivate
  ;;
esac
echo
echo -ne "Current iPython env: "
which ipython
echo
