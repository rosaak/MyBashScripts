#!/bin/bash
# Author : roshan padmanabhan

bioserver=$1 ;

function Entry()
		if [[ $1 == 20 || $1 == 22 || $1 == 23 || $1 == 24 || $1 == 25 || $1 == 27 ]]; then
		let bioserver=$1 ;
		else
		Warnings
		fi
function EnterServer()
	{
	#echo "ssh -X roshan@139.124.153.$bioserver";
	ssh -X roshan@139.124.153.$bioserver;
	#ssh -X roshan@139.124.153.$bioserver;
	}

function EnterServer2()
	{
	#echo "ssh -Xt roshan@139.124.153.$Sno";
	ssh -Xt roshan@139.124.153.$Sno;
	#ssh -X roshan@139.124.153.$bioserver;
	}

function Warnings(){
	echo -en "server numbers are 20|22|23|24|25 and 27\n"
	}

function ServerChoice(){
	case $@ in 
		20) 
			echo "Entering server 20"
			EnterServer
			;;
		22) 
			echo "Entering server 22"
			EnterServer
			;;
		23) 
			echo "Entering server 23"
			EnterServer
			;;
		24) 
			echo "Entering server 24"
			EnterServer
			;;
		25) 
			echo "Entering server 25"
			EnterServer
			;;
		27) 
			echo "Entering server 27"
			EnterServer
			;;
		*) 
			Warnings
			#sleep 2
			TryAgain
			;;
	esac
	}

function reLoop(){
	echo -en "Provide a Server number, s'il vous plaît: ";
	read Sno;
	#echo "the server no u provided is : $Sno";
		if [[ $Sno == 20 || $Sno == 22 || $Sno == 23 || $Sno == 24 || $Sno == 25 || $Sno == 27 ]]; then
		EnterServer2 $Sno
		else
		Warnings
		fi

	}

function TryAgain(){
	echo -en "Want to re Run the script: (y|n) : "
	read choice
	case $choice in
	[yY]es|[Yy])
		reLoop
		;;
	*)
		echo "Bye"
		exit
		;;
	esac
	}

ServerChoice $bioserver





