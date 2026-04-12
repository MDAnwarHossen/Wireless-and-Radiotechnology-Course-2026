# RF System Block Analysis — Nordic nRF52840 BLE SoC

**Course:** Wireless and Radiotechnology Course 2026  
**Assignment:** RF Block Diagram — Internal Structure of an RF Device  

---

## Device Information

| Field | Details |
|---|---|
| **Device** | Nordic Semiconductor nRF52840 |
| **Type** | Bluetooth 5 / 802.15.4 Multiprotocol SoC |
| **Frequency** | 2.4 GHz ISM band (2.402–2.480 GHz) |
| **Datasheet** | [nRF52840 Product Specification — Nordic Docs](https://docs.nordicsemi.com/bundle/ps_nrf52840/page/keyfeatures_html5.html) |
| **Protocols** | BLE 5.3, Thread, Zigbee, 802.15.4, ANT, proprietary 2.4 GHz |
| **Package** | aQFN73 · 7×7 mm |

---

## RF System Block Diagram

See `rf_block_diagram.svg` in this repository for the full visual diagram.

The signal chain flows **top → bottom** for the transmit path and **bottom → top** for the receive path. All blocks from the MCU down to the on-chip balun are **integrated inside the nRF52840 SoC**. The LC matching network and antenna are **external, PCB-level** components.


---

## RF Block Descriptions

### 1 — Information Source / MCU

**Block:** ARM Cortex-M4F processor running at 64 MHz with 1 MB flash and 256 kB RAM.

The MCU is the origin of all data to be transmitted and the final destination of all received data. It runs the application firmware and the Nordic SoftDevice (BLE/802.15.4 protocol stack), which formats raw data into protocol-compliant packets and passes them to the RADIO peripheral via EasyDMA — direct memory transfers that offload the CPU and reduce latency. On the receive side, the MCU retrieves decoded packets, checks for errors using the hardware CRC result, and processes application-layer payloads.

---

### 2 — RF Transceiver (Tx/Rx Functionality)

**Block:** Integrated 2.4 GHz RADIO peripheral with EasyDMA, packet assembler/disassembler, and automatic CRC.

The RADIO peripheral is the core of the wireless subsystem. It controls the full transmit and receive sequence including channel selection (2 MHz spacing across 2402–2480 MHz), packet assembly, preamble and address matching, and CRC checking — all with minimal CPU intervention via EasyDMA. It also contains an RSSI (Received Signal Strength Indicator) measurement unit, which reports signal level during reception, and a device address match unit used for BLE address whitelisting. The RADIO peripheral interfaces the digital domain (MCU side) and the analog RF domain (PA/LNA side).

---

### 3 — Modulation / Demodulation

**Block:** Part of the 2.4 GHz radio peripheral — digital baseband processing.

For BLE (1 Mbps and 2 Mbps modes), the modulation scheme is **GFSK** (Gaussian Frequency Shift Keying): binary data symbols shift the carrier frequency up or down by ±250 kHz (at 1 Mbps), with a Gaussian filter applied to smooth transitions and reduce spectral splatter. For IEEE 802.15.4 (Thread/Zigbee, 250 kbps), the scheme is **OQPSK** (Offset Quadrature Phase Shift Keying), which encodes data as phase shifts rather than frequency shifts. For the Long Range (125 kbps coded PHY) BLE mode, forward error correction is applied on top of GFSK, improving sensitivity by approximately 12 dB at the cost of throughput. Demodulation is the reverse: the received analog signal is converted to digital, filtered, and symbols are extracted to recover the original bit stream.

---

### 4 — Power Amplifier (PA)

**Block:** Integrated PA within the SoC, programmable output power from −20 dBm to +8 dBm in 4 dB steps.

The PA amplifies the low-level RF signal from the RADIO peripheral to the transmit power required for the desired communication range. Higher output power (+8 dBm) extends range but increases current draw (~15 mA Tx), while lower power settings (down to −20 dBm) reduce current and are used in proximity applications such as indoor ranging. The PA output is a differential signal that feeds directly into the integrated TX/RX switch and balun. Because the PA is on-chip, its impedance is optimized for the integrated balun, simplifying external PCB design.

---

### 5 — Low Noise Amplifier (LNA)

**Block:** Integrated LNA within the SoC; achieves −95 dBm receive sensitivity at 1 Mbps BLE and −103 dBm at 125 kbps coded PHY.

The LNA is the first active stage in the receive path. It amplifies the weak incoming RF signal — which may be as small as tens of microvolts — while adding as little noise as possible, since any noise introduced here will degrade the signal-to-noise ratio (SNR) for all subsequent processing stages. The nRF52840's LNA input connects through the on-chip balun and matching network directly to the antenna port. Its integration on-chip (along with the PA and RF switch) means the signal path is extremely short, minimizing parasitic losses.

---

### 6 — RF Filtering / Matching Network

**Block (on-chip):** Integrated balun with harmonic rejection filter.  
**Block (PCB):** External LC matching network — typically 2–4 passive components.

The **on-chip balun** performs two key functions: (1) it converts the differential output of the PA (or the differential input of the LNA) to a single-ended 50 Ω signal, and (2) it provides built-in filtering that suppresses harmonic content — particularly the 2nd and 3rd harmonics that would otherwise violate radio frequency regulations (FCC, CE RED). The **external LC matching network** on the PCB fine-tunes impedance transformation between the SoC's 50 Ω output and the specific impedance of the antenna used in the final design. Nordic's reference designs specify a Pi-network (shunt capacitor → series inductor → shunt capacitor) consisting of components in the 1–15 nH / 1–10 pF range, chosen based on PCB material and antenna geometry.

---

### 7 — Antenna Interface

**Block:** Single-ended 50 Ω RF port (ANT pin on the nRF52840); external antenna element.

The antenna converts the electrical RF signal into electromagnetic waves and vice versa. For the nRF52840, the most common antenna implementations are: (1) a **PCB trace antenna** — an inverted-F antenna (IFA) or meander antenna etched directly on the PCB, requiring a cleared ground keep-out area and specific PCB dielectric properties; (2) a **chip antenna** — a surface-mount ceramic element typically 2–5 mm in size; (3) an **external whip/coaxial antenna** via a U.FL/I-PEX connector for extended range. Nordic provides optimized reference layouts and antenna placement guidelines in the nRF52840 Hardware Design Guide (PAN 103) to achieve maximum radiation efficiency.

---

### 8 — Power Supply for RF Section

**Block:** On-chip DC-DC buck converter (DCDC) + LDO linear regulator; external input 1.7–3.6 V (VDD).

The nRF52840 includes an integrated DC-DC buck converter that efficiently steps down the supply voltage for the digital and analog subsystems, significantly reducing current draw compared to a pure LDO approach. The RF analog section (PA, LNA, oscillator, PLL) is powered through an internal LDO that provides a clean, stable supply voltage, isolated from digital switching noise on the main VDD rail. In transmit mode at +8 dBm, the SoC draws approximately 15 mA from a 3 V supply; in receive mode, approximately 5.3 mA; in sleep (System OFF), less than 0.4 µA. The supply voltage range of 1.7–3.6 V covers single-cell Li-ion batteries (3.0–4.2 V via PMIC) and CR2032 coin cells (2.5–3.0 V) directly.

---

## Signal Flow Summary

### Transmit path (Tx):
```
Application data → MCU (data formatting, protocol stack) 
  → RADIO peripheral (modulation: GFSK/OQPSK, packet assembly, CRC) 
  → PA (amplification to configured Tx power) 
  → TX/RX switch (routes to PA output) 
  → On-chip balun (differential → single-ended, harmonic filtering) 
  → LC matching network (50 Ω impedance match) 
  → Antenna → 2.4 GHz air interface
```

### Receive path (Rx):
```
2.4 GHz air interface → Antenna 
  → LC matching network (50 Ω impedance match) 
  → On-chip balun (single-ended → differential, filtering) 
  → TX/RX switch (routes to LNA input) 
  → LNA (low-noise amplification) 
  → RADIO peripheral (demodulation, packet reassembly, CRC check, RSSI measurement) 
  → MCU (application data processing)
```

---

## Key RF Performance Specifications

| Parameter | Value |
|---|---|
| Frequency range | 2.402–2.480 GHz |
| Rx sensitivity (BLE 1 Mbps) | −95 dBm |
| Rx sensitivity (BLE coded 125 kbps) | −103 dBm |
| Max Tx output power | +8 dBm |
| Min Tx output power | −20 dBm |
| Tx current (+8 dBm) | ~15 mA |
| Rx current | ~5.3 mA |
| Supported modulations | GFSK (BLE), OQPSK (802.15.4) |
| Supported data rates | 125 kbps, 500 kbps, 1 Mbps, 2 Mbps |
| Link budget (typical) | up to 105 dBm |

---

## References

- [nRF52840 Product Specification v1.7 — Nordic Semiconductor](https://docs.nordicsemi.com/bundle/ps_nrf52840/page/keyfeatures_html5.html)
- [nRF52840 Product Page — nordicsemi.com](https://www.nordicsemi.com/Products/nRF52840)
- [nRF52840 Hardware Design Guide (PAN 103)](https://infocenter.nordicsemi.com/topic/ug_nrf52840_dk/UG/dk/intro.html)
- [RADIO Peripheral Documentation — Nordic Infocenter](https://infocenter.nordicsemi.com/topic/ps_nrf52840/radio.html)

---

*Prepared for: Wireless and Radiotechnology Course 2026*
