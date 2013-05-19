# A short tutorial to play a sound when a connection is made.
# Author: Andy Ibbitson
# Date: 07-03-2013
# Version: 1.0 (first)
##################################################
# You must have wiringPi installed to communicate 
# via gpio "sudo apt-get install wiringPi".
# Also mpg321 for mp3 playback "sudu apt-get install mpg321".
##################################################

# Connect a jumper to pin 3 (wiringPi 8) of the gpio for the hoop.
# Attach the jumper for the bendy wire to pin 25 (DNC)
# Then another jumper to pin 5 (wiringPi 9) for the start rest.
# And lastly a jumper to pin 24 (wiringPi 10) for the end rest.
# When touched together they will form a curcuit and prompt the Pi
# to play a sound, display a message and lose points.
# Below is the code to do it...
##################################################

setup ()
{
# set pin 8, 9 & 10 as an input
for i in 8 9 10 ; do gpio mode $i in ; done 
}

# Main loop
##################################################

score=9

echo "Your score is 10.  You lose a point every time you touch the wire!"

setup
while true;
do

# See if the game is over by reading gpio 10... If so, show well done message...
#################################################
 if [ `gpio read 10` == "1" ]; then
   finalscore=$(($score+1))
   echo "CONGRATULATIONS... You made it to the end. Your score is $finalscore"
   mpg321 contact_tada.mp3 -q
   exit

# If still playing then run the program...
#################################################
 elif [ `gpio read 9` == "1" ]; then

# We use the if statement to check for a connection...
#################################################
      if [ `gpio read 8` == "0" ]; then

# Check the score. If zero, we end the game...
#################################################
          if [ $score == "0" ]; then
            echo "Woopsy!!! You have lost all of your points...!"
            mpg321 contact_boo.mp3 -q
            exit

# Else we continue... We play a sound each time a connection 
# is made and show a message on screen with new score...
#################################################
          else
            echo ""
            echo "You got zapped. Your score is: $score"
            echo ""
            mpg321 contact_zap.mp3 -q
            sleep 0.05

# Reduce the score by 1...
################################################
            score=$(($score-1))
          fi
      fi
 fi

done