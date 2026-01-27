# BLE RSSI Analysis & Security Report

This repository documents the collection, analysis, and interpretation of Bluetooth Low Energy (BLE) RSSI data across multiple environments. It also highlights the technical limitations of RSSI-based distance estimation and discusses key security and privacy implications of BLE broadcasting.

---

## 1. Data Collection & Documentation

![Alt Text](screenshots/BLE%20Scanner.jpeg)

### Device Information Table Template

| Device Name   | MAC Address / ID        | RSSI (dBm) | Estimated Distance | Observed Behavior          |
|--------------|-------------------------|------------|--------------------|----------------------------|
| Smart Watch  | AA:BB:CC:11:22:33       | -45 dBm    | ~0.5 m             | Strong, stable signal      |
| Unknown      | DD:EE:FF:44:55:66       | -82 dBm    | ~10 m              | Fluctuating signal         |
| iBeacon      | 11:22:33:AA:BB:CC       | -60 dBm    | ~3 m               | Constant advertising       |


---

## 2. Technical Analysis

### RSSI vs. Estimated Distance

The relationship between RSSI and distance is **logarithmic**, not linear. Signal strength drops rapidly at close range and then gradually tapers off as distance increases.


### Environmental Factors

- **Transmission Power (Tx):**  
  BLE devices transmit at varying power levels. A beacon configured for low power (to conserve battery) may report weak RSSI values even at close range.

- **Physical Obstructions:**  
  Walls, concrete, metal, and even human bodies significantly attenuate BLE signals. Closing a door can reduce RSSI by **10–15 dBm**.

- **Environmental Noise:**  
  BLE operates in the crowded **2.4 GHz** band. Interference from Wi-Fi routers, microwave ovens, and nearby Bluetooth devices introduces RSSI jitter and instability.

---

## 3. Security and Privacy Considerations

BLE prioritizes convenience, but its broadcast-based design introduces several security and privacy risks.

### Device Tracking
Many BLE devices—especially low-cost or older IoT hardware—use **static MAC addresses**, allowing observers to track a device (and potentially its owner) across multiple locations.

### Identifier Exposure
Some devices broadcast:
- Human-readable names (e.g., *“John’s iPhone”*)
- Service UUIDs that reveal device type (e.g., heart rate monitors)

This information can leak personal or sensitive details without any active connection.

### Passive Scanning Risks
Unlike Wi-Fi, BLE does not require a handshake. Devices continuously advertise their presence, enabling a malicious actor to silently log thousands of devices in public spaces without detection.

---

## 4. Final Conclusions

Based on the collected data and analysis:

- **RSSI is highly effective for proximity detection**  
  (e.g., determining whether a device is *near* or *far*).

- **RSSI is unreliable for precise distance measurement**  
  (e.g., distinguishing between 2.5 m and 3.0 m) due to multi-path interference, reflections, and environmental variability.

RSSI should therefore be used as a **relative indicator**, not an absolute measurement tool, especially in indoor or crowded environments.

---

 