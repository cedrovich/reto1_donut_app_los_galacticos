import 'package:flutter/material.dart';
import 'package:reto1_donut_app_ulises_millan/utils/smoothie_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SmoothieTab extends StatelessWidget {
  const SmoothieTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Smoothie').snapshots(),
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

            Color smoothieColor;
            if (smoothie['color'] is int) {
              smoothieColor = Color(smoothie['color']);
            } else if (smoothie['color'] is String) {
              smoothieColor =
                  Color(int.parse(smoothie['color'].replaceFirst('#', '0xFF')));
            } else {
              smoothieColor = Colors.grey;
            }

            return SmoothieTile(
              smoothieName: smoothie['nombre'],
              smoothiePrice: smoothie['precio'],
              smoothieColor: smoothieColor,
              imageName: smoothie['imagen'],
            );
          },
        );
      },
    );
  }
}
