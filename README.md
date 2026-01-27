# Cellular Network Measurement Experiment

## Objective

The objective of this experiment is to observe and analyze how cellular network signal parameters change under different environmental conditions and network technologies, and how these changes affect data speed, network stability, and connectivity reliability.

The experiment focuses on the following parameters:

- Signal Strength (RSRP, RSSI)
- Signal Quality (RSRQ, SINR/SNR)
- Cell and network information
- Network technologies (4G LTE and 5G NSA)

---

## Test Setup

### Device and Network
- Device: 5G-capable smartphone
- Operating System: iOS
- Carrier: DNA (Finland)
- Network Technologies Observed:
  - 5G NSA (Band n78)
  - 4G LTE (Band 3)

### Measurement Method
Measurements were collected using the device’s built-in cellular diagnostic dashboard (Field Test mode / network monitoring application).  
Screenshots were taken at each test location to record radio parameters such as signal strength and signal quality.

---

## Test Locations and Conditions

Measurements were performed under the following conditions:

1. Indoors – near a window  
2. Indoors – center of the building  
3. Outdoors – near the building  
4. Switching between LTE and 5G NSA where available  

The device remained stationary during measurements to ensure consistency.

---

## Collected Measurement Data

### Sample Measurement Results

#### 5G NSA (Band n78)

| Parameter | Value |
|---------|------|
| Band | n78 |
| RSRP | -82 dBm |
| RSRQ | -11 dB |
| SINR (SNR) | 26 dB |

#### LTE (Band 3)

| Parameter | Value |
|---------|------|
| Band | 3 |
| RSRP | -83 dBm |
| RSRQ | -15 dB |
| SINR (SNR) | 20 dB |

All screenshots used for measurements are stored in the `screenshots/` directory.

---

## Analysis

### Signal Strength

- RSRP values between **-80 dBm and -85 dBm** indicate a good signal level.
- Both LTE and 5G show similar signal strength, suggesting a relatively short distance to the base station.

### Signal Quality

- 5G SINR (26 dB) is higher than LTE SINR (20 dB), indicating lower interference and better channel conditions.
- LTE RSRQ (-15 dB) is worse than 5G RSRQ (-11 dB), suggesting higher congestion or interference on the LTE network.

### Impact on Performance

- Higher SINR allows higher modulation and coding schemes, leading to higher data speeds.
- Better RSRQ improves connection stability and reduces packet retransmissions.
- 5G provides higher potential throughput, especially near windows or outdoors.

---

## Environmental Factors

The following factors influence cellular signal behavior:

- **Distance from the cell tower:** Greater distance reduces signal strength.
- **Physical obstructions:** Walls, floors, and building materials attenuate signals, especially higher-frequency 5G bands.
- **Indoor vs outdoor environment:** Outdoor locations generally provide better signal quality.
- **Network load:** Increased user activity negatively affects signal quality, particularly RSRQ.

---

## Observations

- Signal strength and quality improve near windows compared to the center of a building.
- 5G provides better signal quality than LTE at the same location.
- Indoor environments reduce signal quality more noticeably for 5G than LTE.
- LTE remains more stable indoors, while 5G performs best near windows or outdoors.

---

## Conclusions

- Signal strength and signal quality directly influence data speed and connection reliability.
- SINR is the most important indicator of achievable data performance.
- 5G NSA offers higher performance under good signal conditions, while LTE provides more consistent indoor coverage.
- Environmental factors such as building materials and user congestion significantly impact cellular network performance.

---