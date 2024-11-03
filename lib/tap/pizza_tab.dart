import 'package:flutter/material.dart';
import 'package:reto1_donut_app_ulises_millan/utils/pizza_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PizzaTab extends StatelessWidget {
  const PizzaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Pizza').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No pizzas available.'));
        }

        final pizzas = snapshot.data!.docs;

        return GridView.builder(
          itemCount: pizzas.length,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (context, index) {
            final pizza = pizzas[index].data() as Map<String, dynamic>;

            Color pizzaColor;
            if (pizza['color'] is int) {
              pizzaColor = Color(pizza['color']);
            } else if (pizza['color'] is String) {
              pizzaColor =
                  Color(int.parse(pizza['color'].replaceFirst('#', '0xFF')));
            } else {
              pizzaColor = Colors.grey;
            }

            return PizzaTile(
              pizzaFlavor: pizza['nombre'],
              pizzaPrice: pizza['precio'],
              pizzaColor: pizzaColor,
              imageName: pizza['imagen'],
            );
          },
        );
      },
    );
  }
}
