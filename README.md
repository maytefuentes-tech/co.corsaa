# SIG Centro Odontológico Corsa - Sistema de Gestión de Agenda

**Curso:** ICN292 - Sistemas de Información para la Gestión  
**Semestre:** 2025/02  
**Universidad Técnica Federico Santa María** **Profesor:** Eloy Alvarado Narváez

---

## 1. Descripción del Proyecto

Este proyecto consiste en el desarrollo de un **Sistema de Información para la Gestión (SIG)** diseñado a medida para el **Centro Odontológico Corsa**. La solución busca digitalizar el proceso crítico de agendamiento y confirmación de citas, el cual se realizaba anteriormente de manera manual en cuadernos físicos.

El sistema aborda la problemática de la **alta tasa de inasistencia (15%)** y la falta de visibilidad de la disponibilidad horaria. Reemplaza los registros en papel por una base de datos relacional local que asegura la integridad de la información del paciente.

**Sus principales capacidades son:**
* **Gestión de Pacientes:** Base de datos maestra única para evitar la duplicidad de registros y pérdida de historial de contacto.
* **Agenda Digital Inteligente:** Control de disponibilidad en tiempo real que impide el agendamiento de horas duplicadas (tope de horario).
* **Auditoría de Confirmaciones:** Módulo de registro (Log) que permite trazar qué recordatorios fueron enviados, simulando la lógica de negocio para una futura integración con WhatsApp.
* **Dashboard Diario:** Visualización inmediata de la agenda del día para el Dr. Huerta y el equipo de auxiliares.

## 2. Tecnologías Utilizadas

* **Lenguaje de Programación:** Python 3.x
* **Base de Datos:** SQLite3 (Base de datos relacional serverless, ideal para implementación local ligera).
* **Interfaz de Usuario:** Interfaz de Línea de Comandos (CLI) / Consola interactiva.
* **Modelado de Datos:** SQL Estándar (DDL/DML).
* **Modelado de Procesos:** Bizagi Modeler (BPMN).

## 3. Estructura del Repositorio

El código fuente entregado está organizado de la siguiente manera:

* **`main.py`**: Archivo principal de ejecución. Contiene la lógica del negocio, la conexión a la base de datos SQLite y el menú interactivo para el usuario.
* **`corsa_schema.sql`**: Script SQL de inicialización. Incluye la estructura de las tablas (`pacientes`, `citas`, `log_recordatorios`) y la inserción de datos de prueba (semilla).
* **`corsa_db.sqlite`**: (Archivo generado automáticamente) Es la base de datos física que se crea al ejecutar el programa por primera vez.
* **`README.md`**: Documentación técnica y manual de uso del proyecto.

## 4. Guía de Instalación y Configuración

Siga estos pasos para desplegar el sistema en cualquier computador (Windows, Mac o Linux). A diferencia de otros sistemas, **no requiere instalar un servidor de base de datos externo** (como MySQL), ya que utiliza SQLite integrado.

### Requisitos Previos:
* **Python:** Versión 3.8 o superior.

### Paso 1: Descarga del Proyecto
Descargue los archivos `main.py` y `corsa_schema.sql` y guárdelos en una misma carpeta en su equipo.

### Paso 2: Ejecución de la Aplicación
1.  Abra una terminal (CMD, PowerShell o Terminal).
2.  Navegue hasta la carpeta donde guardó los archivos.
3.  Ejecute el siguiente comando:

```bash
python main.py
