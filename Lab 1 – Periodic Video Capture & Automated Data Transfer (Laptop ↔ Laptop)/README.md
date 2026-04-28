# Automated Large-Data IoT Video Pipeline

## Objective

The objective of this lab is to build an automated large-data IoT pipeline on Windows. The system records short video clips, saves them locally, sends them to another laptop over the same WiFi network, waits for confirmation from the receiver, and deletes the local file only after a successful transfer.

The pipeline follows this sequence:

**Record → Save → Send → Confirm → Delete**

## System Scenario

This lab simulates a remote monitoring system. One laptop acts as an edge device that records video clips, while another laptop acts as a receiver/server that stores the received videos.

## Group Information

- Sender laptop: Laptop A
- Receiver laptop: Laptop B
- Receiver IP address: `REPLACE_WITH_RECEIVER_IP`
- Network used: Same WiFi network

## Folder Structure

### Sender Laptop

```text
iot_video_lab/
│── recorder.py
│── sender.py
│── videos/
```

### Receiver Laptop

```text
iot_video_lab/
│── receiver.py
│── received_videos/
```

## Software Requirements

Python must be installed on both laptops.

Check Python version:

```bash
python --version
```

Install OpenCV on the sender laptop:

```bash
pip install opencv-python
```

## Files Included

### `recorder.py`

This program runs on the sender laptop. It opens the webcam, records a 10-second video, saves it in the `videos` folder, waits 2 minutes, and repeats automatically.

### `sender.py`

This program runs on the sender laptop. It continuously checks the `videos` folder, sends any `.mp4` file to the receiver laptop, waits for `OK` confirmation, and deletes the local video only after successful confirmation.

Before running, replace this line:

```python
HOST = "RECEIVER_IP"
```

with the actual IPv4 address of the receiver laptop, for example:

```python
HOST = "192.168.1.25"
```

### `receiver.py`

This program runs on the receiver laptop. It waits for incoming video files, receives the filename and file data, saves the file in the `received_videos` folder, and sends back `OK` after receiving the file.

## How to Run the System

### Step 1: Start Receiver on Laptop B

```bash
python receiver.py
```

The receiver should show:

```text
Receiver is waiting for files...
```

### Step 2: Start Recorder on Laptop A

Open a new Command Prompt window and run:

```bash
python recorder.py
```

The recorder should start recording videos automatically.

### Step 3: Start Sender on Laptop A

Open another Command Prompt window and run:

```bash
python sender.py
```

The sender will watch the `videos` folder and transfer recorded videos automatically.

## Expected Output

### Sender Laptop

The sender laptop should:

- record a new video every 2 minutes
- save the video in the `videos` folder
- transfer the video automatically to the receiver
- wait for confirmation from the receiver
- delete the local video only after receiving `OK`

Example sender output:

```text
Sender started. Watching video folder...
Transfer confirmed: video_20260429_120000.mp4
File size: 1.25 MB
Transfer time: 2.18 seconds
Deleted local file: video_20260429_120000.mp4
```

### Receiver Laptop

The receiver laptop should:

- accept the connection from the sender
- receive the video filename
- save the file in the `received_videos` folder
- send confirmation back to the sender

Example receiver output:

```text
Receiver is waiting for files...
Connected by ('192.168.1.10', 54231)
Received: video_20260429_120000.mp4
```

## Results and Evaluation

The automated system worked when both laptops were connected to the same WiFi network and the receiver program was started first. The recorder successfully created video files in the `videos` folder. The sender detected the saved videos, transferred them to the receiver laptop, and waited for confirmation.

The receiver stored the transferred videos inside the `received_videos` folder. The sender deleted each local video only after receiving the `OK` confirmation from the receiver. This confirms that the system follows the required pipeline correctly.

## Problems and Fixes

Possible issues and solutions:

| Problem | Possible Fix |
|---|---|
| Sender cannot connect to receiver | Check receiver IP address and make sure both laptops are on the same WiFi network |
| Connection is blocked | Allow Python through Windows Firewall |
| Webcam does not open | Check webcam permission and close other apps using the camera |
| File is not transferred | Start `receiver.py` before `sender.py` |
| Local file is not deleted | Check if receiver sends `OK` confirmation |



## Final Conclusion

This lab demonstrated how a large-data IoT pipeline works in practice. The sender laptop acted as an edge device that recorded and buffered video data locally. The receiver laptop acted as a storage server. The confirmation step was important because it prevented the sender from deleting a video before the receiver successfully stored it. This type of workflow is similar to smart surveillance cameras, industrial monitoring systems, and edge AI data collection systems.

## Learning Outcome

After completing this lab, I understood how large files can be collected, transferred, confirmed, and cleaned up in an IoT system. The main concept is that local buffering and confirmation are important for reliability, especially when working with large files such as videos.
