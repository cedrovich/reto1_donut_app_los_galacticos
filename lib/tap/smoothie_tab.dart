import 'package:flutter/material.dart';
import 'package:reto1_donut_app_ulises_millan/utils/smoothie_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SmoothieTab extends StatelessWidget {
  const SmoothieTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Accediendo a la subcolección 'smoothie1' dentro de la colección 'Smoothie'
      stream: FirebaseFirestore.instance.collection('Smoothie').doc('smoothie1').collection('smoothies').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No smoothies available.'));
        }

        final smoothies = snapshot.data!.docs;

        return GridView.builder(
          itemCount: smoothies.length,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (context, index) {
            final smoothie = smoothies[index].data() as Map<String, dynamic>;
            return SmoothieTile(
              smoothieName: smoothie['nombre'],
              smoothiePrice: smoothie['precio'],
              smoothieColor: Color(int.parse(smoothie['color'].replaceFirst('#', '0xFF'))),
              imageName: smoothie['imagen'],
            );
          },
        );
      },
    );
  }
}


// class SmoothieTab extends StatelessWidget {
//   // Lista de smoothies en venta
//   final List smoothiesOnSale = [
//     ["Berry Blast", "55", Colors.purple, "lib/images/smoothie.png"],
//     ["Tropical Paradise", "60", Colors.orange, "lib/images/smoothie.png"],
//     ["Green Detox", "50", Colors.green, "lib/images/smoothie.png"],
//     ["Mango Madness", "65", Colors.yellow, "lib/images/smoothie.png"],
//     ["Strawberry Delight", "55", Colors.red, "lib/images/smoothie.png"],
//     ["Chocolate Dream", "70", Colors.brown, "lib/images/smoothie.png"],
//     ["Blueberry Heaven", "58", Colors.blue, "lib/images/smoothie.png"],
//     ["Pineapple Punch", "62", Colors.deepOrange, "lib/images/smoothie.png"],
//   ];

//   SmoothieTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       itemCount: smoothiesOnSale.length,
//       padding: const EdgeInsets.all(12),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1 / 1.5,
//       ),
//       itemBuilder: (context, index) {
//         return SmoothieTile(
//           smoothieName: smoothiesOnSale[index][0],
//           smoothiePrice: smoothiesOnSale[index][1],
//           smoothieColor: smoothiesOnSale[index][2],
//           imageName: smoothiesOnSale[index][3],
//         );
//       },
//     );
//   }
// }