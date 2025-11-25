import os

# 1. CÓDIGO PARA MAIN_WINDOW (Login)
main_code = """<?xml version="1.0" encoding="UTF-8"?>
<ui version="4.0">
 <class>main_window</class>
 <widget class="QMainWindow" name="main_window">
  <property name="geometry"><rect><x>0</x><y>0</y><width>600</width><height>400</height></rect></property>
  <property name="windowTitle"><string>Acceso Corsa</string></property>
  <widget class="QWidget" name="centralwidget">
   <widget class="QLabel" name="l1"><property name="geometry"><rect><x>150</x><y>50</y><width>300</width><height>30</height></rect></property><property name="text"><string>Sistema Centro Odontológico Corsa</string></property><property name="alignment"><set>Qt::AlignCenter</set></property><property name="font"><font><pointSize>12</pointSize><weight>75</weight><bold>true</bold></font></property></widget>
   <widget class="QLabel" name="l2"><property name="geometry"><rect><x>100</x><y>120</y><width>100</width><height>20</height></rect></property><property name="text"><string>Host (IP):</string></property></widget>
   <widget class="QTextEdit" name="text_host_main"><property name="geometry"><rect><x>200</x><y>110</y><width>250</width><height>30</height></rect></property><property name="html"><string>localhost</string></property></widget>
   <widget class="QLabel" name="l3"><property name="geometry"><rect><x>100</x><y>170</y><width>100</width><height>20</height></rect></property><property name="text"><string>Usuario:</string></property></widget>
   <widget class="QTextEdit" name="text_user_main"><property name="geometry"><rect><x>200</x><y>160</y><width>250</width><height>30</height></rect></property><property name="html"><string>root</string></property></widget>
   <widget class="QLabel" name="l4"><property name="geometry"><rect><x>100</x><y>220</y><width>100</width><height>20</height></rect></property><property name="text"><string>Contraseña:</string></property></widget>
   <widget class="QTextEdit" name="text_password_main"><property name="geometry"><rect><x>200</x><y>210</y><width>250</width><height>30</height></rect></property></widget>
   <widget class="QPushButton" name="boton_conectar"><property name="geometry"><rect><x>220</x><y>280</y><width>160</width><height>40</height></rect></property><property name="text"><string>CONECTAR</string></property></widget>
  </widget>
 </widget>
 <resources/><connections/>
</ui>"""

# 2. CÓDIGO PARA QUERY_WINDOW (Menú)
query_code = """<?xml version="1.0" encoding="UTF-8"?>
<ui version="4.0">
 <class>Dialog</class>
 <widget class="QDialog" name="Dialog">
  <property name="geometry"><rect><x>0</x><y>0</y><width>500</width><height>300</height></rect></property>
  <property name="windowTitle"><string>Menú Principal</string></property>
  <widget class="QLabel" name="l1"><property name="geometry"><rect><x>100</x><y>30</y><width>300</width><height>20</height></rect></property><property name="text"><string>Seleccione una opción:</string></property><property name="alignment"><set>Qt::AlignCenter</set></property></widget>
  <widget class="QComboBox" name="tabla_combo"><property name="geometry"><rect><x>150</x><y>80</y><width>200</width><height>30</height></rect></property></widget>
  <widget class="QComboBox" name="consulta_combo"><property name="geometry"><rect><x>150</x><y>130</y><width>200</width><height>30</height></rect></property></widget>
  <widget class="QPushButton" name="boton_visualizar"><property name="geometry"><rect><x>200</x><y>190</y><width>100</width><height>30</height></rect></property><property name="text"><string>INGRESAR</string></property></widget>
  <widget class="QPushButton" name="boton_volver"><property name="geometry"><rect><x>200</x><y>240</y><width>100</width><height>30</height></rect></property><property name="text"><string>SALIR</string></property></widget>
 </widget>
 <resources/><connections/>
</ui>"""

# 3. CÓDIGO PARA EDIT_WINDOW (La Agenda)
edit_code = """<?xml version="1.0" encoding="UTF-8"?>
<ui version="4.0">
 <class>Dialog</class>
 <widget class="QDialog" name="Dialog">
  <property name="geometry"><rect><x>0</x><y>0</y><width>900</width><height>600</height></rect></property>
  <property name="windowTitle"><string>Gestión de Agenda</string></property>
  
  <widget class="QLabel" name="tit"><property name="geometry"><rect><x>30</x><y>10</y><width>200</width><height>30</height></rect></property><property name="text"><string>NUEVA CITA</string></property><property name="font"><font><weight>75</weight><bold>true</bold></font></property></widget>

  <widget class="QLabel" name="l1"><property name="geometry"><rect><x>30</x><y>50</y><width>150</width><height>20</height></rect></property><property name="text"><string>RUT Paciente (ej: 12.345.678-9)</string></property></widget>
  <widget class="QTextEdit" name="query_nombre_insumos"><property name="geometry"><rect><x>30</x><y>70</y><width>200</width><height>30</height></rect></property></widget>

  <widget class="QLabel" name="l2"><property name="geometry"><rect><x>250</x><y>50</y><width>200</width><height>20</height></rect></property><property name="text"><string>Fecha y Hora (AAAA-MM-DD HH:MM)</string></property></widget>
  <widget class="QTextEdit" name="query_cantidad_insumos"><property name="geometry"><rect><x>250</x><y>70</y><width>200</width><height>30</height></rect></property></widget>

  <widget class="QLabel" name="l3"><property name="geometry"><rect><x>470</x><y>50</y><width>150</width><height>20</height></rect></property><property name="text"><string>Tipo (ej: Control, Limpieza)</string></property></widget>
  <widget class="QTextEdit" name="query_medida_insumos"><property name="geometry"><rect><x>470</x><y>70</y><width>150</width><height>30</height></rect></property></widget>

  <widget class="QLabel" name="l4"><property name="geometry"><rect><x>640</x><y>50</y><width>150</width><height>20</height></rect></property><property name="text"><string>Observaciones</string></property></widget>
  <widget class="QTextEdit" name="query_descripcion_insumos"><property name="geometry"><rect><x>640</x><y>70</y><width>200</width><height>30"""