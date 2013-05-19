#!/usr/bin/python

import RPi.GPIO as GPIO
import time
 
PIR = 0
LED = 17
 
pirState = True                        # we start, assuming no motion detected
pirVal = True                          # we start, assuming no motion detected

GPIO.setmode(GPIO.BCM)
GPIO.setup(PIR, GPIO.IN)
GPIO.setup(LED, GPIO.OUT)
 
while True:
    pirVal = GPIO.input(PIR)            # read input value
    if (pirVal == False):                # check if the input is LOW
        GPIO.output(LED, True)          # turn LED ON
        print "Motion detected"
        time.sleep(2)
        if (pirState == True):
            # we have _just_ turned on
            pirState = False
            time.sleep(2)
    else:
        GPIO.output(LED, False)         # turn LED OFF
        if (pirState == False):
            # we have _just_ turned off
            time.sleep(2)
            pirState = True;
