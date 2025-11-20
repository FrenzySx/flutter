import 'package:flutter/material.dart';
import 'package:shop_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 180,
                child: DrawerHeader(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag,
                      size: 40,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              MyListTile(
                icon: Icons.home,
                text: 'Shop',
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/shop_page');
                },
              ),

              MyListTile(
                icon: Icons.shopping_cart,
                text: 'Cart',
                onTap: () {
                  Navigator.pop(context);

                  Navigator.pushNamed(context, '/cart_page');
                },
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'Exit',
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/intro_page',
                (route) => false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
