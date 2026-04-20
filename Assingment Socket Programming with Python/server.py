import socket

def run_server():
    # Define host and port
    HOST = '127.0.0.1'  # Localhost
    PORT = 65432        # Arbitrary non-privileged port

    # Create a TCP/IP socket
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen()
        print(f"Server is listening on {HOST}:{PORT}...")

        # Accept a connection
        conn, addr = s.accept()
        with conn:
            print(f"Connected by {addr}")
            while True:
                data = conn.recv(1024)
                if not data:
                    break
                print(f"Received: {data.decode('utf-8')}")

if __name__ == "__main__":
    run_server()