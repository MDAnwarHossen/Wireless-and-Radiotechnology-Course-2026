import socket
import time
import random

def run_client():
    HOST = '127.0.0.1'  # Change this to Server IP for multi-device testing
    PORT = 65432

    # Create a TCP/IP socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        try:
            s.connect((HOST, PORT))
            print(f"Connected to server at {HOST}:{PORT}")

            while True:
                # Generate random temperature data
                temp = round(random.uniform(20.0, 30.0), 1)
                message = f"Temperature: {temp} C"
                
                # Send data
                s.sendall(message.encode('utf-8'))
                print(f"Sent: {message}")
                
                # Wait for 5 seconds
                time.sleep(5)
        except ConnectionRefusedError:
            print("Error: Could not connect to server. Is server.py running?")
        except KeyboardInterrupt:
            print("\nClient stopped.")

if __name__ == "__main__":
    run_client()