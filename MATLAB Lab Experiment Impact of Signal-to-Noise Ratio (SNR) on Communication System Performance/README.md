# ASK Modulation and Demodulation with Different SNR Values

## Objective

The objective of this experiment is to investigate how different Signal-to-Noise Ratio (SNR) values affect the demodulation performance of a communication system using MATLAB.

This lab shows how noise changes the received signal and how lower SNR values make it more difficult to recover the original binary message correctly.

## Theory

In digital communication, information can be transmitted using modulation. In this experiment, Amplitude Shift Keying (ASK) is used.

In ASK modulation, the carrier signal is transmitted when the binary message bit is `1`, and the signal amplitude becomes zero or very small when the binary message bit is `0`.

Noise is added to the modulated signal to simulate real communication channel conditions. The SNR value shows the strength of the signal compared with the noise.

- High SNR means the signal is stronger than the noise.
- Low SNR means the noise is strong and affects the signal more.
- Negative SNR means the noise power is higher than the signal power.

## MATLAB Parameters Used

```matlab
fs = 1000;              % Sampling frequency in Hz
t = 0:1/fs:1;           % Time vector
f_c = 50;               % Carrier frequency in Hz
SNR_values = [10 5 0 -5];
```

## Experiment Steps

1. Generate a random binary message signal using `randi([0 1])`.
2. Generate a carrier signal using a cosine wave.
3. Modulate the binary message signal using ASK modulation.
4. Add Gaussian white noise to the modulated signal at different SNR values.
5. Demodulate the received signal by multiplying it with the carrier signal.
6. Apply a low-pass Butterworth filter to remove high-frequency components.
7. Use a threshold decision to recover the binary data.
8. Compare the recovered bits with the original bits and calculate Bit Error Rate (BER).
9. Plot the original modulated signal, noisy received signal, filtered signal, and final demodulated signal.

## Results

The MATLAB script tests the system using four SNR values:

| SNR Value | Expected Result |
|---|---|
| 10 dB | Signal is clearer, noise effect is small, and demodulation performance is good. |
| 5 dB | Some noise is visible, but the message can still be recovered reasonably well. |
| 0 dB | Noise becomes strong, and more demodulation errors may appear. |
| -5 dB | Noise is stronger than the signal, so the recovered signal becomes poor and BER increases. |

The command window prints the number of bit errors and the Bit Error Rate for each SNR value.

Example output format:

```text
SNR = 10 dB | Bit Errors = ... | BER = ...
SNR = 5 dB  | Bit Errors = ... | BER = ...
SNR = 0 dB  | Bit Errors = ... | BER = ...
SNR = -5 dB | Bit Errors = ... | BER = ...
```

Because the binary message and noise are randomly generated, the exact BER values may be different each time the script is executed.

## Observations

When the SNR is high, the received signal is close to the original modulated signal. The demodulated output is more accurate, and the bit error rate is low.

When the SNR decreases, the noise level increases. The received waveform becomes distorted, and the demodulator has more difficulty deciding whether the received bit is `0` or `1`.

At 0 dB, the signal and noise powers are approximately equal, so the demodulated signal contains more errors.

At -5 dB, the noise power is higher than the signal power. This causes poor demodulation performance and a higher BER.

## Evaluation

This experiment shows that SNR has a direct impact on communication system performance. Better SNR gives cleaner received signals and more reliable demodulation. Lower SNR values reduce the quality of the received signal and increase the chance of bit errors.

The low-pass filter helps remove high-frequency noise after coherent demodulation. However, filtering cannot completely recover the original signal if the noise level is too high. Therefore, communication systems must be designed with suitable SNR, filtering, modulation method, and decision threshold.

## Files Included

- `ask_snr_demodulation.m` — MATLAB code for ASK modulation, noise addition, demodulation, filtering, BER calculation, and plotting.
- `README_ASK_SNR_Lab_Report.md` — Short lab report for GitHub submission.

## How to Run

1. Open MATLAB.
2. Place `ask_snr_demodulation.m` in your working folder.
3. Run the script.
4. Check the generated figures and command window BER results.
5. Upload the `.m` file and README file to GitHub.

## Conclusion

The experiment confirms that higher SNR improves demodulation accuracy, while lower SNR causes more noise distortion and bit errors. At high SNR values, the original binary message can be recovered more clearly. At low or negative SNR values, the system performance becomes weaker because the demodulator cannot reliably separate the signal from noise.
