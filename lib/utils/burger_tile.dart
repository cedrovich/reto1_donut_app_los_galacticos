import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/cart.dart';

class BurgerTile extends StatefulWidget {
  final String burgerName;
  final String burgerPrice;
  final Color burgerColor;
  final String imageName;

  const BurgerTile({
    Key? key,
    required this.burgerName,
    required this.burgerPrice,
    required this.burgerColor,
    required this.imageName,
  }) : super(key: key);

  @override
  _BurgerTileState createState() => _BurgerTileState();
}

class _BurgerTileState extends State<BurgerTile> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: widget.burgerColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.burgerColor.withOpacity(0.2),
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
                  '\$${widget.burgerPrice}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.burgerColor,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  child: Image.asset(widget.imageName),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.burgerName,
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
                  "Carl's Jr",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Consumer<Cart>(
                        builder: (context, cart, child) {
                          return IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              cart.addItem(widget.burgerName,
                                  double.parse(widget.burgerPrice));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${widget.burgerName} added to cart'),
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