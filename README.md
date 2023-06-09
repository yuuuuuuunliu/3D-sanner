# Ultrasonic 3D Scanner

This guide outlines the development process of our ultrasonic 3D scanner. We will provide resources in this repository that can be used to reproduce the project, as well as data for evaluating the accuracy of the measurement results. The ultrasonic 3D scanner utilizes ultrasound ranging to scan real-world objects, capturing the coordinates of various points on their surfaces. By processing the collected data, the scanner generates a three-dimensional model of the object, enabling an accurate digital representation of the object's size and dimensions. This technology holds immense potential for various applications, including but not limited to artifact preservation, educational applications, and reverse engineering. Our project specifically focuses on constructing a low-cost 3D scanner, aiming to make this technology more accessible for everyday use. By providing an affordable solution, we aim to promote the widespread adoption of this technology in everyday life.

Access our project presentation through this link: https://docs.google.com/presentation/d/14-DhOLEjQ7N0TpDgxVi51gBwk0Xk7jdvzFTlWsp83JA/edit?usp=sharing

We hope you enjoy exploring this guide and find it helpful in creating your own 3D scanner.
 
## Table of Contents
* [Description](https://github.com/yuuuuuuunliu/3D-sanner#Description)
* [List of Components](https://github.com/yuuuuuuunliu/3D-sanner#List_of_Components)
* [Method](https://github.com/yuuuuuuunliu/3D-sanner#Method)
* [Construction](https://github.com/yuuuuuuunliu/3D-sanner#Construction)
* [Measurement and Analysis](https://github.com/yuuuuuuunliu/3D-sanner#Measurement_and_Analysis)
* [Future Development](https://github.com/yuuuuuuunliu/3D-sanner#Future_Development)
* [Contributors](https://github.com/yuuuuuuunliu/3D-sanner#Contributors)

## Description
The ultrasonic 3D scanning device consists of two main components: a fixed ultrasonic distance sensor and a rotatable lifting platform. The ultrasonic distance sensor utilizes the reflection of sound waves to determine the distances between its position and various points on an object. The lifting platform is powered by a stepper motor and is driven by gears and screws to rotate and elevate the object. As the platform rotates, the object passes through the ultrasonic distance sensor in a spiral path, and the coordinates of the object's points are recorded.

Subsequently, we process the collected data using MATLAB and extract the outer contour of the scanned object to generate a three-dimensional model. This is achieved through an interactive program that allows us to visualize the reconstructed 3D model based on the acquired data.

## List of Components
  * Ultrasonic Distance Sensor - HC-SR04
  * Arduino Nano 3.x
  * 4 Phase ULN2003 Stepper Motor Driver PCB
  * 28BYJ-48 - 5V Stepper Motor
  * Arduino Uno Mini LE - MCU 8-Bit Embedded Evaluation Board
  * Screw and nut
  * PCB Board
  * Jumper wires
  * 3D-printed parts

## Method
We use HC-SR04 as the ultrasound distance sensor component.
  
  ![A picture of the distance sensor we used](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/HC-SR04.jpg)
  
The HC-SR04 module consists of four pins. The Vcc pin and GND pin are connected to the 5V and GND pins of the Arduino Nano, respectively. These pins serve as both power supply and logic level control (high/low). The Trig pin is an input pin of the HC-SR04 and is connected to the D3 pin of the Arduino Nano. The Echo pin is an output pin of the HC-SR04 and is connected to the D2 pin of the Arduino Nano. In fact, the Trig and Echo pins can be connected to any two digital I/O pins of the Arduino Nano. The HC-SR04 module consists of two piezoelectric transducers, one acting as a transmitter (marked with "T") and the other as a receiver (marked with "R"). 

To initiate a distance measurement with the HC-SR04 module, a voltage pulse is sent to the Trig pin. This voltage pulse is transformed into a sine wave by a local oscillator, and the resulting sine-shaped voltage signal is sent to the transmitter. The transmitter converts this voltage signal into a sound signal, emitting an 8-cycle sonic burst in the forward direction. Simultaneously, the receiver is set to a high state, and a timer starts counting. The emitted sonic burst travels through space and reflects when it encounters the nearest object. Upon receiving the reflected wave, the receiver changes to a low state, indicating the detection of the reflected signal, and the timer stops counting. 

The duration for which the receiver stays in a high state is equal to the time it takes for the sound to travel in space. Therefore, the distance between the sensor and the object can be calculated using the formula: d = (v * t) / 2, where t represents the measured time and v represents the speed of sound. The speed of sound is typically considered to be around 340 m/s, but it can vary depending on the medium and temperature conditions.

## Construction

## Measurement and Analysis

## Future Development

## Contributors

The distance sensor we utilize emits a conical wave with a raypath angle of 15 degrees. This angle allows the sensor to be sensitive to a wider area. However, in situations where high precision distance measurements are required, such high sensitivity can lead to unnecessary feedback. To mitigate this, we can place a rough absorbent block beneath the sensor. This block, with its rough surface, causes non-radial sound waves to undergo multiple reflections in a short period of time, dissipating a significant amount of energy and effectively absorbing unwanted reflected waves. 

https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/actual%20picture%20of%20the%20absorbing%20block.png

The figure below illustrates the results obtained when using the sensor to measure a stationary object (i.e., where the distance from the point to the origin, s, remains constant), and processing the data using MATLAB to generate a three-dimensional image in cylindrical coordinates. It is evident that the erroneous refracted points have been effectively eliminated through the use of the absorbent block.



## Getting Started


```
code blocks for commands
```

## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```

## Authors

Contributors names and contact info

ex. Dominique Pizzie  
ex. [@DomPizzie](https://twitter.com/dompizzie)

## Version History

* 0.2
    * Various bug fixes and optimizations
    * See [commit change]() or See [release history]()
* 0.1
    * Initial Release

## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details

## Acknowledgments

Inspiration, code snippets, etc.
* [awesome-readme](https://github.com/matiassingers/awesome-readme)
* [PurpleBooth](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
* [dbader](https://github.com/dbader/readme-template)
* [zenorocha](https://gist.github.com/zenorocha/4526327)
* [fvcproductions](https://gist.github.com/fvcproductions/1bfc2d4aecb01a834b46)
