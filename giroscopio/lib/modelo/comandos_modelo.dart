class Comando {
  final String nombre;
  final String accion;

  Comando({required this.nombre, required this.accion});
}

class ComandosModelo {
  static const String abrirWeb = "abrir_web";
  static const String abrirWord = "abrir_word";
  static const String reproducirVideo = "reproducir_video";
}
