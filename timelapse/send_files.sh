##############################################################
# Title: Encode And Send Time-Lapse Video Via SCP
## Date: 02-04-2013
### Author: Andrew Ibbitson <'andyibbitson@googlemail.com'>
##############################################################

echo "This script will encode a time lapse movie and send the files to the laptop..."
echo "\n"
echo "ENCODE THE VIDEO NOW OR JUST SEND THE FILES (ensure the laptop is powered up)... [e/s](e=ENCODE/s=JUST SEND FILES)..." 
read inputmake
filedate=$(date +"%d-%m-%Y-%H-%M")
if [ $inputmake == "e" ]; then
    cd photos
    ls -1tr | grep -v files > $filedate.txt
    echo "Enter the desired frame rate of the finished movie"
    read frames
#    mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4 -o $filedate.avi -mf type=jpeg:fps=$frames:mbd=1: mf://@$filedate.txt
#    mencoder -mf fps=25 -o $filedate.avi -ovc lavc -lavcopts vcodec=mpeg4 mf://@$filedate.txt 
     mencoder -mf fps=$frames -o $filedate.avi -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=3000 mf://@$filedate.txt
    cd ..
      echo "\n"
      echo "Your time lapse movie has been created. Would you like to send the files to the laptop?... [y/n]..."
      read inputsend
      if [ $inputsend == "y" ]; then
        echo "Deleting image files from the Raspberry Pi"
        sleep 1
        cd photos
        rm -r *.jpg
        echo "COMPLETED"
        cd ..
        sleep 0.5
        echo "Sending movie to the laptop"
        sleep 1
        scp -r photos/ drewibbo@ubuntu://host/Pi/pi_timelapse/
        echo "COMPLETED"
      else
        echo "OK THIS SCRIPT WILL NOW EXIT. Your movie is saved in the photos folder."
     fi
elif [ $inputmake == "s" ]; then
    echo "Your files will be sent to the laptop..."
    sleep 1
    scp -r photos/ drewibbo@ubuntu://host/Pi/pi_timelapse/
    echo "COMPLETED"
else
    echo "OK THIS SCRIPT WILL NOW EXIT... Nothing has been done."
    exit
fi
