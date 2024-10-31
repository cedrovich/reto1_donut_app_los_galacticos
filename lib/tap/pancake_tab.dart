import 'package:flutter/material.dart';
import 'package:reto1_donut_app_ulises_millan/utils/pancake_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PancakeTab extends StatelessWidget {
  const PancakeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Accediendo a la subcolección 'pancake1' dentro de la colección 'Pancake'
      stream: FirebaseFirestore.instance.collection('Pancake').doc('pancake1').collection('pancakes').snapshots(),
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
            return PancakeTile(
              pancakeFlavor: pancake['nombre'],
              pancakePrice: pancake['precio'],
              pancakeColor: Color(int.parse(pancake['color'].replaceFirst('#', '0xFF'))),
              imageName: pancake['imagen'],
            );
          },
        );
      },
    );
  }
}


// class PancakeTab extends StatelessWidget {
//   // Lista de pancakes
//   final List pancakesOnSale = [
//     ["Classic Pancake", "20", Colors.amber, "lib/images/pancakes.png"],
//     ["Nutella Pancake", "27", Colors.deepOrange, "lib/images/pancakes.png"],
//     ["Blueberry Pancake", "30", Colors.blue, "lib/images/pancakes.png"],
//     ["Peanut Butter Pancake", "32", Colors.pink, "lib/images/pancakes.png"],
//     ["Maple Syrup Pancake", "24", Colors.orange, "lib/images/pancakes.png"],
//     ["Chocolate Pancake", "25", Colors.brown, "lib/images/pancakes.png"],
//     ["Strawberry Pancake", "28", Colors.red, "lib/images/pancakes.png"],
//     ["Banana Pancake", "22", Colors.yellow, "lib/images/pancakes.png"],
//   ];

//   PancakeTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       itemCount: pancakesOnSale.length,
//       padding: const EdgeInsets.all(12),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1 / 1.5,
//       ),
//       itemBuilder: (context, index) {
//         return PancakeTile(
//           pancakeFlavor: pancakesOnSale[index][0],
//           pancakePrice: pancakesOnSale[index][1],
//           pancakeColor: pancakesOnSale[index][2],
//           imageName: pancakesOnSale[index][3],
//         );
//       },
//     );
//   }
// }
