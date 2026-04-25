# IoT Monitoring Dashboard with Grafana

## Objective

This project extends the previous IoT pipeline by adding a real-time monitoring dashboard using Grafana.

The system already sends sensor data from Laptop 1 to Laptop 2 using socket programming, and Laptop 2 forwards the same data using MQTT. In this lab, Laptop 1 also receives the MQTT data and displays it live in Grafana.

---

## System Overview

```text
Laptop 1 (Sensor)
      │
      │ Socket Communication
      ▼
Laptop 2 (Edge Device)
      │
      │ MQTT Publish
      ▼
MQTT Broker
broker.emqx.io
      │
      │ MQTT Subscribe
      ▼
Laptop 1 (Main Server + Grafana Dashboard)
```

---

## Files Included

- socket_sensor.py
- edge_device.py
- README.md

---

## Socket Data Flow

### Laptop 1 → Sensor Node

The sensor generates random temperature values every 5 seconds and sends them using Python socket programming.

Example output:

```text
Sensor value sent: 23.4
Sensor value sent: 24.1
```

### Laptop 2 → Edge Device

The edge device receives the socket data and forwards the same values to the MQTT broker.

Example output:

```text
Edge received: 23.4
Forwarded to MQTT: 23.4
```

---

## MQTT Configuration

### Broker Used

broker.emqx.io

### Port

1883

### MQTT Topic Used

savonia/iot/temperature

---

## Grafana Setup

### Step 1 — Open Grafana

After installation, open:

http://localhost:3000

### Step 2 — Login

Default login:

Username: admin  
Password: admin

Grafana will ask you to change the password after first login.

### Step 3 — Install MQTT Data Source

- Go to Connections
- Click Add New Connection
- Search for MQTT
- Install MQTT Data Source plugin

### Step 4 — Configure Data Source

Use:

- Broker: broker.emqx.io
- Port: 1883
- Topic: savonia/iot/temperature

Save the data source.

### Step 5 — Create Dashboard

- Create New Dashboard
- Add New Panel
- Select MQTT Data Source
- Subscribe to topic:

savonia/iot/temperature

Now Grafana will start showing live MQTT values.

---

## Screenshot of Grafana Dashboard

Add your screenshot here before submission.

```text
Insert screenshot of Grafana dashboard here
```

---

## What is Shown in the Panel

The Grafana panel displays live incoming temperature values from the MQTT topic.

Every time the sensor sends a new value, Grafana updates automatically.

This helps in real-time monitoring of IoT devices.

---

## Limitation of Live-Only MQTT Visualization

The MQTT plugin in Grafana supports live monitoring only.

It does not store old values automatically.

This means previous values are not saved for later analysis.

For historical storage, extra systems like:

- InfluxDB
- Loki
- Prometheus

must be added.

---

## Reflection Questions

### 1. What is the role of Grafana in this system?

Grafana provides real-time visualization and monitoring of incoming MQTT sensor values.

It helps users see live values in a dashboard instead of only terminal output.

This makes monitoring easier and more professional.

### 2. Why is MQTT useful for monitoring applications?

MQTT is lightweight, fast, and efficient for IoT systems.

It allows devices to publish data and subscribers to receive it instantly.

This makes it ideal for real-time monitoring applications.

### 3. What is the difference between live monitoring and historical storage?

### Live Monitoring

Shows only current incoming values.

Used for immediate observation.

### Historical Storage

Saves old values for future analysis, reports, and graphs.

Grafana MQTT plugin mainly supports live monitoring unless a storage backend is added.

---

## Learning Outcomes

After completing this lab, I learned:

- socket communication between devices
- MQTT publish and subscribe messaging
- forwarding sensor data to MQTT
- Grafana live dashboard creation
- real-time IoT monitoring
- difference between live monitoring and historical storage
