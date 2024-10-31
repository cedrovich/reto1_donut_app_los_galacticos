import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/cart.dart';

class SmoothieTile extends StatefulWidget {
  final String smoothieName;
  final String smoothiePrice;
  final dynamic smoothieColor;
  final String imageName;

  const SmoothieTile({
    Key? key,
    required this.smoothieName,
    required this.smoothiePrice,
    required this.smoothieColor,
    required this.imageName,
  }) : super(key: key);

  @override
  _SmoothieTileState createState() => _SmoothieTileState();
}

class _SmoothieTileState extends State<SmoothieTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: widget.smoothieColor.withOpacity(0.1),
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
                  color: widget.smoothieColor.withOpacity(0.2),
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
                  '\$${widget.smoothiePrice}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.smoothieColor,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Imagen ajustada
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
                // Nombre del smoothie
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.smoothieName,
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
                  "Smoothie Mid",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
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
                              cart.addItem(widget.smoothieName,
                                  double.parse(widget.smoothiePrice));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${widget.smoothieName} added to cart'),
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
