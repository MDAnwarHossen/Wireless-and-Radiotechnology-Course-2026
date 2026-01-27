# Wi‑Fi Technical Analysis & Optimization

This repository documents a technical analysis of the current Wi‑Fi environment, identifies performance bottlenecks, and proposes practical optimization steps based on real diagnostic data.

---

## 1. Technical Parameter Exploration

Based on the provided screenshots, the following represents the current state of the Wi‑Fi network.

### Device & Gateway Details

| Parameter | Value | Technical Significance |
|---------|------|-----------------------|
| **SSID** | TP-Link_F210 | Name of the local wireless network |
| **BSSID** | b0:95:75:9e:f2:10 | Physical MAC address of the access point |
| **Vendor** | TP-Link | Hardware manufacturer |
| **IP Address** | 192.168.0.107 | Device’s local address on the subnet |
| **Default Gateway** | 192.168.0.1 | Router address and internet exit point |

---

### Radio & Signal Parameters

| Parameter | Value | Observation |
|---------|------|------------|
| **Standard** | 802.11n (Wi‑Fi 4) | Legacy standard; limits throughput vs Wi‑Fi 6 |
| **Channel (2.4 GHz)** | 2 (2417 MHz) | Non‑standard; overlaps with channels 1 & 6 |
| **Channel (5 GHz)** | 36 & 44 | Standard 5 GHz channels with low interference |
| **Signal (2.4 GHz)** | −68 dBm | Good; stable for general connectivity |
| **Signal (5 GHz)** | −79 dBm | Fair/Poor; high attenuation through walls |

---

## 2. Analysis & Troubleshooting

The collected data reveals several clear opportunities for optimization.

### Identified Issues

**1. Channel Overlap (Congestion)**  
The 2.4 GHz band is operating on Channel 2. In Wi‑Fi design, only channels **1, 6, and 11** are non‑overlapping. Channel 2 causes *Adjacent Channel Interference*, which degrades throughput, increases retransmissions, and reduces stability.

**2. Legacy Standard Limitation**  
The network is operating on **802.11n**. Although the theoretical maximum is 150 Mbps, the observed link speed (~54 Mbps) indicates environmental noise, interference, or distance‑related degradation.

**3. Frequency Attenuation**  
The 5 GHz signal strength (−79 dBm) is significantly weaker than the 2.4 GHz signal (−68 dBm). This confirms a well‑known physical limitation: higher frequencies suffer greater attenuation through walls and obstacles.

---

## 3. Practical Solutions & Recommendations

To improve network performance and reliability, the following actions are recommended:

### 1. Switch to Non‑Overlapping Channels
- Log into the router admin panel at **192.168.0.1**
- Change the **2.4 GHz channel** from *Auto* or *2* to **1, 6, or 11**
- This will significantly reduce interference from neighboring networks

### 2. Force 5 GHz for High‑Speed Use
- When physically close to the router, manually connect to the **5 GHz SSID**
- Despite lower signal strength, the **80 MHz bandwidth** offers far higher data capacity than 2.4 GHz

### 3. Router Repositioning
- A −79 dBm reading on 5 GHz suggests the router is behind walls or enclosed (e.g., cabinet placement)
- Move the router to an **open, elevated position** to improve signal‑to‑noise ratio and coverage

### 4. Security Check
- Current security uses **WPA2 (AES)**, which is still secure
- If supported by the router and client devices, upgrading to **WPA3** is recommended for stronger protection against modern brute‑force and handshake attacks

---

## Conclusion

This analysis demonstrates that the network’s limitations are not caused by bandwidth availability alone, but by channel selection, physical placement, and legacy standards. Implementing the recommended changes will yield measurable improvements in stability, speed, and security.

