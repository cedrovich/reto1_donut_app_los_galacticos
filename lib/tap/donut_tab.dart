import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reto1_donut_app_ulises_millan/utils/donut_tile.dart';

class DonutTab extends StatelessWidget {
  const DonutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Donut').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No donuts available.'));
        }

        final donuts = snapshot.data!.docs;

        return GridView.builder(
          itemCount: donuts.length,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (context, index) {
            final donut = donuts[index].data() as Map<String, dynamic>;

            // Verifica si el color es String o int y convierte según sea necesario
            Color donutColor;
            if (donut['color'] is int) {
              donutColor = Color(donut['color']);
            } else if (donut['color'] is String) {
              donutColor =
                  Color(int.parse(donut['color'].replaceFirst('#', '0xFF')));
            } else {
              donutColor = Colors.grey; // Valor predeterminado en caso de error
            }

            // Usa null-aware operators para manejar posibles valores null
            return DonutTile(
              donutFlavor:
                  donut['nombre'] ?? 'Unknown Flavor', // Valor predeterminado
              donutPrice: donut['precio'] ?? 0.0, // Valor predeterminado
              donutColor: donutColor,
              imageName: donut['imagen'] ??
                  'placeholder_image.png', // Valor predeterminado
            );
          },
        );
      },
    );
  }
}
