# Short Report — DSP Assignments (A1–A3)

## 1) Difference between time domain and frequency domain

The time domain represents how a signal’s amplitude varies with time and is useful for observing waveform shape and timing behavior.  
The frequency domain represents the spectral content of a signal, showing which frequencies are present and their strengths.  
Using the FFT, a signal can be transformed from the time domain to the frequency domain to reveal its frequency components.

---

## 2) Why filtering helps in RF receivers

Filtering helps isolate the desired signal while removing unwanted frequency components such as noise and interference.  
It improves signal quality and prevents overlapping signals from affecting reception.  
In RF receivers, filters are essential for channel selection and noise suppression.

---

## 3) What modulation achieves in an RF system

Modulation shifts a low-frequency baseband signal to a higher carrier frequency suitable for transmission.  
This enables efficient antenna radiation, spectrum sharing, and long-distance communication.  
Without modulation, baseband signals cannot be effectively transmitted over RF channels.

---

## 4) From A2: which filter was easiest to design and why

The low-pass filter (LPF) was the easiest to design.  
It requires only a single cutoff frequency and clearly separates the lowest-frequency component (500 Hz) from the others.  
LPFs are simpler and more intuitive than band-pass or band-stop filters.

---

## 5) From A3: where new frequency components appear after modulation

After modulation by multiplication, new frequency components appear at the sum and difference of the carrier and message frequencies.    
This demonstrates frequency translation caused by modulation.
