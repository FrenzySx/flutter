import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/shoe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Shoe shoe;
  const CartItem({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Image.asset(shoe.imagePath, width: 56),
        title: Text(shoe.name),
        subtitle: Text('\$${shoe.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => cart.removeItemFromCart(shoe),
              icon: const Icon(Icons.remove),
            ),
            Text('${cart.quantityOf(shoe)}'),
            IconButton(
              onPressed: () => cart.addItemToCart(shoe),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
