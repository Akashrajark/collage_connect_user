import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductsShowScreen extends StatelessWidget {
  final List products;
  const ProductsShowScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            itemBuilder: (context, index) => ProductCard(
              imageUrl: products[index]['image_url'],
              title: products[index]['name'],
              subtitle: '${products[index]['stock']} in stock',
              price: '₹${products[index]['price']}/ ${products[index]['unit']}',
              cardColor: Colors.white,
              buttonColor: Colors.green,
              onIncrement: () {},
              onDecrement: () {},
              counte: 0,
            ),
            itemCount: products.length,
          ),
        ),
      ),
    );
  }
}
