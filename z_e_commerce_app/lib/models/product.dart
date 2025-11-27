import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final IconData icon;

  const Product({required this.name, required this.price, required this.icon});
}

const products = [
  Product(name: 'Headphones', price: 59.99, icon: Icons.headphones),
  Product(name: 'Smart Watch', price: 129.00, icon: Icons.watch),
  Product(name: 'Backpack', price: 45.50, icon: Icons.backpack),
  Product(name: 'Camera', price: 299.00, icon: Icons.photo_camera),
  Product(name: 'Sneakers', price: 89.90, icon: Icons.directions_run),
  Product(name: 'Speaker', price: 39.99, icon: Icons.speaker),
];
