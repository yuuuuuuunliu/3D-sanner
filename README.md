# Ultrasonic 3D Scanner

This guide outlines the development process of our ultrasonic 3D scanner. We will provide resources in this repository that can be used to reproduce the project, as well as data for evaluating the accuracy of the measurement results. The ultrasonic 3D scanner utilizes ultrasound ranging to scan real-world objects, capturing the coordinates of various points on their surfaces. By processing the collected data, the scanner generates a three-dimensional model of the object, enabling an accurate digital representation of the object's size and dimensions. This technology holds immense potential for various applications, including but not limited to artifact preservation, educational applications, and reverse engineering. Our project specifically focuses on constructing a low-cost 3D scanner, aiming to make this technology more accessible for everyday use. By providing an affordable solution, we aim to promote the widespread adoption of this technology in everyday life.

Access our project presentation through this link: 

https://docs.google.com/presentation/d/14-DhOLEjQ7N0TpDgxVi51gBwk0Xk7jdvzFTlWsp83JA/edit?usp=sharing

We hope you enjoy exploring this guide and find it helpful in creating your own 3D scanner.
 
## Table of Contents
* [Description](https://github.com/yuuuuuuunliu/3D-sanner#Description)
* [List of Components](https://github.com/yuuuuuuunliu/3D-sanner#List_of_Components)
* [Method](https://github.com/yuuuuuuunliu/3D-sanner#Method)
* [Construction](https://github.com/yuuuuuuunliu/3D-sanner#Construction)
* [Product Review](https://github.com/yuuuuuuunliu/3D-sanner#Product_Review)
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

We aim to have three spatial dimensions for each data point to determine their coordinates in space accurately. Since the trajectory of the object moving in front of the sensor is spiral-shaped, expressing the coordinates in cylindrical coordinates would be the most convenient way. The actual measurement results include two dimensions - time (t) and distance (d). By introducing the angular velocity (ω) of the rotating disc and the vertical velocity (v), we can represent the angle (θ) between the point's position along the radial axis and the initial radial axis as a function of time (t), as well as the distance (z) between the point's position and the initial plane as a function of time (t). Introducing the distance (r_max) from the sensor to the vertical axis of the cylinder allows us to calculate the distance (s) between the measurement point and the vertical axis of the cylinder. Hence, we can determine the cylindrical coordinates (s, θ, z) of each point on the object's surface in a coordinate system with the initial plane as the xy-plane and the vertical axis of the cylinder as the z-axis. The specific formulas for the calculations are as follows:

$$s = r_{max} - d$$

$$\theta = \omega * t$$

$$z = v * t$$

Once we have marked all the points on the object's surface in space, our goal is to construct the outer surface of the object using these points. While we can easily visualize the outer surface, computers have numerous possibilities for constructing planes based on the given points. Therefore, we need to specify the desired planes. The instruction we provide to the computer is to connect points with adjacent θ and z values, and to fill all the quadrilaterals bounded by the connecting lines. This process allows us to construct the outer surface of the object. 

For the specific MATLAB graphing code, please refer to the following location, where I generate data for simulation purposes:https://github.com/yuuuuuuunliu/3D-sanner/blob/main/graph.mlx

The expected outcome is shown below:

  ![Outer surface of a cylinder and a cone using simulated data](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Simulation.png)

Before scanning the object, we build up a frame to hold all components. For most of the components, we used 3D Modeling to create and then print them out with 3D printers. All of STL. Files can find in the folder of [Frame](https://github.com/yuuuuuuunliu/3D-sanner/tree/main/Frame). Some components have different versions, we did lots of improvements for every component. 

The plate will hold the object we are going to scan. The main frame is going to fix the nut and hold the whole system. It can replace by box instead of 3D printing components, because large 3D printing components take a long time, which may take up to several days. A strew is connect with the plate and the strew gear. Before assemble them, the nut and connection should install first. From the top to the bottom of the strew, the sequence should be plate, nut, connection, and strew gear. The step motor should connect to the middle whole of the connection. Then, install step motor gear onto it and check the connection between step motor gear and the strew gear. The connection is free to rotate with the strew. The frame should limit this rotation and make sure it can move up and downward with the strew. Other parts work for fix the sensor, they are flexible to do adjustments due to your different use. 

Different printers may print out components with different uncertainty. Some adjustments may be needed especially for the gears. If the gears have spinning conditions, enlarging the teeth of gears for 1mm is a good choice. 


In order to scan the 3D information of an object, we rotate the object and make it move upward. The sensor is fixed and gets information when the system is start to work. In this way, we just need to collect the information on time and distance from the sensor to the object. The location can be calculated from the time and velocity of the step motor. The step motor rotates one lap in 4 seconds. The plate rotates 1 lap using 10 seconds. In each lap, the object will raise 2 mm with the average speed with the plate. 


## Construction

Before scanning the object, we build up a frame to hold all components. For most of the components, we used 3D Modeling to create and then print them out with 3D printers. All of STL. Files can find in the folder of [Frame](https://github.com/yuuuuuuunliu/3D-sanner/tree/main/Frame). Some components have different versions, we did lots of improvements for every component. 

The plate will hold the object we are going to scan. The main frame is going to fix the nut and hold the whole system. It can replace by box instead of 3D printing components, because large 3D printing components take a long time, which may take up to several days. A strew is connect with the plate and the strew gear. Before assemble them, the nut and connection should install first. From the top to the bottom of the strew, the sequence should be plate, nut, connection, and strew gear. The step motor should connect to the middle whole of the connection. Then, install step motor gear onto it and check the connection between step motor gear and the strew gear. The connection is free to rotate with the strew. The frame should limit this rotation and make sure it can move up and downward with the strew. Other parts work for fix the sensor, they are flexible to do adjustments due to your different use. 

Different printers may print out components with different uncertainty. Some adjustments may be needed especially for the gears. If the gears have spinning conditions, enlarging the teeth of gears for 1mm is a good choice. 

HC-SR04 has a range from 2cm to 4m. Experimental results have shown that the HC-SR04 distance sensor has a measurement standard deviation of less than 0.5mm. The difference between measured values and actual values is typically less than 2cm, with the majority of errors staying below 0.5cm. Therefore, we can consider the HC-SR04 to be a precise and accurate distance sensor. Additionally, due to its stable numeric uncertainty rather than percentage uncertainty, we can reduce errors by applying it to large objects. This improvement strategy will be further discussed in the future development section.

  ![A plot of the sensor's measurements against the actual length](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Calibration%20in%201D.png)


The distance sensor we utilize emits a conical wave with a raypath angle of 15 degrees. This angle allows the sensor to be sensitive to a wider area. However, in situations where high precision distance measurements are required, such high sensitivity can lead to unnecessary feedback. To mitigate this, we can place a rough absorbent block beneath the sensor. This block, with its rough surface, causes non-radial sound waves to undergo multiple reflections in a short period of time, dissipating a significant amount of energy and effectively absorbing unwanted reflected waves. 

  ![A picture of the absorbent block and a close-up look of its surface](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/actual%20picture%20of%20the%20absorbent%20block.png)

The figure below illustrates the results obtained when using the sensor to measure a stationary object (i.e., where the distance from the point to the origin, s, remains constant), and processing the data using MATLAB to generate a three-dimensional image in cylindrical coordinates. It is evident that the erroneous refracted points have been effectively eliminated through the use of the absorbent block.
 
  ![Comparison of plots before and after using the absorbent block](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Comparison%20for%20the%20absorbent%20block.png)
  
We use the device to scan the surface of a cylindrical object. Ideally, the results obtained after the rotation of the turntable should be similar to the results obtained when the turntable is stationary, as the object exhibits cylindrical symmetry around the z-axis. However, in reality, the results obtained after the rotation of the turntable exhibit significant fluctuations. By observing the raw data and examining the scanned image of the object's outer surface based on the measurement results, we notice that the fluctuations in the raw data appear to be periodic. This observation is further supported by the presence of a wavy surface in the 3D representation. Therefore, we have decided to use the "smoothdata" function in MATLAB to remove these fluctuations.

  ![Pictures that showcase the cylindrical object, the raw data of r over multiple trials, and a 3D graph generated based on the measurements](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/raw%20cylinder.png)

The code we used is as follows:

```
smoothdData = smoothdata(r, "movmean", 50)
```

In this code, "r" represents the data to be processed, "movmean" denotes the data processing method, and "50" indicates the window size. The provided function creates a moving window with a size of 50 data. This window calculates the average value of all 50 data it contains and treats it as the smoothed data. Then, the window shifts by one value and the process is repeated. The window moves along the data while continuously calculating the average value until all the data is smoothed. Plotting the graph using the smoothed data reveals that a significant amount of noise has been removed. The resulting image exhibits a relatively smooth surface, which is what we desired.

  ![A comparison of the final 3D graphs between using the smoothdata() function and not using it](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/smoothdata%20comparison.png)





## Product Review

### Scanning two stacked cylinders with different radius

The arrangement of the scanned objects is illustrated in the following diagram:

  ![The arrangement of two stacked cylinders that will be scanned for review](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Stacked%20cylinder.png)
 
The lower cylinder has a radius of approximately 6.5cm, while the upper cylinder has a radius of approximately 2.5cm. Both the raw data and smoothed data show a reduction in radius, which corresponds to our actual setup. 

  ![The plot showing the variation of distance r over trial for both raw data and smoothed data](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/r%20plot%20for%20two%20cylinder.png)

We then examine the processed 3D image. The image roughly depicts the outer contours of two cylinders with different radii. At the same time, we can approximately read the measured values of the two cylinder radii from the graph, which are approximately 3cm and 6cm. Comparing these values to the actual data, we find an error of approximately 0.5cm, which aligns with the expected deviation in the initial direct measurements of distance using the ultrasonic sensor. Therefore, we can conclude that the precision of our obtained results is close to the inherent precision limit of the HC-SR04 sensor. For the current setup, this is a satisfactory outcome. Indeed, it is noticeable that in the region where the two cylinders are joined, the graph does not exhibit sharp edges as we would expect in the real world. Instead, there is a curved and smooth transition between the surfaces of the cylinders. This result is attributed to the 15-degree raypath angle of the sound waves, as we discussed earlier, and the inclination of the platform. Possible solutions for this issue will be elaborated in detail in the future development section.


  ![The 3D surface graph generated by MATLAB as well as the distribution of measured data points in 3D space (top view)](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/3D%20graph%20of%20two%20cylinders.png)
  
However, the resulting image this time does not resemble a box in any way. Upon careful observation of the scanning process of the box and experimenting with different platform rotation speeds in Matlab, we have found that the failure in imaging the box is due to the instability of the platform rotation speed.



### Scanning a box

Then we proceed to scan the box as illustrated in the following image:

  ![The picture of the box we will scan in this section](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/Picture%20of%20the%20box.png)
  
However, the resulting image this time does not resemble a box in any way. Upon careful observation of the scanning process of the box and experimenting with different platform rotation speeds in Matlab, we have found that the failure in imaging the box is due to the instability of the platform rotation speed. When processing the data in MATLAB to generate the 3D image, it assumes an ideal motion model for the platform based on a constant vertical speed and angular speed. However, during the actual measurement process, we observed that the platform's rotation speed is not stable. The time required for a point on the surface of the object to complete a full 2π rotation varies in each revolution. As a result, MATLAB can only ensure that the points on the same revolution as the set angular speed are in the right phase. However, MATLAB requires at least two revolutions of points to generate one complete surface. This discrepancy leads to the final generated result being distorted and skewed. We will provide a detailed explanation of the proposed solutions for this issue in the future development section.

  ![The 3D scan of the box in both scatter plot and surface plot versions](https://github.com/yuuuuuuunliu/3D-sanner/blob/main/Figures/3D%20graph%20of%20the%20box.png)


## Future Development
We have already mentioned some of the issues and unexpected results encountered in the previous discussion. In order to address these problems, we plan to upgrade the project in the future. Additionally, we will conduct corresponding experiments to investigate the causes of the unexpected results. Specific future measures that can be undertaken are outlined as follows:

### Upgrade of the rotating platform

At the current stage, the rotating platform exhibits the following issues: Firstly, the rotating disc is not perfectly horizontal, causing a precession in the coordinate system in which the object is located as perceived by the distance sensor. Secondly, there are certain issues with the gear size, resulting in improper engagement. The gears that rotate synchronously with the rotating disc often experience slipping and jamming, leading to an unstable rotational speed. Lastly, the device is built on a cardboard box, which has low density. This causes the entire setup to shake under the influence of the stepper motor driving and the inertia of object rotation, significantly affecting the final scanning results. This shaking may also be a potential cause of the periodic noise observed in the raw data we discussed earlier，although further measurement and analysis are required to confirm this hypothesis.

### Upgrade of the ultrasonic distance sensor

As mentioned earlier, the HC-SR04 sensor emits ultrasonic waves in the form of a cone with a vertex angle of 15 degrees. This characteristic introduces certain measurement errors and inaccuracies in capturing sharp edges of objects. We aim to narrow down the scanning range by utilizing phased array technology. Inspired by the video shared (https://www.youtube.com/watch?v=Evao3XUUAOY), we came up with the idea of employing a phased array approach to achieve this goal.By strategically spacing multiple wave sources and adjusting their phases, we can control the interference pattern of the emitted waves. This allows us to constructively interfere the waves along the desired path, forming a stronger sound ray, while causing destructive interference in other directions to minimize their impact on the main beam. We can build our own multi-wave source distance sensor to achieve a more focused detection beam. By using basic electronic components, we can design a distance sensor that provides analog signals instead of the digital output of the HC-SR04 module. By processing and analyzing the analog signals, we can extract information about multiple reflections, allowing us to obtain insights into the internal structure of objects.

### Upgrade of smoothdata() method

In the previous experiments, I chose a window size of 50 based on multiple trial runs. This particular window size was found to strike a balance between data accuracy and precision while avoiding potential trial-specific outcomes. However, upon realizing that the noise we want to eliminate is periodic, measuring the period of the noise will help us determine a more appropriate window size. Therefore, in the future, we will attempt to measure the periodicity of the noise and explore the relationship between window size, periodicity of the noise, and the accuracy and precision of the final results by scanning objects with different shapes and symmetries.

### Research on periodic noise

Ideally, when scanning a cylindrical object with a base radius of R, the results should be consistent whether the turntable is rotating or stationary because both measurement methods essentially involve continuously measuring R. However, in reality, we have observed that when the turntable is stationary, the measurement error generated by the ultrasonic sensor is negligible. However, when the turntable starts rotating, significant periodic errors occur in the measurement results from the ultrasonic sensor, which can significantly impact the quality of the imaging. Therefore, we have developed some initial hypotheses regarding the origin of this periodic error: it stems from the rotation of the turntable. We aim to investigate whether the periodicity of the error changes with variations in the rotational speed of the turntable. Through this experiment, we will have the opportunity to confirm the source of the error and conduct further research to pinpoint the underlying causes of the noise.

## Contributorst

This project was undertaken as part of the PHYS 13CL course at UCSB.

We would like to extend our sincere appreciation to Professor Andrew Jayich and the teaching assistants, Robert Kwapisz and Eric Deck. Their unwavering support and guidance throughout these ten weeks have been invaluable to our project. We are also grateful to them for organizing enjoyable board game nights that helped alleviate our stress, and for feeding our restless souls with pizza and Fanta

Furthermore, we would like to express our gratitude to Katelyn Saxen, Katya Osipova, and Eric Zhu for generously sharing their experiences and providing valuable insights when we encountered challenges during our progress.

Special thanks go to Raffi Shirinian for his assistance in utilizing the 3D printer and for lending us his personal hot glue gun, which greatly facilitated our project.

We would also like to thank Max Kolevski for his assistance in procuring the stepper motor and driver from ILG, which were instrumental to the success of our project.

Lastly, we want to acknowledge and thank Reuben Beeler for his thought-provoking questions during the presentation. His inquiries inspired us to reevaluate our criteria for evaluating the scan results.
