# Sineware Protopocket

The Protopocket is an open source, Raspberry Pi Compute Module 5 based reference development platform for mobile mainline Linux. It's a chonky phone you can build yourself!

![Protopocket on a table](./models/phone-1.png)

## Why?
While there are many great phones that can run Linux today, the Protopocket fills a niche of being designed specifically for development purposes, and being fully OSHW that any individual can build themselves. While it won't be great as a daily driver:
- Builds on a well support, predictable platform (Raspberry Pi)
- Easy to debug (easy serial access) and flash (rpiboot)
- Modular (Swap in different hardware to test as needed)

## Hardware
The hardware as defined in this repository is "rolling", the specifications, configs, devicetrees, etc will evolve as the projects develops.

Current hardware:
- 3D printable case
- Raspberry Pi Compute Module 5
- Waveshare Mini Base Board (B) CM5
- Waveshare 6.25inch DSI Capacitive Touch Display
- Adafruit LSM6DSOX + LIS3MDL (ID 4517) Accelerometer/Gyroscope

Todo:
- LTE/5G Modem
- USB-PD Battery Charger, Fuel Gauge
- Ambient Light Sensor, Proximity Sensor
- Camera(s) (USB or CSI) 

3D Printed Enclosure: https://www.printables.com/model/1266920-waveshare-625inch-dsi-display-case-for-raspberry-p


## Assembly
Instructions coming soon!

## postmarketOS
This repository contains the packages needed to build postmarketOS device support for the Protopocket.

There is a included script `protopocket.sh`, which can be used to insert symlinks from the device packages here into your local pmbootstrap pmports directory.

First, setup the symlinks with:
```bash
./protopocket.sh install
```


When you need to run `pmbootstrap pull`, instead run `./protopocket.sh pmapull`, which will automatically remove the symlinks before running pull, and add them back again.

To remove the symlinks run: `./protopocket.sh remove`.

### Installing
First compile the linux kernel:
```bash
pmbootstrap build --force linux-sineware-protopocket
```
then run `pmbootstrap init` and select `sineware` and `protopocket` as the vendor and device.

Then, install to the SDCard or via rpiboot/usbboot (mounted) using:
```bash
pmbootstrap install --sdcard=/dev/sdX
```

> You should probably `pmbootstrap zap` anytime you rebuild the kernel or device package.