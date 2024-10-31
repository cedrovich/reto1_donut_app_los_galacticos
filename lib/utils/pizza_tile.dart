import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/cart.dart';

class PizzaTile extends StatefulWidget {
  final String pizzaFlavor;
  final String pizzaPrice;
  final dynamic pizzaColor;
  final String imageName;

  const PizzaTile({
    Key? key,
    required this.pizzaFlavor,
    required this.pizzaPrice,
    required this.pizzaColor,
    required this.imageName,
  }) : super(key: key);

  @override
  _PizzaTileState createState() => _PizzaTileState();
}

class _PizzaTileState extends State<PizzaTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: widget.pizzaColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            // Precio en la esquina superior derecha
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.pizzaColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 18,
                ),
                child: Text(
                  '\$${widget.pizzaPrice}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.pizzaColor,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagen de la pizza
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  child: Image.asset(
                    widget.imageName,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                // Sabor de la pizza
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.pizzaFlavor,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Pizzeria Balero's",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Botones de favorito y agregar al carrito
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón de favorito
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red[400],
                        ),
                      ),
                      // Botón de agregar al carrito
                      Consumer<Cart>(
                        builder: (context, cart, child) {
                          return IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              cart.addItem(widget.pizzaFlavor,
                                  double.parse(widget.pizzaPrice));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${widget.pizzaFlavor} added to cart'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
