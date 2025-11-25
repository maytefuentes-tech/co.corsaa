import os


register_code = """<?xml version="1.0" encoding="UTF-8"?>
<ui version="4.0">
 <class>Dialog</class>
 <widget class="QDialog" name="Dialog">
  <property name="geometry"><rect><x>0</x><y>0</y><width>500</width><height>450</height></rect></property>
  <property name="windowTitle"><string>Registrar Nuevo Paciente</string></property>
  
  <widget class="QLabel" name="l_tit"><property name="geometry"><rect><x>100</x><y>20</y><width>300</width><height>30</height></rect></property><property name="text"><string>REGISTRO DE PACIENTE</string></property><property name="alignment"><set>Qt::AlignCenter</set></property><property name="font"><font><pointSize>12</pointSize><weight>75</weight><bold>true</bold></font></property></widget>

  <widget class="QLabel" name="l1"><property name="geometry"><rect><x>50</x><y>70</y><width>100</width><height>20</height></rect></property><property name="text"><string>RUT (con puntos):</string></property></widget>
  <widget class="QTextEdit" name="input_rut"><property name="geometry"><rect><x>160</x><y>65</y><width>250</width><height>30</height></rect></property></widget>

  <widget class="QLabel" name="l2"><property name="geometry"><rect><x>50</x><y>120</y><width>100</width><height>20</height></rect></property><property name="text"><string>Nombre:</string></property></widget>
  <widget class="QTextEdit" name="input_nombre"><property name="geometry"><rect><x>160</x><y>115</y><width>250</width><height>30</height></rect></property></widget>

  <widget class="QLabel" name="l3"><property name="geometry"><rect><x>50</x><y>170</y><width>100</width><height>20</height></rect></property><property name="text"><string>Apellido:</string></property></widget>
  <widget class="QTextEdit" name="input_apellido"><property name="geometry"><rect><x>160</x><y>165</y><width>250</width><height>30</height></rect></property></widget>

  <widget class="QLabel" name="l4"><property name="geometry"><rect><x>50</x><y>220</y><width>100</width><height>20</height></rect></property><property name="text"><string>Teléfono:</string></property></widget>
  <widget class="QTextEdit" name="input_telefono"><property name="geometry"><rect><x>160</x><y>215</y><width>250</width><height>30</height></rect></property></widget>

  <widget class="QLabel" name="l5"><property name="geometry"><rect><x>50</x><y>270</y><width>100</width><height>20</height></rect></property><property name="text"><string>Email:</string></property></widget>
  <widget class="QTextEdit" name="input_email"><property name="geometry"><rect><x>160</x><y>265</y><width>250</width><height>30</height></rect></property></widget>

  <widget class="QPushButton" name="boton_guardar"><property name="geometry"><rect><x>100</x><y>330</y><width>300</width><height>40</height></rect></property><property name="text"><string>GUARDAR PACIENTE</string></property><property name="styleSheet"><string>background-color: #2196F3; color: white; font-weight: bold;</string></property></widget>
 </widget>
 <resources/><connections/>
</ui>"""

with open("register_window.ui", "w", encoding="utf-8") as f:
    f.write(register_code)

print("¡Archivo register_window.ui creado con éxito!")