pin=4

i=0

current_state=0
previous_state=0

gpio mode $pin in

echo "INITIALISING..."
sleep 2

echo "Waiting for PIR to settle..."

while [ `gpio read $pin` = "1" ]; 
do
  current_state=1
  echo "Ready...!"
  while true;
  do
      if [ `gpio read $pin` = "0" ]; then
        echo "MOTION DETECTED $i"
        i=$(($i+1))
        sleep 5
      elif [ `gpio read $pin` = "1" ]; then
        echo "...................no motion"
        sleep 1
      fi
  done
done
