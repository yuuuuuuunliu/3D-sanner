# Ultrasonic 3D Scanner

This guide outlines the development process of our ultrasonic 3D scanner. We will provide resources in this repository that can be used to reproduce the project, as well as data for evaluating the accuracy of the measurement results. The ultrasonic 3D scanner utilizes ultrasound ranging to scan real-world objects, capturing the coordinates of various points on their surfaces. By processing the collected data, the scanner generates a three-dimensional model of the object, enabling an accurate digital representation of the object's size and dimensions. This technology holds immense potential for various applications, including but not limited to artifact preservation, educational applications, and reverse engineering. Our project specifically focuses on constructing a low-cost 3D scanner, aiming to make this technology more accessible for everyday use. By providing an affordable solution, we aim to promote the widespread adoption of this technology in everyday life.

Access our project presentation through this link: https://docs.google.com/presentation/d/14-DhOLEjQ7N0TpDgxVi51gBwk0Xk7jdvzFTlWsp83JA/edit?usp=sharing

We hope you enjoy exploring this guide and find it helpful in creating your own 3D scanner.
 
## Table of Contents
* [Description](https://github.com/yuuuuuuunliu/3D-sanner#Description)
* [List of Components](https://github.com/yuuuuuuunliu/3D-sanner#List_of_Components)
* [Method](https://github.com/yuuuuuuunliu/3D-sanner#Method)
* [Construction](https://github.com/yuuuuuuunliu/3D-sanner#Construction)
* [Product Review](https://github.com/yuuuuuuunliu/3D-sanner#Product_Review)
* [Future Development](https://github.com/yuuuuuuunliu/3D-sanner#Future_Development)
* [Contributors](https://github.com/yuuuuuuunliu/3D-sanner#Contributors)
* <del>Description</del>
* <del>List of Components</del>
* <del>Method</del>
* <del>Construction</del>
* Product Review
* Future Development
* Contributors

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

We aim to have three spatial dimensions for each data point to determine their coordinates in space accurately. Since the trajectory of the object moving in front of the sensor is spiral-shaped, expressing the coordinates in cylindrical coordinates would be the most convenient way. The actual measurement results include two dimensions - time (t) and distance (d). By introducing the angular velocity (ω) of the rotating disc and the vertical velocity (v), we can represent the angle (θ) between the point's position along the radial axis and the initial radial axis as a function of time (t), as well as the distance (z) between the point's position and the initial plane as a function of time (t). Introducing the distance (r_max) from the sensor to the vertical axis of the cylinder allows us to calculate the distance (s) between the measurement point and the vertical axis of the cylinder. Hence, we can determine the cylindrical coordinates (s, θ, z) of each point on the object's surface in a coordinate system with the initial plane as the xy-plane and the vertical axis of the cylinder as the z-axis. The specific formulas for the calculations are as follows:

$$s = r_{max} - d$$

$$\theta = \omega * t$$

$$z = v * t$$

Once we have marked all the points on the object's surface in space, our goal is to construct the outer surface of the object using these points. While we can easily visualize the outer surface, computers have numerous possibilities for constructing planes based on the given points. Therefore, we need to specify the desired planes. The instruction we provide to the computer is to connect points with adjacent θ and z values, and to fill all the quadrilaterals bounded by the connecting lines. This process allows us to construct the outer surface of the object. 

For the specific MATLAB graphing code, please refer to the following location, where I generate data for simulation purposes:https://github.com/yuuuuuuunliu/3D-sanner/blob/main/graph.mlx

The expected outcome is shown below:

  ![Outer surface of a cylinder and a cone using simulated data](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Simulation.png)



## Construction

HC-SR04 has a range from 2cm to 4m. Experimental results have shown that the HC-SR04 distance sensor has a measurement standard deviation of less than 0.5mm. The difference between measured values and actual values is typically less than 2cm, with the majority of errors staying below 0.5cm. Therefore, we can consider the HC-SR04 to be a precise and accurate distance sensor. Additionally, due to its stable numeric uncertainty rather than percentage uncertainty, we can reduce errors by applying it to large objects. This improvement strategy will be further discussed in the future development section.

  ![A plot of the sensor's measurements against the actual length](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Calibration%20in%201D.png)


The distance sensor we utilize emits a conical wave with a raypath angle of 15 degrees. This angle allows the sensor to be sensitive to a wider area. However, in situations where high precision distance measurements are required, such high sensitivity can lead to unnecessary feedback. To mitigate this, we can place a rough absorbent block beneath the sensor. This block, with its rough surface, causes non-radial sound waves to undergo multiple reflections in a short period of time, dissipating a significant amount of energy and effectively absorbing unwanted reflected waves. 

  ![A picture of the absorbent block and a close-up look of its surface](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/actual%20picture%20of%20the%20absorbent%20block.png)

The figure below illustrates the results obtained when using the sensor to measure a stationary object (i.e., where the distance from the point to the origin, s, remains constant), and processing the data using MATLAB to generate a three-dimensional image in cylindrical coordinates. It is evident that the erroneous refracted points have been effectively eliminated through the use of the absorbent block.
 
  ![Comparison of plots before and after using the absorbent block](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Comparison%20for%20the%20absorbent%20block.png)
  
We use the device to scan the surface of a cylindrical object. Ideally, the results obtained after the rotation of the turntable should be similar to the results obtained when the turntable is stationary, as the object exhibits cylindrical symmetry around the z-axis.

## Product Review



## Future Development

## Contributors


