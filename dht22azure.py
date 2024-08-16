import time
import board
import adafruit_dht
import json
from azure.iot.device import IoTHubDeviceClient, Message

# Azure IoT Hub connection string
CONNECTION_STRING = "HostName=IoThubname123.azure-devices.net;DeviceId=RP4;SharedAccessKey=2m9xAloOACt+1IGEDQvr5dAJgeu+>
# Initialize the DHT22 sensor
dhtDevice = adafruit_dht.DHT22(board.D4)

# Create an IoT Hub client
client = IoTHubDeviceClient.create_from_connection_string(CONNECTION_STRING)

while True:
    try:
        # Reading temperature and humidity
        temperature_c = dhtDevice.temperature
        humidity = dhtDevice.humidity
        temperature_f = temperature_c * (9 / 5) + 32

        # Create a JSON message
        message = {
            "Temperature": temperature_f,
            "Humidity": humidity