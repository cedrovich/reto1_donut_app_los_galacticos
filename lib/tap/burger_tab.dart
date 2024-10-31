import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reto1_donut_app_ulises_millan/utils/burger_tile.dart';

class BurgerTab extends StatelessWidget {
  const BurgerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Accediendo a la subcolección 'burger1' dentro de la colección 'Burger'
      stream: FirebaseFirestore.instance.collection('Burger').doc('burger1').collection('burgers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No burgers available.'));
        }

        final burgers = snapshot.data!.docs;

        return GridView.builder(
          itemCount: burgers.length,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (context, index) {
            final burger = burgers[index].data() as Map<String, dynamic>;
            return BurgerTile(
              burgerName: burger['nombre'],
              burgerPrice: burger['precio'],
              burgerColor: Color(int.parse(burger['color'].replaceFirst('#', '0xFF'))),
              imageName: burger['imagen'],
            );
          },
        );
      },
    );
  }
}
