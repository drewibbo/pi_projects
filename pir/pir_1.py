#!/usr/bin/python
#+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#|R|a|s|p|b|e|r|r|y|P|i|-|S|p|y|.|c|o|.|u|k|
#+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
#
# pir_1.py
# Detect movement using a PIR module
#
# Author : Matt Hawkins
# Date   : 21/01/2013

# Import required Python libraries
import RPi.GPIO as GPIO
import time

# Use BCM GPIO references
# instead of physical pin numbers
GPIO.setmode(GPIO.BOARD)

# Define GPIO to use on Pi
GPIO_PIR=3

print "PIR Module Test (CTRL-C to exit)"

# Set pin as input
GPIO.setup(GPIO_PIR,GPIO.IN)      # Echo

Current_State=1
Previous_State=1

time.sleep(5)

try:

  print "Waiting for PIR to settle ..."

  # Loop until PIR output is 1
  while GPIO.input(GPIO_PIR)==0:
    Current_State=1

  print "  Ready"     
    
  # Loop until users quits with CTRL-C
  while True :
   
    # Read PIR state
    Current_State=GPIO.input(GPIO_PIR)
   
    if Current_State==0 and Previous_State==1:
      # PIR is triggered
      print "  Motion detected!"
      # Record previous state
      Previous_State=0
    elif Current_State==1 and Previous_State==0:
      # PIR has returned to ready state
      print "I am Ready"
      Previous_State=1
      
    # Wait for 10 milliseconds
    time.sleep(0.1)      
      
except KeyboardInterrupt:
  print "  Quit" 
  # Reset GPIO settings
  GPIO.cleanup()

GPIO.cleanup()
