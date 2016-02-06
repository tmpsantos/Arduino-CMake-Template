#include <Arduino.h>

void loop() {
    Serial.println("LED on");
    digitalWrite(13, HIGH);   // Set the LED on
    delay(3000);              // Wait for three seconds

    Serial.println("LED off");
    digitalWrite(13, LOW);    // Set the LED off
    delay(3000);              // Wait for three seconds
}

int main(void)
{
    // Mandatory init
    init();

    Serial.begin(115200);

    // Pin 13 has an LED connected on most Arduino boards
    pinMode(13, OUTPUT);

    while (true)
        loop();

    return 0;
}
