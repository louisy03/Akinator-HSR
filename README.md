# 🎮 Akinator de Honkai: Star Rail (Flask & Prolog)

Este proyecto implementa una versión del famoso juego Akinator (el genio adivinador) utilizando un **Sistema Experto** basado en el lenguaje de lógica **Prolog**, integrado con una interfaz web dinámica construida con **Python** y **Flask**.

El objetivo es adivinar un personaje del juego *Honkai: Star Rail* haciendo una serie de preguntas priorizadas.

---

## 🛠️ Requisitos del Sistema

Para ejecutar este proyecto, necesitas tener instalados tanto Python como el motor de Prolog.

### 1. Motor de Inferencia (SWI-Prolog)

El motor de Prolog debe estar instalado y el ejecutable (`swipl` o `swipl.exe`) debe estar en la variable de entorno **PATH** de tu sistema.

* **Instalación:** Descarga e instala [SWI-Prolog](https://www.swi-prolog.org/download/stable).

### 2. Python 3.x

---

## 🚀 Configuración e Instalación

Sigue estos pasos para poner en marcha el proyecto:

### 1. Estructura del Proyecto

Asegúrate de que tus archivos estén organizados así:

    honkai-akinator/
    ├── app.py
    ├── star_rail.pl
    ├── requirements.txt
    ├── venv/
    └── static/               
        └── css/              
            └── style.css     
    └── templates/
        ├── juego_prolog.html
        └── resultado.html  

### 2. Entorno Virtual (Recomendado)

# Crear entorno

    python -m venv venv

# Activar (Windows)

    .\venv\Scripts\activate

# Activar (macOS/Linux)

    source venv/bin/activate

### 2. Instalar Dependencias de Python
Instala las librerías necesarias (Flask y pyswip):

    pip install -r requirements.txt

(El archivo requirements.txt contiene: `Flask` y `pyswip`)

### Ejecución del Proyecto
Ejecuta la aplicación Flask desde el directorio raíz:

    python app.py

Abre tu navegador y navega a la dirección que se muestra en la terminal (usualmente http://127.0.0.1:5000/).

