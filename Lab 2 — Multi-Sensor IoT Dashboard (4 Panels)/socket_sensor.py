import socket
import random
import time

SERVER_IP = "192.168.1.100"
PORT = 5000

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((SERVER_IP, PORT))

while True:

    temperature = round(random.uniform(20,35),2)
    humidity = round(random.uniform(40,80),2)
    light = round(random.uniform(100,1000),2)

    message = f"{temperature},{humidity},{light}"

    client.send(message.encode())

    print("Sent:", message)

    time.sleep(5)