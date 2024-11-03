import 'package:flutter/material.dart';
import 'package:reto1_donut_app_ulises_millan/utils/pancake_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PancakeTab extends StatelessWidget {
  const PancakeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Pancake').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No pancakes available.'));
        }

        final pancakes = snapshot.data!.docs;

        return GridView.builder(
          itemCount: pancakes.length,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (context, index) {
            final pancake = pancakes[index].data() as Map<String, dynamic>;

            // Manejo de color según el tipo de valor
            Color pancakeColor;
            if (pancake['color'] is int) {
              pancakeColor = Color(pancake['color']);
            } else if (pancake['color'] is String) {
              pancakeColor =
                  Color(int.parse(pancake['color'].replaceFirst('#', '0xFF')));
            } else {
              pancakeColor =
                  Colors.grey; // Color predeterminado en caso de error
            }

            // Uso de operadores null-aware para asignar valores predeterminados
            return PancakeTile(
              pancakeFlavor:
                  pancake['nombre'] ?? 'Unknown Flavor', // Valor predeterminado
              pancakePrice: pancake['precio'] ?? 0.0, // Valor predeterminado
              pancakeColor: pancakeColor,
              imageName: pancake['imagen'] ??
                  'placeholder_image.png', // Valor predeterminado
            );
          },
        );
      },
    );
  }
}
