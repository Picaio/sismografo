# 🌍📡 Sismógrafo con Arduino, MPU6050 y Processing

¡Bienvenido al repositorio del **Sismógrafo Básico**! 🚀 Este proyecto combina **Arduino**, el sensor **MPU6050** y **Processing** para medir y visualizar movimientos sísmicos simulados en tiempo real. 🌐✨

---

## 📝 Descripción del Proyecto

Este proyecto permite detectar y analizar movimientos utilizando:
- **MPU6050**: Sensor de aceleración y giroscopio.
- **Arduino**: Procesa y transmite los datos.
- **Processing**: Visualiza la información de forma interactiva.

El sistema simula un sismógrafo que captura aceleraciones en los ejes X, Y y Z, mostrando gráficos en tiempo real. 📊📈

---

## 🌟 Características

- 🚀 **Captura de datos en tiempo real**: Detecta movimientos en los ejes X, Y y Z.
- 📊 **Visualización interactiva**: Representación gráfica dinámica en Processing.
- 🛠️ **Fácil implementación**: Código modular y bien documentado.

---

## ⚙️ Hardware Necesario

1. 🟩 **Arduino Uno/Nano** (u otro compatible).
2. 📟 **Sensor MPU6050**.
3. 🔌 **Cables de conexión**.
4. 🖥️ **PC con Processing y Arduino IDE instalados**.

---

## 📂 Estructura del Repositorio

```plaintext
📂 Sismografo-MPU6050
├── 📁 Arduino
│   ├── Sismografo.ino        # Código para Arduino
├── 📁 Processing
│   ├── Sismografo.pde        # Sketch de Processing
├── 📄 README.md              # Documentación del proyecto
```
--- 

## 🚀 Configuración e Instalación

### 1️⃣ Configuración de Hardware
1. Conecta el **MPU6050** al Arduino:
   - VCC → 5V
   - GND → GND
   - SCL → A5 (o pin SCL según tu modelo de Arduino)
   - SDA → A4 (o pin SDA según tu modelo de Arduino)
   
2. Asegúrate de que las conexiones estén firmes y correctas. 🔧

### 2️⃣ Configuración de Software
1. Descarga e instala el [Arduino IDE](https://www.arduino.cc/en/software).
2. Instala la librería **Wire** (incluida por defecto) y **MPU6050**:
   - Ve a `Sketch > Incluir Librería > Administrar Bibliotecas`.
   - Busca e instala **MPU6050**.
3. Descarga e instala [Processing](https://processing.org/download).

### 3️⃣ Carga del Código
1. Sube el sketch `Sismografo.ino` al Arduino desde el Arduino IDE. 🚀
2. Abre el sketch `Sismografo.pde` en Processing y ejecuta el programa.

---

## 🌐 Funcionamiento

1. El **MPU6050** detecta aceleraciones en los ejes X, Y y Z.
2. **Arduino** procesa y envía los datos al PC vía Serial.
3. **Processing** recibe los datos y genera gráficos interactivos en tiempo real. 📈

---

## 🛠️ Personalización

- **Sensibilidad del sensor**: Puedes ajustar la escala de sensibilidad en el código del Arduino (`MPU6050_setScale()`).
- **Frecuencia de muestreo**: Modifica los intervalos de lectura según tus necesidades.
- **Visualización en Processing**: Personaliza los gráficos y colores según tus preferencias.

---

## 📸 Ejemplo de Visualización

🎥 *Gráfica en tiempo real de los ejes X, Y y Z:*

![Ejemplo de Visualización](https://via.placeholder.com/600x300.png)

---

## 🤝 Contribuciones

¡Las contribuciones son bienvenidas! 💡 Si encuentras errores, tienes ideas para mejorar o deseas colaborar, no dudes en abrir un `Issue` o enviar un `Pull Request`. 🛠️

---

## 📜 Licencia

Este proyecto está bajo la Licencia MIT. Puedes usarlo libremente para fines educativos o personales. 🌟

---

¡Gracias por tu interés en este proyecto! Si te gusta, no olvides darle una ⭐ en GitHub. 🙌

