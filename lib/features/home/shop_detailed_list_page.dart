import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common_widgets.dart/custom_alert_dialog.dart';
import 'carts_bloc/carts_bloc.dart';
import 'product_card.dart';

class ShopDetailedListPage extends StatefulWidget {
  final Map shop;
  // final List categories;
  const ShopDetailedListPage({
    super.key,
    required this.shop,
    // required this.categories,
  });

  @override
  State<ShopDetailedListPage> createState() => _ShopDetailedListPageState();
}

class _ShopDetailedListPageState extends State<ShopDetailedListPage> {
  List products = [], categories = [];

  @override
  void initState() {
    products = widget.shop['canteen_products'];
    // categories = widget.categories;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartsBloc(),
      child: BlocConsumer<CartsBloc, CartsState>(
        listener: (context, state) {
          if (state is CartsFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is CartsSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added to cart'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      widget.shop['name'],
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    background: Image.network(
                      widget.shop['image_url'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, ind) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Products',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 5),
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => SizedBox(
                            height: 170,
                            child: ProductCard(
                              imageUrl: products[index]['image_url'],
                              title: products[index]['name'],
                              subtitle: products[index]['stock'].toString(),
                              price: '₹${products[index]['price'].toString()}/${products[index]['unit'].toString()}',
                              cardColor: Colors.white,
                              buttonColor: Colors.green,
                              onIncrement: () {
                                BlocProvider.of<CartsBloc>(context).add(AddCartEvent(cartDetails: {
                                  'p_product_id': products[index]['id'],
                                  'p_quantity': 1,
                                }));
                              },
                              onDecrement: () {
                                BlocProvider.of<CartsBloc>(context).add(AddCartEvent(cartDetails: {
                                  'p_product_id': products[index]['id'],
                                  'p_quantity': -1,
                                }));
                              },
                              counte: 0,
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: products.length,
                        )
                      ],
                    ),
                    childCount: 1,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
