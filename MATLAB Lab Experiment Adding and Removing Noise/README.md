# Noise Addition and Removal from a Signal using MATLAB

## Objective

The objective of this lab is to simulate the process of adding and removing noise from a signal using MATLAB. A sinusoidal signal is generated, Gaussian white noise is added, and a low-pass Butterworth filter is used to reduce the noise.

## Experiment Overview

In this experiment, a clean sine wave is created using a sampling frequency of 1000 Hz and a signal frequency of 5 Hz. Random Gaussian white noise is then added to the signal. After that, a low-pass Butterworth filter is applied to remove high-frequency noise components.

## MATLAB Parameters Used

```matlab
fs = 1000;              % Sampling frequency in Hz
t = 0:1/fs:1;           % Time vector
f_signal = 5;           % Signal frequency in Hz
amplitude = 1;          % Signal amplitude
noise_level = 0.5;      % Noise level
cutoff_frequency = 10;  % Low-pass filter cutoff frequency in Hz
filter_order = 4;       % Butterworth filter order
```

## Method

### 1. Generate Original Signal

A sinusoidal signal was generated using the formula:

```matlab
original_signal = amplitude * sin(2*pi*f_signal*t);
```

This produced a clean 5 Hz sine wave.

### 2. Add Gaussian White Noise

Gaussian white noise was generated using `randn()` and added to the original signal:

```matlab
noise = noise_level * randn(size(t));
noisy_signal = original_signal + noise;
```

This made the signal irregular and harder to observe clearly.

### 3. Apply Low-pass Butterworth Filter

A low-pass Butterworth filter was used to reduce the high-frequency noise:

```matlab
normalized_cutoff = cutoff_frequency / (fs/2);
[b, a] = butter(filter_order, normalized_cutoff, 'low');
filtered_signal = filtfilt(b, a, noisy_signal);
```

The cutoff frequency was set to 10 Hz. Since the original signal frequency was 5 Hz, the filter allowed the main signal to pass while reducing higher-frequency noise.

## Results

The MATLAB program generates three plots:

1. Original signal and noisy signal
2. Original signal and filtered signal
3. Original, noisy, and filtered signals together

The noisy signal showed random fluctuations around the original sine wave. After filtering, the signal became smoother and closer to the original signal.

## Observations

The added Gaussian white noise distorted the original sinusoidal signal. The low-pass filter reduced the high-frequency noise and made the signal easier to recognize. The filtered signal followed the shape of the original sine wave, although it was not perfectly identical.

## Evaluation

The experiment shows that a low-pass filter is useful when the useful signal has a low frequency and the noise contains high-frequency components. The cutoff frequency is important. If the cutoff frequency is too low, part of the useful signal may be removed. If it is too high, too much noise may remain.

In this experiment, a 10 Hz cutoff frequency worked well because the original signal frequency was 5 Hz. The filtered signal was smoother than the noisy signal and closer to the original signal.

## Experimentation

Different parameters can be tested:

- Increasing `noise_level` makes the noisy signal more distorted.
- Decreasing `noise_level` makes the noisy signal closer to the original signal.
- Increasing `cutoff_frequency` allows more noise to pass through the filter.
- Decreasing `cutoff_frequency` removes more noise but may also distort the useful signal.
- Increasing `f_signal` may require increasing the cutoff frequency.

## Files Included

```text
noise_filtering_signal_processing.m
README.md
```

## GitHub Submission

Upload both files to a GitHub repository:

```text
noise_filtering_signal_processing.m
README.md
```

The MATLAB file contains the simulation code, and the README file contains the short lab report, results, observations, and evaluation.
