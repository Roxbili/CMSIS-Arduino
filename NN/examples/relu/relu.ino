#include <Arduino.h>
#include <arm_nnfunctions.h> /* CMSIS-NN */

void setup() {
    Serial.begin(115200);
}

void loop() {
    q7_t in_vec[4] = { -1, 0, 1, 2 };
    Serial.print("Input vector: ");
    for (auto& num:in_vec) {
        Serial.print(num);
        Serial.print(' ');
    }
    Serial.println();

    arm_relu_q7(in_vec, 4);

    Serial.print("Output vector: ");
    for (auto& num:in_vec) {
        Serial.print(num);
        Serial.print(' ');
    }
    Serial.println();
}