# Intelligent Home Monitoring System with YOLO

## Objective

The objective of this lab is to build a simple AI-enabled IoT monitoring system. One laptop streams live webcam video over the local WiFi network, and another laptop receives the stream and runs YOLO object detection in real time.

## System Pipeline

Camera → Stream → AI Processing → Detection Result

## Group Setup

- Laptop A: Camera / Sender
- Laptop B: AI Node / Receiver
- Sender IP address: `192.168.1.20`  
  Replace this with the real IPv4 address from Laptop A.

## Software Requirements

### Laptop A

```bash
pip install opencv-python flask
```

### Laptop B

```bash
pip install opencv-python ultralytics
```

## Files Included

```text
iot_yolo_stream_lab/
│
├── app.py
├── yolo_stream.py
└── README.md
```

## How to Run the System

### Step 1: Start the video stream on Laptop A

Open Command Prompt in the project folder and run:

```bash
python app.py
```

The Flask server starts on port 5000. The video stream is available at:

```text
http://SENDER_IP:5000/video_feed
```

Example:

```text
http://192.168.1.20:5000/video_feed
```

### Step 2: Run YOLO detection on Laptop B

Open `yolo_stream.py` and replace the stream URL with the real sender IP address:

```python
STREAM_URL = "http://192.168.1.20:5000/video_feed"
```

Then run:

```bash
python yolo_stream.py
```

A window named **YOLO Home Monitoring** opens and displays the live stream with detected objects.

Press `q` to stop the program.

## Expected Result

Laptop A captures live webcam video and streams it through Flask. Laptop B receives the video stream, processes each frame using YOLOv8, and displays detected objects with bounding boxes and labels.

## Objects Detected

During testing, YOLO can detect common objects such as:

- person
- chair
- laptop
- cell phone
- bottle

The exact detected objects depend on what appears in front of the webcam.

## Optional Extension Added

The receiver program prints detected object names in the terminal.

Example:

```text
Detected: person, chair
```

## Bonus Task Added

When a person is detected, the current annotated frame is saved automatically in the `detections` folder.

Example output file:

```text
detections/person_detected_20260429_120500_123456.jpg
```

## Problems and Fixes

| Problem | Fix |
|---|---|
| Stream did not open | Checked that both laptops were on the same WiFi network |
| Wrong IP address | Used `ipconfig` on Laptop A to find the correct IPv4 address |
| Firewall blocked connection | Allowed Python through Windows Firewall |
| Webcam not opening | Closed other programs using the camera |
| YOLO model downloading slowly | Waited for `yolov8n.pt` to download during the first run |

## Proof Screenshots to Add

Add screenshots to the GitHub repository showing:

1. Flask server running on Laptop A
2. Browser stream or terminal showing stream active
3. YOLO detection window running on Laptop B
4. At least one detected object with bounding box
5. Saved person detection image in the `detections` folder, if bonus task is tested

## Short Evaluation

The system worked as a simple intelligent home monitoring pipeline. Laptop A streamed webcam frames over the local network using Flask. Laptop B received the stream and used YOLOv8 to detect objects in real time. The detection performance depended on network speed, lighting, camera quality, and laptop processing power. The system shows how AI can be added to an IoT video stream for smart monitoring.

## Conclusion

This lab demonstrates a real-time AI-enabled IoT video system. The most important parts are stable network connection, correct IP address, and enough processing power on the AI node. YOLO adds intelligence by identifying objects from the incoming camera stream. In practical use, this type of system can be used for smart home cameras, baby monitors, warehouse monitoring, and remote surveillance.
