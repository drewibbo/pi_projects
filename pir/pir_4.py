import RPi.GPIO as GPIO, time

GPIO.setmode(GPIO.BCM)      # Set up
GPIO.setup(17, GPIO.OUT)
GPIO.setup(7, GPIO.IN)

GPIO.output(17, True)       # Turn the light on to confirm it's working
time.sleep(5)
GPIO.output(17, False)
time.sleep(5)

while True:
    if GPIO.input(7):        # Listen for the PIR on pin 17
        print "Motion Sensor"
        GPIO.output(17, True)
        time.sleep(2)
        GPIO.output(17, False)
