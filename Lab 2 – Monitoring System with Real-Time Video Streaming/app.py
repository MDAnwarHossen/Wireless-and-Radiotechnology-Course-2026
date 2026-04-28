from flask import Flask, Response
import cv2
from datetime import datetime

app = Flask(__name__)

# Open default webcam
camera = cv2.VideoCapture(0)

if not camera.isOpened():
    raise RuntimeError("Could not open webcam. Make sure the webcam is connected and not used by another app.")

# Optional: set camera resolution
camera.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)


def generate_frames():
    """Capture webcam frames, encode them as JPEG, and stream them to the browser."""
    while True:
        success, frame = camera.read()
        if not success:
            break

        # Bonus: add timestamp on each frame
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        cv2.putText(
            frame,
            timestamp,
            (10, 30),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.8,
            (255, 255, 255),
            2,
            cv2.LINE_AA,
        )

        ret, buffer = cv2.imencode(".jpg", frame)
        if not ret:
            continue

        frame_bytes = buffer.tobytes()

        yield (
            b"--frame\r\n"
            b"Content-Type: image/jpeg\r\n\r\n" + frame_bytes + b"\r\n"
        )


@app.route("/")
def home():
    return """
    <html>
        <head>
            <title>Home Monitoring Stream</title>
        </head>
        <body style="font-family: Arial; text-align: center; background-color: #f4f4f4;">
            <h2>Live Camera Stream</h2>
            <p>Real-time IoT home monitoring video stream</p>
            <img src="/video_feed" width="640" style="border: 2px solid black;">
        </body>
    </html>
    """


@app.route("/video_feed")
def video_feed():
    return Response(
        generate_frames(),
        mimetype="multipart/x-mixed-replace; boundary=frame",
    )


if __name__ == "__main__":
    print("Starting Home Monitoring Stream...")
    print("Open this address from another laptop: http://SENDER_IP:5000")
    app.run(host="0.0.0.0", port=5000, debug=False)
