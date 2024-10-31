import 'package:flutter/material.dart';
import 'package:reto1_donut_app_ulises_millan/utils/donut_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DonutTab extends StatelessWidget {
  const DonutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // Accediendo a la subcolección 'donut1' dentro de la colección 'Donut'
      stream: FirebaseFirestore.instance.collection('Donut').doc('donut1').collection('donuts').snapshots(),
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
            return DonutTile(
              donutFlavor: donut['nombre'],
              donutPrice: donut['precio'],
              donutColor: Color(int.parse(donut['color'].replaceFirst('#', '0xFF'))),
              imageName: donut['imagen'],
            );
          },
        );
      },
    );
  }
}

// class DonutTab extends StatelessWidget {
//   // Lista de donuts
//   final List donutsOnSale = [
//     ["Ice Cream", "36", Colors.blue, "lib/images/icecream_donut.png"],
//     ["Strawberry", "45", Colors.red, "lib/images/strawberry_donut.png"],
//     ["Grape Ape", "84", Colors.purple, "lib/images/grape_donut.png"],
//     ["Choco", "95", Colors.brown, "lib/images/chocolate_donut.png"],
//     ["Ice Cream", "36", Colors.blue, "lib/images/icecream_donut.png"],
//     ["Strawberry", "45", Colors.red, "lib/images/strawberry_donut.png"],
//     ["Grape Ape", "84", Colors.purple, "lib/images/grape_donut.png"],
//     ["Choco", "95", Colors.brown, "lib/images/chocolate_donut.png"],
//   ];

//   DonutTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       itemCount: donutsOnSale.length,
//       padding: const EdgeInsets.all(12),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 1 / 1.5,
//       ),
//       itemBuilder: (context, index) {
//         return DonutTile(
//           donutFlavor: donutsOnSale[index][0],
//           donutPrice: donutsOnSale[index][1],
//           donutColor: donutsOnSale[index][2],
//           imageName: donutsOnSale[index][3],
//         );
//       },
//     );
//   }
// }
