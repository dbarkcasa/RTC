from machine import Pin
from time import sleep
myLED=Pin('LED',Pin.OUT)
while True:
	myLED.toggle()
	sleep(1)
	

	
'''
myLED.on()
myLED.off()
myLED.value(1)
'''
