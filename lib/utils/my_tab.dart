import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  final String iconPath;
  final String label; // Nuevo parámetro para el texto

  const MyTab({
    super.key,
    required this.iconPath,
    required this.label, // Asegúrate de que sea requerido
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
      children: [
        // Contenedor del icono
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            iconPath,
            color: Colors.grey[600],
            height: 30, // Ajusta el tamaño del icono según sea necesario
          ),
        ),
        const SizedBox(height: 4), // Espacio entre icono y texto
        // Texto fuera del contenedor gris
        Text(
          label, // Muestra el texto
          style: const TextStyle(fontSize: 15), // Ajusta el tamaño del texto
        ),
      ],
    );
  }
}