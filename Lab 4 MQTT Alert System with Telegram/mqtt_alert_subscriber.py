import paho.mqtt.client as mqtt
import requests

broker = "broker.emqx.io"
topic = "savonia/iot/temperature"

TOKEN = "8019626355:AAFciPp-g8cU9ipf8Orhc-0MaCQxZST5GWs"
CHAT_ID = "YOUR_CHAT_ID"

threshold = 28

def send_telegram(message):

    url = f"https://api.telegram.org/bot{TOKEN}/sendMessage"

    payload = {
        "chat_id": CHAT_ID,
        "text": message
    }

    requests.post(url, data=payload)

def on_message(client, userdata, msg):

    temperature = float(msg.payload.decode())

    print("Temperature:", temperature)

    if temperature > threshold:

        alert = f"ALERT: High temperature {temperature} °C"

        print(alert)

        send_telegram(alert)

client = mqtt.Client()
client.connect(broker,1883)

client.subscribe(topic)

client.on_message = on_message

client.loop_forever()