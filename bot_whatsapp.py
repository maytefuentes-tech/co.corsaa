import pymysql
import requests
import time
from datetime import date, timedelta

class BotWhatsApp:
    def __init__(self, db_config):
        self.db_config = db_config
        self.API_KEY = "3832409"  
        self.MI_TELEFONO_PRUEBA = "+56944817485" 

    def obtener_citas_manana(self):
        """Busca citas agendadas para mañana."""
        manana = date.today() + timedelta(days=1)
        
        sql = """
            SELECT c.id_cita, p.nombre, p.telefono, c.fecha_hora 
            FROM Citas c
            JOIN Pacientes p ON c.id_paciente = p.id_paciente
            WHERE DATE(c.fecha_hora) = %s 
            AND c.id_odontologo = 1 
        """
        
        citas = []
        try:
            conn = pymysql.connect(**self.db_config)
            with conn.cursor() as cursor:
                cursor.execute(sql, (manana,))
                citas = cursor.fetchall()
            conn.close()
        except Exception as e:
            print(f"Error SQL al obtener citas: {e}")
        
        return citas, manana

    def enviar_mensaje(self, numero, mensaje):
        """Envía el mensaje usando la API."""
        msg_encoded = mensaje.replace(" ", "+").replace("\n", "%0A")
        
        url = f"https://api.callmebot.com/whatsapp.php?phone={self.MI_TELEFONO_PRUEBA}&text={msg_encoded}&apikey={self.API_KEY}"
        
        try:
            res = requests.get(url, timeout=10)
            return res.status_code == 200
        except Exception as e:
            print(f"Error API: {e}")
            return False

    def ejecutar(self):
        citas, fecha = self.obtener_citas_manana()
        reporte = []

        if not citas:
            return "No hay citas programadas para mañana."

        conn = pymysql.connect(**self.db_config)
        
        count_ok = 0
        with conn.cursor() as cursor:
            for id_cita, nombre, telefono, fecha_hora in citas:
                hora_str = str(fecha_hora).split(" ")[1][:5]
                
                texto = f"Hola {nombre}, recordamos su cita en C.O. Corsa mañana {fecha} a las {hora_str}. Por favor confirmar."
                
                enviado = self.enviar_mensaje(telefono, texto)
                
                if enviado:
                    count_ok += 1
                    estado_envio = 'Enviado'
                    reporte.append(f"✅ {nombre}: Enviado")
                else:
                    estado_envio = 'Fallido'
                    reporte.append(f"❌ {nombre}: Falló API")
                sql_insert = """
                    INSERT INTO Recordatorios 
                    (id_cita, tipo_recordatorio, mensaje, fecha_envio, estado) 
                    VALUES (%s, 'WhatsApp', %s, NOW(), %s)
                """
                cursor.execute(sql_insert, (id_cita, texto, estado_envio))
                
                time.sleep(2)
                
            conn.commit()
        conn.close()
        
        return f"Proceso finalizado.\nEnviados: {count_ok}/{len(citas)}\n\n" + "\n".join(reporte)