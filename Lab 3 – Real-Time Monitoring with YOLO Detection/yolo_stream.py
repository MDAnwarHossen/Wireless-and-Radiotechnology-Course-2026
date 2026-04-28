import cv2
from ultralytics import YOLO
from datetime import datetime
import os

# Replace this IP address with Laptop A IPv4 address.
STREAM_URL = "http://192.168.1.20:5000/video_feed"

# Optional bonus settings
SAVE_PERSON_FRAMES = True
SAVE_FOLDER = "detections"
os.makedirs(SAVE_FOLDER, exist_ok=True)

model = YOLO("yolov8n.pt")
cap = cv2.VideoCapture(STREAM_URL)

if not cap.isOpened():
    print("Error: Could not open stream.")
    exit()

print("Stream opened. Running YOLO detection...")
print("Press q to stop.")

while True:
    ret, frame = cap.read()
    if not ret:
        print("Error: Could not read frame.")
        break

    results = model(frame)
    annotated_frame = results[0].plot()

    detected_names = []
    person_detected = False

    for box in results[0].boxes:
        class_id = int(box.cls[0])
        class_name = model.names[class_id]
        detected_names.append(class_name)
        if class_name == "person":
            person_detected = True

    if detected_names:
        print("Detected:", ", ".join(sorted(set(detected_names))))

    # Bonus task: save frame when a person is detected
    if SAVE_PERSON_FRAMES and person_detected:
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
        save_path = os.path.join(SAVE_FOLDER, f"person_detected_{timestamp}.jpg")
        cv2.imwrite(save_path, annotated_frame)
        print(f"Saved person detection frame: {save_path}")

    cv2.imshow("YOLO Home Monitoring", annotated_frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
