#!/bin/bash
#
# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}

clear
                  # Set up the gpio (WiringPi) pins for the Green & Red LEDs and the button
button=16
green=0
red=1

waitButton ()
{
  echo "Press the button to begin the sequence ... "
  while [ `gpio read $button` = 1 ]; do
    sleep 0.5
  done
}
                  # Start the script
echo -e "\n\n $txtbld $txtund Hello. Welcome to the kid safe script... please enter a command... $txtrst"

while true
do
                  # Provide options for each process
echo -e "\n\n Options... "
echo -e " > Turn on/off the green led = $bldblu green on/green off $txtrst \n > Turn on/off the red led = $bldblu red on/red off $txtrst \n > What is the temperature = $bldblu how hot is it $txtrst \n > Make the LEDs flash (x) amount of times = $bldblu flash $txtrst \n > Make the button write to the screen = $bldblu button $txtrst \n > Take a photo with the webcam = $bldblu take a photo $txtrst \n > Play a song = $bldblu music $txtrst \n > Exit this script = $bldblu exit $txtrst \n"
read -p "$bldblu What would you like to do : $txtrst " input
                  # Ask for the users input using the provided options
clear
if [ "$input" == "green on" ]; then
                  # set the green LED pin to output
  gpio mode $green out
                  # Turn the green LED on
  gpio write $green 1
  echo "$bldred >>>>> The green LED has been turned on. $txtrst"
elif [ "$input" == "green off" ]; then
                  # Turn the green LED off
  gpio write $green 0
  echo "$bldred >>>>> The green LED has been turned off. $txtrst"
elif [ "$input" == "red on" ]; then
                  # set the red LED pin to output
  gpio mode $red out
                  # Turn the red LED on
  gpio write $red 1
  echo "$bldred >>>>> The red LED has been turned on. $txtrst"
elif [ "$input" == "red off" ]; then
                  # Turn the red LED off
  gpio write $red 0
  echo "$bldred >>>>> The red LED has been turned off. $txtrst"
elif [ "$input" == "flash" ]; then
                  # ask the user how many times to flash the LEDs
  echo -e "\n How many times would you like the LED to flash? \n"
  read flash
                  # Set the green & red LED pins to outputs
  gpio mode $green out
  gpio mode $red out
  i=1
  flash=$(($flash+1))
  while [ $i -lt $flash ]
  do
    echo -n -e "$bldred >>>>> The LEDs have flashed $i times $txtrst \r"
                  #  Turn the green & red LEDs on and off quickly (every millisecond) and repeat 10 times
    gpio write $green 1
    gpio write $red 1
    sleep 0.1
    gpio write $green 0
    gpio write $red 0
    sleep 0.1
  i=$(($i+1))
  done
elif [ "$input" == "how hot is it" ]; then
                  # Open the thermometer CAT file and read the temperature
  tempread=`cat /sys/bus/w1/devices/28-00000495b443/w1_slave`
  tem=`echo $tempread | cut -d"=" -f3`
  temp=$(echo "scale=2; $tem /1000" | bc)
                  # Flash the LEDsto make it look pretty
  gpio write 0 1
  gpio write 1 1
  sleep 2
  gpio write 0 0
  gpio write 1 0
  echo "$bldred >>>>> The temperature outside is: $bldblu $temp degrees $txtrst"
elif [ "$input" == "button" ]; then
                  # Run the button script
  waitButton
  echo -e "$bldred >>>>> You have pushed the button $txtrst"
elif [ "$input" == "take a photo" ]; then
  read -p "$bldred Please enter your FULL name... >>>>> $txtrst" name
  today=$(date +"%d-%m-%Y-%H-%M")
  fswebcam -r 1280x720 -S 15 --jpeg 95 --shadow --title "PiCam" --subtitle "Photo taken using Andy Ibbitsons KidPi script" --info "Photographer: $name" --save kidpi_"$name"\_$today.jpg -q
  echo "$bldred Your photo has been saved to the computer$bldblu $name. $bldred It is in the same location as this script $txtrst"
elif [ "$input" == "music" ]; then
  cd music
  echo "$bldblu These are the songs you can play: $txtrst"
  ls -1 --file-type *.mp3
  read -p "$bldblu Which song would you like to play : $txtrst" song
  echo "$bldred >>>>> Now playing $song $txtrst"
  mpg321 $song -q
  cd ..
elif [ "$input" == "exit" ]; then
                  # Turn off the LEDs (if they are still on)
  gpio write $green 0
  gpio write $red 0
  sleep 0.5
  echo -e "\n $bldwht Thank you for using this script.  I hope you have enjoyed it...? :) $txtrst \n"
                  # Exit the script safely
  exit
fi
done
