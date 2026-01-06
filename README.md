# Piezoelectric Respiration Monitoring System (MATLAB)

![MATLAB](https://img.shields.io/badge/MATLAB-R2023b-blue)
![Status](https://img.shields.io/badge/status-complete-brightgreen)

## Overview
This project implements a respiration monitoring system using a piezoelectric
sensor and a temperature sensor. MATLAB was used for signal processing,
visualization, and respiration rate extraction.

## Data
The dataset includes raw and processed sensor measurements from piezoelectric
and temperature sensors recorded during controlled breathing.

## Tools
- MATLAB
- Arduino
- Piezoelectric sensor
- Temperature sensor

## Methods
The MATLAB analysis pipeline includes:
1. Baseline calibration of piezoelectric and temperature sensor signals
2. Signal filtering to reduce noise and motion artifacts
3. Peak detection for identification of respiratory cycles
4. Respiration rate calculation based on detected signal peaks

## Results
[![Respiration Plot](Sound%20%26%20Temp%20vs%20time.png)](Sound%20%26%20Temp%20vs%20time.png)

[![Respiration Plot 2](Sound%20and%20TEMP%202.png)](Sound%20and%20TEMP%202.png)

[![Results Plot](Results%202.png)](Results%202.pn)

## Hardware Prototype

### Wearable Configuration
[![Wearable Prototype](wearable_on_wrist.jpg)](wearable_on_wrist.jpg)

### Circuit Implementation
[![Circuit Breadboard](circuit_breadboard.jpg)](circuit_breadboard.jpg)


