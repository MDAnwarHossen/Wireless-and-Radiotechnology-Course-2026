# Multi-Sensor IoT Monitoring Dashboard with Grafana

## Objective

In this lab, the previous IoT pipeline is extended by adding more sensor values and visualizing them in Grafana.

The system now sends multiple sensor readings from the sensor node to the edge device. The edge device forwards each sensor value to a separate MQTT topic. Grafana subscribes to these topics and displays the data in a 4-panel monitoring dashboard.

---

## System Overview

```text
Sensor Node (Laptop 1)
      │
      │ Socket Communication
      ▼
Edge Device (Laptop 2)
      │
      │ MQTT Publish
      │
      │ Multiple MQTT Topics
      ▼
MQTT Broker
broker.emqx.io
      │
      │ MQTT Subscribe
      ▼
Grafana Dashboard (Laptop 1)
```

---

## Files Included

```text
socket_sensor.py
edge_device.py
README.md
```

---

## Sensors Used

This project uses three simulated sensors.

### 1. Temperature Sensor

The temperature sensor generates random temperature values.

Example range:

```text
20°C to 35°C
```

MQTT topic:

```text
savonia/iot/temperature
```

---

### 2. Humidity Sensor

The humidity sensor generates random humidity values.

Example range:

```text
40% to 80%
```

MQTT topic:

```text
savonia/iot/humidity
```

---

### 3. Light Sensor

The light sensor generates random light intensity values.

Example range:

```text
100 lux to 1000 lux
```

MQTT topic:

```text
savonia/iot/light
```

---

## Socket Sensor Program

File:

```text
socket_sensor.py
```

The sensor node generates three values:

- temperature
- humidity
- light

The values are sent together as one comma-separated message through socket communication.

Example message:

```text
23.5,55.2,730.4
```

Example output:

```text
Sent: 23.5,55.2,730.4
Sent: 24.1,57.8,680.2
```

---

## Edge Device Program

File:

```text
edge_device.py
```

The edge device receives the socket message from Laptop 1.

It splits the message into three separate values:

```text
temperature, humidity, light
```

Then it publishes each value to its own MQTT topic.

Example output:

```text
Forwarded: 23.5,55.2,730.4
Forwarded: 24.1,57.8,680.2
```

---

## MQTT Configuration

### MQTT Broker

```text
broker.emqx.io
```

### MQTT Port

```text
1883
```

### MQTT Topics Used

```text
savonia/iot/temperature
savonia/iot/humidity
savonia/iot/light
```

---

## Grafana Dashboard

Grafana is used to visualize the live MQTT sensor data.

The dashboard contains four panels.

---

## 4-Panel Dashboard Layout

The dashboard layout is arranged like this:

```text
-------------------------------------
| Temperature Graph                 |
-------------------------------------
| Humidity Gauge | Light Gauge      |
-------------------------------------
| Temperature Status | Humidity Status |
-------------------------------------
```

A simpler layout can also be used:

```text
-------------------------------------
| Temperature Graph                 |
-------------------------------------
| Humidity | Light                  |
-------------------------------------
| Status Panel                      |
-------------------------------------
```

---

## Panel 1 — Temperature Graph

### Topic

```text
savonia/iot/temperature
```

### Visualization

Recommended visualization:

```text
Time series
```

### Purpose

This panel shows how temperature changes over time.

It helps monitor temperature trends in real time.

---

## Panel 2 — Humidity Gauge

### Topic

```text
savonia/iot/humidity
```

### Visualization

Recommended visualization:

```text
Gauge
```

### Purpose

This panel shows the current humidity value.

It gives a quick view of whether humidity is low, normal, or high.

---

## Panel 3 — Light Gauge

### Topic

```text
savonia/iot/light
```

### Visualization

Recommended visualization:

```text
Gauge or Time series
```

### Settings

```text
Unit: lux
Min: 0
Max: 1000
```

### Purpose

This panel shows the current light intensity value.

It helps monitor brightness levels in real time.

---

## Panel 4 — Status Panel

### Topics

This panel can use one or more of the following topics:

```text
savonia/iot/temperature
savonia/iot/humidity
savonia/iot/light
```

### Visualization

Recommended visualization:

```text
Stat
```

### Purpose

This panel shows the current status of the sensor values.

For example:

- current temperature
- current humidity
- current light level

It gives a quick summary of the system condition.

---


## How to Run the System

### Step 1 — Run Sensor Node on Laptop 1

```bash
python socket_sensor.py
```

### Step 2 — Run Edge Device on Laptop 2

```bash
python edge_device.py
```

### Step 3 — Open Grafana on Laptop 1

Open Grafana in the browser:

```text
http://localhost:3000
```

Check that the dashboard receives and displays:

- temperature values
- humidity values
- light values
- status indicators

---

## Expected Output

Grafana should display:

- temperature changing over time
- humidity values
- light values
- status indicators

The terminal output should also show the data being sent and forwarded.

Sensor node example:

```text
Sent: 23.5,55.2,730.4
```

Edge device example:

```text
Forwarded: 23.5,55.2,730.4
```

---

## Reflection Question

### Why do we separate each sensor into a different MQTT topic?

Each sensor is separated into a different MQTT topic because it makes the system easier to organize, monitor, and expand.

For example, temperature data is published to:

```text
savonia/iot/temperature
```

Humidity data is published to:

```text
savonia/iot/humidity
```

Light data is published to:

```text
savonia/iot/light
```

This makes it easier for Grafana or any subscriber to receive only the data it needs.

It also helps when adding new sensors later. A new sensor can have its own topic without changing the whole system.

Separate topics also make debugging easier because each sensor stream can be checked individually.

---

## Learning Outcomes

After completing this lab, I learned how to:

- design a multi-sensor IoT system
- send structured sensor data using sockets
- split sensor data on the edge device
- publish multiple MQTT topics
- connect Grafana to MQTT data streams
- build a multi-panel Grafana dashboard
- understand why MQTT topics are separated by sensor type

---

## Conclusion

This lab shows how a simple IoT system can be expanded into a multi-sensor monitoring system.

The sensor node sends temperature, humidity, and light values to the edge device. The edge device separates the values and publishes them to different MQTT topics. Grafana then displays the live values in a dashboard.

This setup demonstrates an important IoT concept: collecting data from sensors, forwarding it through an edge device, and monitoring it in real time.
