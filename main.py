import sys
import pymysql
from PyQt5.QtWidgets import QApplication, QMainWindow, QDialog, QMessageBox, QTableWidgetItem
from PyQt5.uic import loadUi
from bot_whatsapp import BotWhatsApp 

class EditWindow(QDialog): 
    def __init__(self, query_window, connection):
        super().__init__()
        loadUi('edit_window.ui', self) 
        self.query_window = query_window
        self.connection = connection
        self.refresh_table()

        self.boton_volver_query.clicked.connect(self.return_to_query)
        self.insertar_insumos.clicked.connect(self.agendar_cita)
        self.eliminar_boton.clicked.connect(self.eliminar_cita)

    def display_results(self, results):
        self.mostrar.setRowCount(len(results))
        self.mostrar.setColumnCount(6) 
        self.mostrar.setHorizontalHeaderLabels(['ID', 'RUT', 'Paciente', 'Fecha Hora', 'Consulta', 'Estado'])
        for i, row in enumerate(results):
            for j, item in enumerate(row):
                self.mostrar.setItem(i, j, QTableWidgetItem(str(item)))
        self.mostrar.resizeColumnsToContents()

    def refresh_table(self):
        sql = """
        SELECT c.id_cita, p.rut, CONCAT(p.nombre, ' ', p.apellido), c.fecha_hora, c.tipo_consulta, 'Agendada' 
        FROM Citas c
        JOIN Pacientes p ON c.id_paciente = p.id_paciente
        ORDER BY c.fecha_hora ASC
        """
        try:
            with self.connection.cursor() as cursor:
                cursor.execute(sql)
                result = cursor.fetchall()
                self.display_results(result)
        except Exception as e:
            QMessageBox.critical(self, 'Error Tabla', str(e))

    def agendar_cita(self):
        rut = self.query_nombre_insumos.toPlainText().strip()
        fecha = self.query_cantidad_insumos.toPlainText().strip()
        tipo = self.query_medida_insumos.toPlainText().strip()
        obs = self.query_descripcion_insumos.toPlainText().strip()

        if not (rut and fecha and tipo):
            QMessageBox.warning(self,'Faltan Datos', 'Ingrese RUT, Fecha y Tipo.')
            return

        try:
            with self.connection.cursor() as cursor:
                cursor.execute("SELECT id_paciente FROM Pacientes WHERE rut = %s", (rut,))
                paciente = cursor.fetchone()
                
                if not paciente:
                    QMessageBox.warning(self, 'Error', 'Paciente no encontrado.')
                    return

                sql = "INSERT INTO Citas (id_paciente, id_odontologo, fecha_hora, tipo_consulta, observaciones) VALUES (%s, 1, %s, %s, %s)"
                cursor.execute(sql, (paciente[0], fecha, tipo, obs))
                self.connection.commit()
                
                QMessageBox.information(self, 'Éxito', 'Cita Agendada')
                self.refresh_table()
        except Exception as e:
            QMessageBox.critical(self, 'Error SQL', str(e))

    def eliminar_cita(self):
        id_cita = self.query_id_delete.toPlainText().strip()
        if not id_cita: return
        try:
            with self.connection.cursor() as cursor:
                cursor.execute("DELETE FROM Recordatorios WHERE id_cita = %s", (id_cita,))
                cursor.execute("DELETE FROM Citas WHERE id_cita = %s", (id_cita,))
                self.connection.commit()
                self.refresh_table()
                QMessageBox.information(self, 'Info', 'Cita Cancelada')
        except Exception as e:
            QMessageBox.critical(self, 'Error', str(e))

    def return_to_query(self):
        self.query_window.show()
        self.close()
class QueryWindow(QDialog): 
    def __init__(self, main_window, db_config):
        super().__init__()
        loadUi('query_window.ui', self)  
        self.main_window = main_window
        self.db_config = db_config 
        
        self.boton_visualizar.clicked.connect(self.open_edit)
        self.boton_volver.clicked.connect(self.logout)
        self.boton_recordatorios.clicked.connect(self.lanzar_bot)

    def open_edit(self):
        try:
            conn = pymysql.connect(**self.db_config)
            self.edit = EditWindow(self, conn)
            self.edit.show()
            self.hide()
        except Exception as e:
            QMessageBox.critical(self, "Error", f"Error conexión: {e}")

    def lanzar_bot(self):
        reply = QMessageBox.question(self, 'Confirmar Envío', 
                                     "¿Buscar citas de MAÑANA y enviar WhatsApps?",
                                     QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        
        if reply == QMessageBox.Yes:
            self.boton_recordatorios.setEnabled(False)
            self.boton_recordatorios.setText("Enviando...")
            QApplication.processEvents() 
            try:
                bot = BotWhatsApp(self.db_config)
                resultado = bot.ejecutar()
                QMessageBox.information(self, "Reporte", resultado)
            except Exception as e:
                QMessageBox.critical(self, "Error Bot", str(e))
            
            self.boton_recordatorios.setEnabled(True)
            self.boton_recordatorios.setText("ENVIAR RECORDATORIOS (WSP)")
    def logout(self):
        self.main_window.show()
        self.close()
class MainWindow(QMainWindow): 
    def __init__(self):
        super().__init__()
        loadUi('main_window.ui', self)
        self.boton_conectar.clicked.connect(self.connect_db)
    
    def connect_db(self):
        h = self.text_host_main.toPlainText()
        u = self.text_user_main.toPlainText()
        p = self.text_password_main.toPlainText()
        
        self.db_config = {
            'host': h, 'user': u, 'password': p, 'database': 'CentroOdontologicoCorsa'
        }
        
        try:
            conn = pymysql.connect(**self.db_config)
            conn.close()
            QMessageBox.information(self,'Conectado', 'Sistema Corsa Iniciado')
            self.query = QueryWindow(self, self.db_config)
            self.query.show()
            self.hide()
        except Exception as e:
            QMessageBox.critical(self,'Error', 'Datos incorrectos.\n' + str(e))

if __name__ == "__main__":
    app = QApplication(sys.argv)
    main = MainWindow()
    main.show()
    sys.exit(app.exec_())