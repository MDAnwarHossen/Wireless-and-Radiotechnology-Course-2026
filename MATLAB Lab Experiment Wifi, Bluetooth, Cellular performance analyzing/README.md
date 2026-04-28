# Wireless Communication Performance Simulation

## Objective

The objective of this assignment is to analyze the communication performance of WiFi, Bluetooth, and Cellular systems over different distances using MATLAB. The simulation calculates and visualizes received power, SINR, and channel capacity for each technology.

## Technologies Simulated

| Technology | Frequency | Bandwidth | Transmit Power | Distance Range |
|---|---:|---:|---:|---:|
| WiFi | 2.4 GHz | 22 MHz | 100 mW | 1 m to 100 m |
| Bluetooth | 2.45 GHz | 2 MHz | 10 mW | 0.5 m to 10 m |
| Cellular | 850 MHz | 200 kHz | 40 W | 100 m to 5000 m |

## Equations Used

### Friis Transmission Equation

The received power is calculated using:

```text
Pr = (Pt * Gt * Gr * lambda^2) / (4*pi*R)^2
```

Where:

- `Pr` = received power
- `Pt` = transmit power
- `Gt` = transmitter antenna gain
- `Gr` = receiver antenna gain
- `lambda` = wavelength
- `R` = distance between antennas

### SINR

```text
SINR = Pr / Pn
```

Where `Pn` is the noise power.

### Channel Capacity

```text
C = BW * log2(1 + SINR)
```

Where `BW` is the bandwidth of the communication system.

## MATLAB Files

This repository contains:

```text
communication_assignment.m
README.md
```

## How to Run

1. Open MATLAB.
2. Open `communication_assignment.m`.
3. Click **Run**.
4. MATLAB will generate two figures:
   - Individual performance plots for WiFi, Bluetooth, and Cellular
   - Comparative plots for all three technologies

## Results and Observations

### Received Power

Received power decreases as distance increases. This is because the Friis equation shows that received power is inversely proportional to the square of distance. When distance becomes larger, the received signal becomes weaker.

WiFi and Bluetooth operate at close frequency values, but Bluetooth has lower transmit power. Therefore, Bluetooth is suitable for short-range communication only. Cellular uses much higher transmit power and lower frequency, so it can cover much longer distances.

### SINR

SINR also decreases with distance because received power decreases while the noise power remains constant. At shorter distances, the received signal is stronger compared with noise, so SINR is higher. At longer distances, the signal becomes weaker and noise has a larger effect.

### Channel Capacity

Channel capacity decreases as SINR decreases. WiFi has the highest bandwidth, so it can provide higher capacity at short distances. Bluetooth has lower capacity because its bandwidth and transmit power are lower. Cellular has a smaller bandwidth, but it is designed for long-distance communication using high transmit power.

## Comparative Analysis

WiFi is suitable for medium-range and high-data-rate communication, such as home or campus networks. Bluetooth is suitable for very short-range communication, such as connecting sensors, headphones, or small IoT devices. Cellular communication is suitable for long-range coverage, but its channel capacity depends strongly on bandwidth and signal quality.

Overall, the simulation shows that increasing distance reduces received power, SINR, and channel capacity. A system with higher transmit power, suitable frequency, and larger bandwidth can achieve better performance, but this also depends on practical limits such as power consumption, coverage requirements, and network design.

## Conclusion

This assignment demonstrates how distance affects wireless communication performance. The results show that signal strength decreases with distance, which also reduces SINR and channel capacity. WiFi provides high capacity over shorter distances, Bluetooth works best for short-range low-power communication, and Cellular provides long-distance coverage using higher transmit power.
