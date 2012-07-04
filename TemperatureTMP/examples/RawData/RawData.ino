#include "TemperatureTMP.h"

TemperatureTMP Temperature;
int adcValue;

void setup()
{
  Serial.begin(115200);
  Temperature.begin(A0);
}

void loop()
{
  adcValue = Temperature.getTemperatureRaw();
  Serial.print("ADC Raw: ");
  Serial.println(adcValue);
  delay(500);                                     //make it readable
}
