import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../controlador/giroscopio_controlador.dart';

class PantallaPrincipal extends StatefulWidget {
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final GiroscopioControlador controlador = GiroscopioControlador();
  double x = 0.0, y = 0.0, z = 0.0;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((evento) {
      setState(() {
        x = evento.x;
        y = evento.y;
        z = evento.z;
      });
      controlador.procesarMovimiento(x, y, z);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Control del Giroscopio',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none, // Aseguramos que no haya subrayado
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoCard(
                'Movimiento en el eje X',
                '${x.toStringAsFixed(2)}',
                CupertinoColors.systemBlue,
              ),
              SizedBox(height: 10),
              _buildInfoCard(
                'Movimiento en el eje Y',
                '${y.toStringAsFixed(2)}',
                CupertinoColors.systemGreen,
              ),
              SizedBox(height: 10),
              _buildInfoCard(
                'Movimiento en el eje Z',
                '${z.toStringAsFixed(2)}',
                CupertinoColors.systemRed,
              ),
              SizedBox(height: 30),
              Text(
                'Interacciones disponibles:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none, // Elimina subrayado aquí también
                ),
              ),
              SizedBox(height: 10),
              _buildActionItem('- X: Abrir página web'),
              _buildActionItem('- Y: Abrir Word'),
              _buildActionItem('- Z: Reproducir Video'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.secondarySystemBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 14,
              decoration: TextDecoration.none, // Garantizamos sin subrayado
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none, // Garantizamos sin subrayado
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: CupertinoColors.systemGrey2,
          decoration: TextDecoration.none, // Eliminamos subrayado en cada ítem
        ),
      ),
    );
  }
}
