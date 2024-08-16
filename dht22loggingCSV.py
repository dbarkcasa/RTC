import time
import board
import adafruit_dht
import csv
import os

# Initialize the DHT22 sensor
dhtDevice = adafruit_dht.DHT22(board.D4)

# Specify the filename for the CSV file
filename = "dht22_data.csv"

# Check if the file exists; if not, create it and write the header
file_exists = os.path.isfile(filename)
with open(filename, mode='a', newline='') as file:
    writer = csv.writer(file)
    if not file_exists:
        # Write the header only if the file is newly created
        writer.writerow(["Timestamp", "Temperature (°C)", "Humidity (%)"])

while True:
    try:
        # Read temperature and humidity
        temperature = dhtDevice.temperature
        temperature_f = temperature_c * (9 / 5) + 32
        humidity = dhtDevice.humidity