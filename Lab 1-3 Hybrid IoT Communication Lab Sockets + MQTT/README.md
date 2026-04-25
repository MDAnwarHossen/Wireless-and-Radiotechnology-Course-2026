# IoT Sensor to Edge to Cloud Pipeline

## System Overview

This project demonstrates a simple IoT communication pipeline using Python sockets and MQTT.

The system contains three parts:

- Laptop 1: Sensor Node
- Laptop 2: Edge Device
- Laptop 1: Main Server / Cloud Subscriber

## System Architecture

```text
Sensor Node (Laptop 1)
        |
        | Socket Communication
        v
Edge Device (Laptop 2)
        |
        | MQTT Publish
        v
MQTT Broker
broker.emqx.io
        |
        | MQTT Subscribe
        v
Cloud Subscriber (Laptop 1)
```

## Data Flow

```text
Sensor (Laptop 1)
      ↓ Socket
Edge Device (Laptop 2)
      ↓ MQTT
Main Server / Cloud Subscriber (Laptop 1)
```

## Files Included

- socket_server.py
- socket_sensor.py
- mqtt_publisher.py
- mqtt_subscriber.py
- edge_device.py
- README.md

## MQTT Configuration

- Broker: broker.emqx.io
- Port: 1883
- Topic: savonia/iot/temperature

## IP Addresses Used


```python
SERVER_IP = "192.168.1.100"
PORT = 5000
```

## Required Python Libraries

```bash
pip install paho-mqtt
```

## Learning Outcomes

After completing this project, I learned:

- Socket-based device communication
- MQTT publish/subscribe messaging
- Edge computing concepts
- IoT system architecture
