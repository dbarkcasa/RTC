import machine
import utime

# Set up the LED pin
led = machine.Pin(15, machine.Pin.OUT)

# Function to blink the LED
def blink(times, duration):
    for _ in range(times):
        led.on()
        utime.sleep(duration)
        led.off()
        utime.sleep(duration)

# Function to send the SOS signal
def sos():
    while True:
        # S.O.S signal pattern
        blink(3, 0.3)  # Three short flashes
        utime.sleep(0.3)
        blink(3, 0.9)  # Three long flashes
        utime.sleep(0.3)
        blink(3, 0.3)  # Three short flashes
        utime.sleep(3) # Wait before repeating

# Start the SOS signal
sos()
