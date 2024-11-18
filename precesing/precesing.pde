import processing.serial.*;
import java.text.SimpleDateFormat; // Para formato de hora
import java.util.Date;             // Para obtener la hora actual

Serial myPort;              // Objeto para el puerto serial
float[] axData, ayData, azData; // Arrays para almacenar los datos
int bufferSize = 200;       // Cantidad de datos para graficar
float ax = 0, ay = 0, az = 0; // Variables para las lecturas actuales
float threshold = 12.0;      // Umbral para detección de eventos sísmicos
String lastEventTime = "";  // Hora del último evento
float lastMagnitude = 0;    // Magnitud del último evento

boolean showEventBox = false;  // Indica si el cuadro negro debe mostrarse
int eventBoxDuration = 2000;   // Duración del cuadro negro en milisegundos
int eventBoxStartTime = 0;     // Tiempo de inicio del cuadro negro

ArrayList<String> eventLog = new ArrayList<String>(); // Lista para almacenar los eventos

void setup() {
  size(1200, 800);         // Tamaño de la ventana
  println("Available ports:");
  println(Serial.list());
  
  if (Serial.list().length > 0) {
    myPort = new Serial(this, Serial.list()[0], 9600); // Seleccionar el primer puerto
    myPort.bufferUntil('\n'); // Leer hasta nueva línea
  } else {
    println("No serial ports available!");
    exit(); // Salir del programa si no hay puertos disponibles
  }

  axData = new float[bufferSize];
  ayData = new float[bufferSize];
  azData = new float[bufferSize];
}

void draw() {
  background(30); // Fondo oscuro
  drawGrid(); // Dibujar la cuadrícula
  textAlign(LEFT, CENTER);
  fill(255);
  textSize(14);
  text("MPU6050 Real-Time Plot (Sismógrafo)", 50, 20);

  // Mostrar los valores actuales de ax, ay, az
  text("Ax: " + nf(ax, 1, 2), 50, 50);
  text("Ay: " + nf(ay, 1, 2), 50, 70);
  text("Az: " + nf(az, 1, 2), 50, 90);

  // Dibujar datos
  strokeWeight(2);
  drawData(axData, color(255, 0, 0)); // Rojo para ax
  drawData(ayData, color(0, 255, 0)); // Verde para ay
  drawData(azData, color(0, 0, 255)); // Azul para az

  // Mostrar información del último evento sísmico
  drawEventInfo();

  // Mostrar cuadro negro si se detectó un evento
  if (showEventBox) {
    drawEventBox();
  }

  // Dibujar la caja de log
  drawEventLog();
}

void drawGrid() {
  stroke(70); // Color de la cuadrícula
  strokeWeight(1);
  
  // Líneas horizontales
  for (int i = 0; i <= 10; i++) {
    float y = map(i, 0, 10, height - 200, 100); // Espaciado uniforme
    line(50, y, width - 250, y);
    fill(120);
    textAlign(CENTER, CENTER);
    text(nf(map(i, 0, 10, -10, 10), 1, 1), 45, y); // Magnitudes en el eje Y
  }

  // Líneas verticales
  for (int i = 0; i <= 10; i++) {
    float x = map(i, 0, 10, 50, width - 250);
    line(x, height - 200, x, 100);
  }
}

void drawData(float[] data, int col) {
  stroke(col);
  noFill();
  beginShape();
  for (int i = 0; i < data.length; i++) {
    float x = map(i, 0, data.length, 50, width - 300);
    float y = map(data[i], -10, 10, height - 200, 100); // Ajustar rango según valores
    vertex(x, y);
  }
  endShape();
}

void drawEventInfo() {
  textAlign(LEFT, CENTER);
  fill(50);
  rect(0, height - 100, width - 250, 100); // Cuadro en la parte inferior
  fill(255);
  textSize(16);
  text("Último Evento Sísmico", 100, height - 70);
  if (lastEventTime.equals("")) {
    text("Sin eventos detectados", 100, height - 40);
  } else {
    text("Hora: " + lastEventTime, 100, height - 50);
    text("Magnitud: " + nf(lastMagnitude, 1, 2), 100, height - 30);
  }
}

void drawEventBox() {
  fill(0, 200);
  rect(width / 2 - 150, height / 2 - 50, 300, 100); // Cuadro negro en el centro
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Evento Sísmico Detectado", width / 2, height / 2 - 20);
  text("Hora: " + lastEventTime, width / 2, height / 2);
  text("Magnitud: " + nf(lastMagnitude, 1, 2), width / 2, height / 2 + 20);

  // Ocultar el cuadro después del tiempo definido
  if (millis() - eventBoxStartTime > eventBoxDuration) {
    showEventBox = false;
  }
}

void drawEventLog() {
  fill(50);
  rect(width - 250, 0, 250, height); // Fondo de la caja de log
  fill(255);
  textSize(16);
  textAlign(LEFT, TOP);
  text("Log de Eventos", width - 240, 10);

  // Mostrar los eventos del log
  textSize(12);
  int logStartY = 40;
  for (int i = 0; i < eventLog.size(); i++) {
    text(eventLog.get(i), width - 240, logStartY + i * 20);
  }
}

void serialEvent(Serial myPort) {
  try {
    String inData = trim(myPort.readStringUntil('\n'));
    String[] values = split(inData, ',');
     if (values.length == 6) {
      ax = float(values[0].substring(4))/2000.0;
      ay = float(values[1].substring(4))/2000.0;
      az = float(values[2].substring(4))/2000.0;


      // Actualizar arrays de datos
      updateData(axData, ax);
      updateData(ayData, ay);
      updateData(azData, az);

      // Detectar eventos sísmicos
      detectEvent();
    }
  } catch (Exception e) {
    println("Error parsing data: " + e.getMessage());
  }
}

void updateData(float[] data, float newValue) {
  for (int i = 0; i < data.length-1; i++) {
    data[i] = data[i+1]; // Mover datos hacia la izquierda
  }
  data[data.length-1] = newValue; // Agregar el nuevo dato
}

void detectEvent() {
  // Calcular la magnitud total como la raíz cuadrada de la suma de cuadrados
  float magnitude = sqrt(ax * ax + ay * ay + az * az);

  if (magnitude > threshold) {
    println("Evento detectado: Magnitud = " + magnitude);

    // Registrar el evento
    lastMagnitude = magnitude;
    lastEventTime = getCurrentTime();

    // Activar cuadro negro
    showEventBox = true;
    eventBoxStartTime = millis();

    // Agregar el evento al log
    String logEntry = lastEventTime + " - Magnitud: " + nf(lastMagnitude, 1, 2);
    eventLog.add(logEntry);
  }
}

String getCurrentTime() {
  SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
  return sdf.format(new Date());
}
