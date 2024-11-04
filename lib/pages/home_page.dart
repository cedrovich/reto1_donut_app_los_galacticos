import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/my_tab.dart';
import '../tap/burger_tab.dart';
import '../tap/donut_tab.dart';
import '../tap/pancake_tab.dart';
import '../tap/pizza_tab.dart';
import '../tap/smoothie_tab.dart';
import '../utils/cart.dart';
import '../pages/cart_page.dart';
import '../pages/user_profile_page.dart'; // Importa la página del perfil de usuario

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Widget> myTabs = [
    const MyTab(iconPath: 'lib/icons/donut.png', label: 'Donuts'),
    const MyTab(iconPath: 'lib/icons/burger.png', label: 'Burgers'),
    const MyTab(iconPath: 'lib/icons/smoothie.png', label: 'Smoothies'),
    const MyTab(iconPath: 'lib/icons/pancakes.png', label: 'Pancakes'),
    const MyTab(iconPath: 'lib/icons/pizza.png', label: 'Pizzas'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    _tabController.animateTo(index); // Cambia a la pestaña seleccionada
    Navigator.of(context).pop(); // Cierra el Drawer
  }

  @override
  Widget build(BuildContext context) {
    // Asegúrate de que _tabController está inicializado antes de construir el widget
    if (_tabController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[800], size: 36),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre el Drawer
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              icon: Icon(Icons.person, color: Colors.grey[800], size: 36),
              onPressed: () {
                // Navega a la página de perfil del usuario
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Menú Galáctico',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.fastfood),
              title: const Text('Donuts'),
              onTap: () => _onTabSelected(0),
            ),
            ListTile(
              leading: const Icon(Icons.local_pizza),
              title: const Text('Pizzas'),
              onTap: () => _onTabSelected(4),
            ),
            ListTile(
              leading: const Icon(Icons.local_drink),
              title: const Text('Smoothies'),
              onTap: () => _onTabSelected(2),
            ),
            ListTile(
              leading: const Icon(Icons.breakfast_dining),
              title: const Text('Pancakes'),
              onTap: () => _onTabSelected(3),
            ),
            ListTile(
              leading: const Icon(Icons.lunch_dining),
              title: const Text('Burgers'),
              onTap: () => _onTabSelected(1),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Row(
              children: [
                Text(
                  'I want to ',
                  style: TextStyle(fontSize: 32),
                ),
                Text(
                  'EAT',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DonutTab(),
                BurgerTab(),
                SmoothieTab(),
                PancakeTab(),
                PizzaTab(),
              ],
            ),
          ),
          Consumer<Cart>(
            builder: (context, cart, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${cart.itemCount} Productos | \$${cart.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Cargos de entrega incluidos',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Ver carrito',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
