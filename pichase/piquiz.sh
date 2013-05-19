## Functions...
setup ()
 {
   ## Set the gpio's to outputs...
   echo Setup
   for ia in 0 1 2 3 4 5 6 8 9 10 11 12 13 14 ; do gpio mode $ia out ; done
 }

intro ()
 {
  clear
  echo "welcome to piquiz.  The quiz for all ages with optional LEDs"
  sleep 4
  echo "To play the game, just answer the questions correctly.  The first to 7 points wins."
  sleep 4
 }

hardware ()
 {
   ## Ask the players if they have the LEDs connected...
   ## Put the answer into the variable "gpioa"...
   clear
   read -p "Do you have the LEDs connected? [y/n] : " gpioa
 }

testled ()
 {
   f=1
   while [ $f -lt 10 ]
   do
     clear
     echo "Testing the game board... Please wait..."
     ## Flash the LEDs on and off quickly (every millisecond) and repeat 10 times...
     for ib in 0 1 2 3 4 5 6 8 9 10 11 12 13 14 ; do gpio write $ib 1 ; done
     sleep 0.1
     for ic in 0 1 2 3 4 5 6 8 9 10 11 12 13 14 ; do gpio write $ic 0 ; done
     sleep 0.1
     f=$(($f+1))
   done
}

playerone ()
 {
   clear
   ## Ask player one to input their name, setup score & gpio...
   read -p "What is your name Player 1 : " pone
   ponescore=1
   ponegpio=0
 }

playertwo ()
 {
   clear
   ## Ask player two to input their name...
   read -p "What is your name Player 2 : " ptwo
   ptwoscore=1
   ptwogpio=8
 }

askQuestion ()
 {
      QUOTES_FILE=questions.txt
      numLines=`wc -l $QUOTES_FILE | cut -d" " -f 1`
      random=$RANDOM
      selectedLineNumber=$(($random - $(($random/$numLines)) * $numLines + 1))
      selectedLine=`head -n $selectedLineNumber $QUOTES_FILE | tail -n 1`
      question=$(echo "$selectedLine" | cut -d':' -f 1)
      answer=$(echo "$selectedLine" | cut -d':' -f 2)
 }

playthegame ()
 {
  clear
  i=1
  while true
  do
   if [ $ponescore -eq 7 ]
   then
    echo "WOO HOO $pone !!! YOU ARE THE WINNER"
    sleep 5
    exit
   elif [ $ptwoscore -eq 7 ]
   then
    echo "WOO HOO $ptwo !!! YOU ARE THE WINNER"
    sleep 5
    exit
   else
    if [[ $i -eq 1 ]]
    then
      ## Enter player one question...
      askQuestion
      echo "$pone : $question"
      read aone
       if [ "$aone" = "$answer" ];
       then
        ## If using LEDs then light up according to current score...
        if [ "$gpioa" = "y" ];
        then
          gpio write $ponegpio 1
        else
          echo ""
        fi
        echo "Well done $pone! Correct answer. Your score is $ponescore..."
        i=2
        ponegpio=$(($ponegpio + 1))
        ponescore=$(($ponescore + 1))
        sleep 5
        clear
        continue
       else
        echo "Oops! Wrong answer..."
        sleep 5
        clear
        ponegpio="$ponegpio"
        i=2
        continue
       fi
    fi
    if [[ $i -eq 2 ]]
    then
      ## Enter player two question...
      askQuestion
      echo "$ptwo : $question"
      read answertwo
       if [ "$answertwo" = "$answer" ];
       then
        if [ "$gpioa" = "y" ];
        then
          gpio write $ptwogpio 1
        else
          echo ""
        fi
        echo "Well done $ptwo! Correct answer. Your score is $ptwoscore..."
        i=1
        ptwogpio=$(($ptwogpio + 1))
        ptwoscore=$(($ptwoscore + 1))
        sleep 5
        clear
        continue
       else
        echo "Oops! Wrong answer..."
        ptwogpio="$ptwogpio"
        sleep 5
        clear
        i=1
        continue
       fi
    fi
   fi
  done
 }

## Run the game...
while true
do
 setup
 intro
 hardware
 if [ "$gpioa" = "y" ];
 then
  testled
 else
  echo ""
 fi
 sleep 5
 playerone
 playertwo
 playthegame
done
