# IoT Real-Time Home Monitoring Stream Lab

## Objective

The objective of this lab is to build a simple real-time home monitoring system using Python, OpenCV, and Flask. The system captures live video from a webcam on one laptop and streams it over the local WiFi network so another laptop can view the stream in a web browser.

## System Scenario

This lab simulates a basic IoT camera monitoring system.

Pipeline:

```text
Camera → Capture → Encode → Stream → Viewer
```

- **Laptop A:** Camera / Sender
- **Laptop B:** Viewer / Receiver
- **Network:** Both laptops connected to the same WiFi network

## Files Included

```text
iot_stream_lab/
│
├── app.py
└── README.md
```

## Software Requirements

Install Python 3 and the required packages on the sender laptop:

```bash
pip install opencv-python flask
```

Check Python installation:

```bash
python --version
```

## How to Run the System

### Step 1: Start the Stream on Laptop A

Open Command Prompt in the project folder and run:

```bash
python app.py
```

The Flask server should start and show that it is running on port `5000`.

### Step 2: Find Sender IP Address

On Laptop A, run:

```bash
ipconfig
```

Find the IPv4 address. Example:

```text
192.168.1.20
```

### Step 3: Open Stream on Laptop B

On Laptop B, open a browser and enter:

```text
http://SENDER_IP:5000
```

Example:

```text
http://192.168.1.20:5000
```

## Test Information

| Item | Result |
|---|---|
| Sender name | Write sender student name here |
| Viewer name | Write viewer student name here |
| Sender IP address | Write IP address here |
| Webcam stream started | Yes / No |
| Viewer could open browser stream | Yes / No |
| Video updated continuously | Yes / No |
| Timestamp added on video frame | Yes |

## Expected Result

The sender laptop opens the webcam and runs a Flask web server. The viewer laptop connects to the sender IP address using a browser. The browser displays the live webcam video, and the image updates continuously in real time.

## Problems and Fixes

Possible problems and solutions:

1. **Viewer cannot open the stream**
   - Check that both laptops are on the same WiFi network.
   - Check that the sender IP address is correct.
   - Make sure `app.py` is running on the sender laptop.

2. **Webcam does not open**
   - Close other apps using the webcam.
   - Check that the webcam is enabled.
   - Try restarting the Python program.

3. **Firewall blocks connection**
   - Allow Python through Windows Firewall.
   - Make sure port `5000` is not blocked.

4. **Stream is slow**
   - Reduce the displayed width.
   - Reduce camera resolution.
   - Make sure the WiFi connection is stable.



## Evaluation

The system worked correctly if:

- The webcam opened on Laptop A.
- Flask server started successfully.
- Laptop B accessed the stream using the sender IP address.
- The video updated continuously in the browser.
- The system behaved like a simple home monitoring camera.

## Conclusion

This lab showed how a simple IoT video monitoring system works in real time. The camera node captured frames using OpenCV, encoded them as JPEG images, and streamed them through a Flask web server. The viewer laptop accessed the stream through a browser using the sender IP address. This method is similar to real monitoring systems such as home cameras, baby monitors, office observation systems, and remote monitoring devices.

## AI Statement

AI assistance was used to prepare and organize the README file and improve the code comments. The code was reviewed and can be tested manually in the lab environment.
