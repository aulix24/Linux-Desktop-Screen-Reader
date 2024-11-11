#Sets variables to determine the installation status of required dependencies using command dpkg-query. Also sets variable TTSSTATE to default value of 0.
espeakstatus=$(dpkg-query -W --showformat='${db:Status-Status}' "espeak")
xselstatus=$(dpkg-query -W --showformat='${db:Status-Status}' "xsel")
TTSSTATE=0

#Checks stored variable espeakstatus for the output of dpkg-query to determine if dependency espeak is installed. If not, it is added to a list for the error handler.
if [ ! "$espeakstatus" = installed ]; then
	DEPENDENCIES+=('espeak')
fi

#Checks stored variable xselstatus for the output of dpkg-query to determine if dependency xsel is installed. If not, it is added to a list for the error handler.
if [ ! "$xselstatus" = installed ]; then
	DEPENDENCIES+=('xsel')
fi

#Checks for ttsreader_args.txt file. If it doesn't exist, it sets the TTSSTATE to 2 to create the file in the home directory. This is overwritten by the error handler.
if [ ! -f ./ttsreader_args.txt ]; then
        TTSSTATE=2
fi
#Checks list of missing dependencies for entries. It it finds any, it sets TTSSTATE to 1. This overwrites the previous state.
if [ ${#DEPENDENCIES[@]} -gt 0 ]; then
	TTSSTATE=1
fi

#Main code using variables initialized above
case $TTSSTATE in

	1)
		#Dependency error handler
		gnome-terminal -- bash -c "echo 'Dependencies ${DEPENDENCIES[*]} not installed. Install with sudo apt install ${DEPENDENCIES[*]}'; exec bash"
	;;

	0)
		#Main TTS reader function
		xsel | espeak $(cat ./ttsreader_args.txt)
	;;

	2)
		#Function for if ttsreader.txt doesn't exist in the home directory
		echo "-s 160 -v en-us -p 30 -a 110 -g 1" > ./ttsreader_args.txt
		gnome-terminal -- bash -c "echo 'Config file ttsreader_args.txt was not found in the home directory and has been created. Please try again.'; exec bash"
	;;

	*)
		#Unlikely case in which the variable TTSSTATE has not properly been set.
		gnome-terminal -- bash -c "echo 'error'; exec bash"
	;;

esac
