#include <Stepper.h>

const int stepsPerRevolution = 2038;

Stepper myStepper = Stepper(stepsPerRevolution, 8, 10, 9, 11); 
//Create a stepper object with its 4 pins connecting to D8, D10, D9, and D11 of Aduino Uno, respectivly

void setup() {
    //leave it blank
}

void loop() {
 while (true) {
  myStepper.setSpeed(15); //The speed of motor is set to 15 RPM
  myStepper.step(stepsPerRevolution); //Lowering the platform
  //myStepper.step(-stepsPerRevolution); //Raising the platform
  }
}
