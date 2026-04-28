# IoT Real-Time Telegram Alert System

## Objective

The objective of this lab is to extend the IoT monitoring system by adding a real-time alert system.  
When the received temperature value exceeds a fixed threshold, the system sends a Telegram notification.

This simulates a simple cloud-based monitoring and alert system.

---

## System Architecture

```text
Sensor Device (Laptop 1)
        |
        | Socket Communication
        v
Edge Device (Laptop 2)
        |
        | MQTT Publish
        v
MQTT Broker
        |
        | MQTT Subscribe
        v
Cloud Server / Alert Subscriber (Laptop 1)
        |
        v
Telegram Alert Notification
```

---

## Files Included

- socket_sensor.py
- edge_device.py
- mqtt_alert_subscriber.py
- README.md

---

## MQTT Broker and Topic

MQTT Broker used:

```text
broker.emqx.io
```

MQTT Topic used:

```text
savonia/iot/temperature
```

The edge device publishes temperature values to this topic.  
The alert subscriber listens to the same topic.

---

## How the System Works

The sensor program runs on Laptop 1 and generates temperature data.  
This data is sent to the edge device using socket communication.

The edge device receives the temperature value and publishes it to the MQTT broker using the topic:

```text
savonia/iot/temperature
```

The MQTT alert subscriber runs on Laptop 1.  
It subscribes to the MQTT topic and checks every received temperature value.

If the temperature is higher than the threshold value, for example 28 °C, the system sends a Telegram alert message.

Example alert:

```text
ALERT: High temperature 29.3 °C
```

---

## Telegram Bot Setup

A Telegram bot was created using BotFather.

Steps:

1. Open Telegram.
2. Search for BotFather.
3. Use the command:

```text
/newbot
```

4. Save the bot token.
5. Send a message to the bot.
6. Open this URL in browser:

```text
https://api.telegram.org/botYOUR_TOKEN/getUpdates
```

7. Find the chat ID from the response.

---

## Running the System

Run the programs in this order:

### 1. Start the MQTT Alert Subscriber

```bash
python mqtt_alert_subscriber.py
```

### 2. Start the Edge Device

```bash
python edge_device.py
```

### 3. Start the Sensor

```bash
python socket_sensor.py
```

---

## Expected Output

Terminal output:

```text
Temperature: 29.3
ALERT: High temperature 29.3 °C
```

Telegram message:

```text
ALERT: High temperature 29.3 °C
```

---

## Screenshot of Telegram Alert

Add your screenshot here:

```text
[Insert Telegram alert screenshot here]
```

Example:

```markdown
![Telegram Alert](images/telegram_alert.png)
```

---

## Reflection Question

### Why is MQTT useful for building monitoring and alert systems in IoT?

MQTT is useful in IoT monitoring and alert systems because it is lightweight and fast. It works well when devices have limited power, memory, or network connection. MQTT uses a publish and subscribe model, so the sensor device does not need to communicate directly with the cloud server. It only publishes data to a topic, and any subscriber can receive that data.

This makes the system flexible and easy to expand. For example, one subscriber can show data in Grafana, another subscriber can save data in a database, and another subscriber can send alerts to Telegram. MQTT is also good for real-time systems because messages can be delivered quickly through the broker.

In this lab, MQTT helps send temperature data from the edge device to the alert subscriber. When the temperature becomes too high, the subscriber can immediately send a Telegram warning.
