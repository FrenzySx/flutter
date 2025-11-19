import 'package:ecommerce_app/components/shoe_tile.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    final shoes = Provider.of<Cart>(context, listen: false).getShoeList();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('All Shoes', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: shoes.length,
        padding: const EdgeInsets.only(bottom: 25, right: 25),
        itemBuilder: (context, index) => Container(
          height: 420,
          margin: const EdgeInsets.only(bottom: 20),
          child: ShoeTile(
            shoe: shoes[index],
            onTap: () {
              Provider.of<Cart>(
                context,
                listen: false,
              ).addItemToCart(shoes[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Succesfully added!')),
              );
            },
          ),
        ),
      ),
    );
  }
}
