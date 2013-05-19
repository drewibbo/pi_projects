#!/bin/bash

button=16
led=0
i=0


gpio mode $led out
gpio write $led 0
gpio mode $button in

Intro ()
{
clear
  echo "WELCOME TO THE COOL GAME CALLED BUTTONBASH..."
  sleep 4
  echo "See how many times you can press the button in 3 seconds..."
  sleep 4
  echo "I will now countdown from 5. Get ready...!"
  sleep 4
  clear
  echo -n -e "        >>>>> 5 \r"
  gpio write 0 1
  sleep 0.01
  gpio write 0 0
  sleep 1
  echo -n -e "        >>>> 4 \r" 
  gpio write 0 1
  sleep 0.01
  gpio write 0 0
  sleep 1
  echo -n -e "        >>> 3 \r"
  gpio write 0 1
  sleep 0.01
  gpio write 0 0
  sleep 1
  echo -n -e "        >> 2 \r"
  gpio write 0 1
  sleep 0.01
  gpio write 0 0
  sleep 1 
  echo -n -e "        > 1 \r"
  gpio write 0 1
  sleep 0.01
  gpio write 0 0
  sleep 1 
  echo -n -e "        GO...! \r"
  sleep 1
}

Intro

waitButton ()
{
  while [ `gpio read $button` = 0 ]; do
   echo -n -e ">>>>> $i \r"
   gpio write $led 1
   sleep 0.1
   i=$(($i+1))
   gpio mode $button out
   gpio mode $button in
   gpio write $led 0
  continue
  done
}

# change this to the actual command that needs to run.
cmd="waitButton"
# how long should I wait ?
cmd_timeout=2
# dont edit this
cmd_status=`/usr/bin/expect < set timeout ${cmd_timeout}
spawn /bin/bash
sleep 0.5
send -- "${cmd}\n"
sleep 0.5
expect {
"*trans]#" {exit 10}
"*No such*" {exit 20}
timeout {exit 30}
}
EOF`
# you can edit from here
# get the return code from the previous command
ERRVAL=$?
# perform actions based on it ...
if [ $ERRVAL -eq 20 ]
then
echo "Sorry. Directory Not Found"
elif [ $ERRVAL -eq 30 ]
then
echo "Command \"$cmd\" timed out ... "
elif [ $ERRVAL -eq 10 ]
then

winningScore ()
{
count=0
for r in $i;
do
 echo "Your score is: $i"
  while [ $count -lt $r ]; 
  do
    gpio write 0 1
    sleep 0.5
    gpio write 0 0
    count=$(($count+1))
  done
 sleep 2
done
}

winningScore

fi
