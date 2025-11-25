import sys
import os
import pymysql
from PyQt5.QtWidgets import QApplication, QDialog, QMessageBox
from PyQt5.uic import loadUi

ui_content = """<?xml version="1.0" encoding="UTF-8"?>
<ui version="4.0">
 <class>Dialog</class>
 <widget class="QDialog" name="Dialog">
  <property name="geometry"><rect><x>0</x><y>0</y><width>500</width><height>450</height></rect></property>
  <property name="windowTitle"><string>Registrar Nuevo Paciente</string></property>
  <widget class="QLabel" name="l_tit"><property name="geometry"><rect><x>100</x><y>20</y><width>300</width><height>30</height></rect></property><property name="text"><string>REGISTRO DE PACIENTE</string></property><property name="alignment"><set>Qt::AlignCenter</set></property><property name="font"><font><pointSize>12</pointSize><weight>75</weight><bold>true</bold></font></property></widget>
  
  <widget class="QLabel" name="l1"><property name="geometry"><rect><x>50</x><y>70</y><width>100</width><height>20</height></rect></property><property name="text"><string>RUT:</string></property></widget>
  <widget class="QTextEdit" name="input_rut"><property name="geometry"><rect><x>160</x><y>65</y><width>250</width><height>30</height></rect></property><property name="html"><string>11.111.111-1</string></property></widget>

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
    f.write(ui_content)

class RegisterWindow(QDialog): 
    def __init__(self):
        super().__init__()
        loadUi('register_window.ui', self)
        self.boton_guardar.clicked.connect(self.guardar_paciente)
        self.host = 'localhost'
        self.user = 'root'
        self.password = 'Cony.20247'  
        self.db = 'CentroOdontologicoCorsa'

    def guardar_paciente(self):
        rut = self.input_rut.toPlainText().strip()
        nombre = self.input_nombre.toPlainText().strip()
        apellido = self.input_apellido.toPlainText().strip()
        telefono = self.input_telefono.toPlainText().strip()
        email = self.input_email.toPlainText().strip()

        if not (rut and nombre and apellido):
            QMessageBox.warning(self, 'Faltan Datos', 'RUT, Nombre y Apellido son obligatorios.')
            return

        try:
            connection = pymysql.connect(host=self.host, user=self.user, password=self.password, database=self.db)
            with connection.cursor() as cursor:
                sql = "INSERT INTO Pacientes (rut, nombre, apellido, telefono, email) VALUES (%s, %s, %s, %s, %s)"
                cursor.execute(sql, (rut, nombre, apellido, telefono, email))
                connection.commit()
                
                QMessageBox.information(self, 'Éxito', f'Paciente {nombre} {apellido} registrado correctamente.')

                self.input_rut.setText("")
                self.input_nombre.setText("")
                self.input_apellido.setText("")
                self.input_telefono.setText("")
                self.input_email.setText("")
            
            connection.close()

        except pymysql.err.IntegrityError:
            QMessageBox.critical(self, 'Error', 'Ese RUT ya existe en la base de datos.')
        except Exception as e:
            QMessageBox.critical(self, 'Error', f'No se pudo conectar o guardar:\n{str(e)}')

if __name__ == "__main__":
    app = QApplication(sys.argv)
    ventana = RegisterWindow()
    ventana.show()
    sys.exit(app.exec_())