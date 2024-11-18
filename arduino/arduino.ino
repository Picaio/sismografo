#include <Wire.h>
#include <MPU6050.h>

MPU6050 mpu;
bool running = true;  

void setup() {
 
  Serial.begin(9600);
  Wire.begin();
  
  
  mpu.initialize();
  
  
  if (mpu.testConnection()) {
    Serial.println("Conexión exitosa con MPU6050.");
  } else {
    Serial.println("Error al conectar con MPU6050.");
    while (1); 
  }
}

void loop() {
  
  if (running) {
    int16_t ax, ay, az, gx, gy, gz;
    
    
    mpu.getAcceleration(&ax, &ay, &az);
    mpu.getRotation(&gx, &gy, &gz);
    
    
    Serial.print("AX: ");
    Serial.print(ax);
    Serial.print(",AY: ");
    Serial.print(ay);
    Serial.print(",AZ: ");
    Serial.print(az);
    Serial.print(",GX: ");
    Serial.print(gx);
    Serial.print(",GY: ");
    Serial.print(gy);
    Serial.print(",GZ: ");
    Serial.println(gz);
  }
  
  
  if (Serial.available() > 0) {
    char command = Serial.read(); 
    if (command == 'P') {
      running = false;  
    } else if (command == 'R') {
      running = true;   
    }
  }
  
  delay(50); 
}