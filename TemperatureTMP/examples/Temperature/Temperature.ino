#include <TemperatureTMP.h>

TemperatureTMP Temperature;
float temperature;
float adc;

void setup()
{
  Serial.begin(115200);
  Temperature.begin(A0);
}

void loop()
{
  temperature = Temperature.getTemperatureCelcius();
  Serial.print("Temperature: ");
  Serial.println(temperature,1);
  delay(500);                                     //make it readable
}
