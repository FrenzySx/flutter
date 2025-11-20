import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/drawer.dart';
import 'package:shop_app/components/my_product_tile.dart';
import 'package:shop_app/models/shop.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().shop;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          'Shop',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: Stack(
        alignment: .topRight,
        children: [
          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/cart_page'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.shopping_cart_checkout,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.inversePrimary, // Bildirim rengi
                shape: BoxShape.circle, // Yuvarlak form
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ), // Etrafına beyaz çizgi (daha şık durur)
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: Text(
                  // Shop sınıfındaki sepet listesinin uzunluğunu çeker
                  context.watch<Shop>().itemCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 25),

          //shop subtitle
          Center(
            child: Text(
              'Pick from a selected list of premium products',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),

          //product list
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: products.length,
              padding: EdgeInsets.all(15),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final product = products[index];

                return MyProductTile(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
