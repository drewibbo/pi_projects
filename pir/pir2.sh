pin=8

i=0

current_state=0
previous_state=0

gpio mode $pin in

echo "INITIALISING..."
sleep 5

echo "Waiting for PIR to settle..."

while [ `gpio read $pin` == "0" ]; 
do
echo "Ready...!"

while true;
do

      if [ `gpio read $pin`=="0" ] && [ $previous_state="1" ]; then
        echo "MOTION DETECTED $i"
        i=$(($i+1))
        previous_state=0
      elif [ `gpio read $pin`=="1" ] && [ $previous_state="0" ]; then
        echo "Ready to detect..."
        previous_state=1
      fi
      sleep 0.1
done
done
