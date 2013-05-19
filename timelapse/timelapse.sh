#!/bin/sh

# Time-lapse capture script
# Andy Ibbitson 17-03-2013
###############################

button=16

setup ()
{
  echo Setup
  gpio mode 0 out
}

# waitButton:
#       Wait for the button to be pressed. Because we have the GPIO
#       pin pulled high, we wait for it to go low to indicate a push.
#######################################################################

waitButton ()
{
  echo "Press the button to begin the sequence ... "
  while [ `gpio read $button` = 1 ]; do
    sleep 0.5
  done
}

beginCapture ()
{
i=0
echo "CAPTURING... [CTRL+C] to cancel..."
  while [ $i -lt 750 ]
  do
    fswebcam -r 1280x720 -S 15 --jpeg 95 --shadow --title "IbboCam" --subtitle "Chapel Road Worthing..." --info "Author: Andy Ibbitson" --save photos/home$i.jpg -q
    echo -n -e "Photo: $i \r"
    gpio write 0 1
    sleep 0.01
    gpio write 0 0
    sleep 0.5
  i=$(($i+1))
  done
}

setup
while true; 
do
  waitButton
  beginCapture
done
