import 'package:web_socket_channel/io.dart';
import '../modelo/comandos_modelo.dart';

class GiroscopioControlador {
  IOWebSocketChannel? canal;

  GiroscopioControlador() {
    conectarConServidor();
  }

  void conectarConServidor() {
    try {
      canal = IOWebSocketChannel.connect('ws://192.168.117.71:8765');
      print('Conexión establecida con el servidor WebSocket.');

      // Escucha eventos del canal
      canal!.stream.listen(
            (mensaje) {
          print('Mensaje recibido del servidor: $mensaje');
        },
        onDone: () {
          print('Conexión cerrada.');
        },
        onError: (error) {
          print('Error en la conexión: $error');
        },
      );
    } catch (e) {
      print('Error al conectar con el servidor: $e');
    }
  }


  void enviarComando(String comando) {
    if (canal != null && canal!.sink != null) {
      try {
        canal!.sink.add(comando);
        print('Comando enviado: $comando');
      } catch (e) {
        print('Error al enviar comando: $e');
      }
    } else {
      print('El canal WebSocket no está conectado.');
    }
  }


  void procesarMovimiento(double x, double y, double z) {
    if (x > 2.0) {
      enviarComando(ComandosModelo.abrirWeb);
    } else if (y > 2.0) {
      enviarComando(ComandosModelo.abrirWord);
    } else if (z > 2.0) {
      enviarComando(ComandosModelo.reproducirVideo);
    }
  }
}
