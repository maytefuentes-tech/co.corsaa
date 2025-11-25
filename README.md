SIG Centro Odontológico Corsa - Sistema de Gestión de Agenda
1. Descripción del Proyecto
Este proyecto consiste en el desarrollo e implementación de un Sistema de Información para la Gestión (SIG) diseñado a medida para el Centro Odontológico Corsa. La solución es una plataforma de escritorio que centraliza las operaciones críticas de agendamiento y gestión de pacientes, permitiendo la digitalización de procesos que anteriormente se realizaban de forma manual.

El sistema aborda y soluciona la problemática de la gestión fragmentada en cuadernos físicos y la alta tasa de inasistencia de pacientes.

Sus principales capacidades son:

Gestión de Agenda Digital: Visualización, ingreso y cancelación de citas médicas en una base de datos centralizada, reemplazando el papel.

Automatización de Recordatorios: Bot integrado de WhatsApp que revisa la agenda para el día siguiente y envía mensajes de confirmación automáticamente a los pacientes.

Registro de Pacientes: Módulo dedicado para el alta de nuevos pacientes con validación de datos (RUT, contacto, historial).

Seguridad y Control: Acceso mediante credenciales de base de datos y separación de lógica de negocio.

2. Tecnologías Utilizadas
Lenguaje de Programación: Python 3.x

Interfaz Gráfica (GUI): PyQt5 (Qt Designer / XML)

Base de Datos: MySQL

Conector de Base de Datos: PyMySQL

API de Mensajería: CallMeBot (WhatsApp API Gateway)

Diseño de Datos: MySQL Workbench (.mwb)

3. Estructura del Repositorio
El código fuente entregado está organizado de la siguiente manera:

main.py: Archivo principal de ejecución. Gestiona el inicio de sesión, la conexión a la base de datos y el menú principal.

bot_whatsapp.py: Módulo de automatización. Contiene la lógica para consultar citas de "mañana" y conectar con la API de WhatsApp para enviar recordatorios.

registro_final.py: Módulo independiente para el formulario de registro de nuevos pacientes.

CODIGO SQL.sql: Script SQL completo. Incluye la creación de la base de datos (CentroOdontologicoCorsa), tablas (Pacientes, Citas, Odontologos) e inserción de datos de prueba.

Generadores de Interfaz (generador_ui.py, reparar.py): Scripts auxiliares que generan los archivos .ui (ventanas gráficas) necesarios si no están presentes.

Archivos de Interfaz (.ui):

main_window.ui: Pantalla de Login.

query_window.ui: Menú principal y panel de control del Bot.

edit_window.ui: Gestión de agenda (visualizar/agendar/eliminar).

register_window.ui: Formulario de pacientes.

Modelo Entidad- Relación.mwb: Archivo fuente del modelado de la base de datos.

4. Guía de Instalación y Configuración
Siga estrictamente estos pasos para desplegar el sistema en un entorno local de desarrollo.

Requisitos Previos del Sistema:
Sistema Operativo: Windows 10/11, macOS o Linux.

Python: Versión 3.8 o superior.

MySQL Server: (XAMPP o MySQL Workbench recomendado).

Paso 1: Configuración del Motor de Base de Datos (MySQL)
Iniciar el Servidor: Asegúrese de que el servicio MySQL esté ejecutándose.

Importar el Script SQL:

Abra su herramienta de administración SQL.

Abra el archivo CODIGO SQL.sql incluido en este repositorio.

Ejecute el script completo.

Verificación: Confirme que se haya creado la base de datos llamada CentroOdontologicoCorsa.

Paso 2: Configuración del Entorno Python
Verificar Python: Abra una terminal y ejecute python --version.

Instalar Dependencias: Ejecute el siguiente comando para instalar las librerías necesarias:

Bash

pip install PyQt5 pymysql requests
Paso 3: Ejecución de la Aplicación
Manteniendo la terminal abierta en la carpeta del proyecto, ejecute el archivo principal:

Bash

python main.py
Nota: Si es la primera vez y no tiene los archivos .ui, ejecute primero python reparar.py para generarlos.

Pantalla de Conexión: Se abrirá la ventana de "Acceso Corsa".

Host: localhost

Usuario: root

Contraseña: (Su contraseña de MySQL local).

Presione "CONECTAR".

5. Manual de Uso Básico
A. Inicio de Sesión
Al iniciar, ingrese las credenciales de su base de datos local. El sistema validará la conexión antes de permitir el acceso al menú.

B. Funcionalidades Principales
1. Gestión de Agenda (Ver Agenda / Citas)
Visualizar: Muestra una tabla con todas las citas agendadas, incluyendo RUT, paciente y tipo de consulta.

Nueva Cita: Ingrese el RUT del paciente, fecha/hora (Formato AAAA-MM-DD HH:MM) y tipo de consulta para agendar.

Cancelar Cita: Ingrese el ID de la cita en la parte inferior para eliminarla del sistema.

2. Automatización (Bot WhatsApp)
Enviar Recordatorios: Al presionar este botón, el sistema busca automáticamente todas las citas programadas para el día de mañana.

Acción: Envía un mensaje personalizado al teléfono registrado del paciente solicitando confirmación.

Reporte: Al finalizar, muestra un resumen de cuántos mensajes fueron enviados exitosamente y cuántos fallaron.

3. Registro de Pacientes
Ejecute el módulo de registro o acceda desde el menú (si está integrado) para ingresar nuevos pacientes a la base de datos, asegurando que el RUT no esté duplicado.

6. Autores (Equipo de Trabajo)
Este proyecto fue desarrollado para la asignatura de Sistemas de Información para la Gestión (ICN292) de la Universidad Técnica Federico Santa María.

Integrantes:

Belén Díaz

Mayte Fuentes

Antonio Quinteros

Isidora Zúñiga

Profesor: Eloy Alvarado Narváez

Semestre: 2025/02
