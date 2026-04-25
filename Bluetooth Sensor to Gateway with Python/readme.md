# Bluetooth Client–Server IoT Sensor Project

## Project Description

This project is a simple Bluetooth client–server application built in Python using RFCOMM sockets.

The system simulates an IoT sensor node that sends temperature data to a gateway device over Bluetooth.

- Client = Sensor Device
- Server = Gateway Device

The client generates a random temperature value every 5 seconds and sends it to the server using Bluetooth communication.

The server receives the data and prints it on the screen.

Example:

Temperature: 22.8 C  
Temperature: 23.4 C  
Temperature: 21.9 C

---

## Bluetooth MAC Address Used

Replace this with your real Bluetooth MAC address:

XX:XX:XX:XX:XX:XX

Example:

B8:27:EB:45:12:34

---

## Files Included

- server.py
- client.py
- README.md

---

## How to Run

### Step 1: Make sure Python is installed

Check Python version:

```bash
python --version
```

Python 3.x is required.

---

### Step 2: Enable Bluetooth

Make sure Bluetooth is turned on for both devices.

Also make sure both devices are paired before running the program.

---

### Step 3: Update MAC Address

Open both files:

- server.py
- client.py

Replace:

```python
("XX:XX:XX:XX:XX:XX", 4)
```

with your actual Bluetooth MAC address.

Example:

```python
("B8:27:EB:45:12:34", 4)
```

---

### Step 4: Run Server

Run this on the gateway device:

```bash
python server.py
```

---

### Step 5: Run Client

Run this on the sensor device:

```bash
python client.py
```

---

## Screenshot of Successful Communication

(Add your screenshot here)

Example:

![Bluetooth Communication Screenshot](screenshot.png)

---

## Reflection

### What did I learn?

I learned how Bluetooth socket communication works in Python using RFCOMM sockets.

I also learned how a client and server communicate directly using Bluetooth instead of WiFi.

This helped me understand practical IoT communication between a sensor node and a gateway device.

---

### What was difficult?

The most difficult part was finding the correct Bluetooth MAC address and making sure both devices were properly paired.

Sometimes connection errors happened because Bluetooth permissions were missing or the MAC address was incorrect.

Testing Bluetooth communication was more difficult than normal network socket programming.

---

### Where could Bluetooth communication be useful in IoT?

Bluetooth communication is useful in many IoT systems such as:

- Smart home devices
- Temperature sensors
- Smartwatches
- Health monitoring devices
- Car systems
- Industrial monitoring devices

It is especially useful when devices are close to each other and low power consumption is important.

---

## Reflection Question

### What is the difference between Bluetooth socket communication and WiFi socket communication in practice?

Bluetooth socket communication is mainly used for short-distance communication between nearby devices. It does not require internet or a router. Devices must usually be paired before communication starts.

WiFi socket communication is used for longer-distance communication through a local network or the internet. It usually requires a router or access point. Devices communicate using IP addresses instead of Bluetooth MAC addresses.

### Bluetooth Advantages

- Low power consumption
- Direct device-to-device connection
- Good for short-range communication
- No WiFi network needed

### Bluetooth Disadvantages

- Short range only
- Slower data transfer
- Limited connected devices

### WiFi Advantages

- Faster data transfer
- Longer communication range
- Can connect many devices
- Internet access possible

### WiFi Disadvantages

- Higher power consumption
- Requires network setup
- Usually needs router or internet

### Simple Difference

Bluetooth = direct nearby communication  
WiFi = network-based communication over longer distance

Example:

- Bluetooth → Smartwatch connected to phone
- WiFi → Security camera sending video to cloud server

In this assignment, Bluetooth is better because the goal is direct communication between a sensor node and a gateway device without using internet or WiFi.

