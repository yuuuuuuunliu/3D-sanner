#include <Stepper.h>

const int stepsPerRevolution = 2038;

Stepper myStepper = Stepper(stepsPerRevolution, 8, 10, 9, 11);

void setup() {
    //leave it blank
}

void loop() {
 while (true) {
  myStepper.setSpeed(15);
  myStepper.step(stepsPerRevolution); //Lowering the platform
  //myStepper.step(-stepsPerRevolution); //Raising the platform
  }
}