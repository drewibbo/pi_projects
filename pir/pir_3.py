import time
import RPi.GPIO as io
io.setmode(io.BCM)
     
pir_pin = 7
     
io.setup(pir_pin, io.IN)
     
while True:
  if io.input(pir_pin):
    print("PIR ALARM!")
    time.sleep(5)
  else:
    print("No movement")
    time.sleep(2)
