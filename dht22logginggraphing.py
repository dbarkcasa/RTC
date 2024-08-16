import pandas as pd
import matplotlib.pyplot as plt

# Attempt to read the CSV file with different encodings
filename = 'dht22_data.csv'

try:
    df = pd.read_csv(filename, parse_dates=['Timestamp'], encoding='ISO-8859-1')
except UnicodeDecodeError:
    df = pd.read_csv(filename, parse_dates=['Timestamp'], encoding='cp1252')

# Ensure 'Timestamp' is in datetime format
df['Timestamp'] = pd.to_datetime(df['Timestamp'])

# Plot temperature and humidity
plt.figure(figsize=(12, 6))

# Plot temperature
plt.subplot(2, 1, 1)
plt.plot(df['Timestamp'], df['Temperature (°C)'], label='Temperature (°C)', color='red')
plt.xlabel('Time')
plt.ylabel('Temperature (°C)')
plt.title('Temperature over Time')
plt.legend()
plt.grid(True)