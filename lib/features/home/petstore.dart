import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets.dart/custom_search.dart';
import 'shop_detailed_list_page.dart';
import 'shops_bloc/shops_bloc.dart';

class PetStoreScreen extends StatefulWidget {
  @override
  State<PetStoreScreen> createState() => _PetStoreScreenState();
}

class _PetStoreScreenState extends State<PetStoreScreen> {
  final ShopsBloc _shopBloc = ShopsBloc();

  @override
  initState() {
    _shopBloc.add(GetAllShopsEvent(params: {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopsBloc>.value(
      value: _shopBloc,
      child: BlocConsumer<ShopsBloc, ShopsState>(
        listener: (context, shopsState) {
          if (shopsState is ShopsFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load pet stores, Try Again!'),
              ),
            );
          }
        },
        builder: (context, shopsState) {
          return Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(
              //     left: 16,
              //     right: 16,
              //   ),
              //   child: CustomSearch(
              //     onSearch: (sp) {

              //     },
              //   ),
              // ),
              if (shopsState is ShopsLoadingState)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (shopsState is ShopsGetSuccessState)
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: shopsState.shops.length,
                    itemBuilder: (context, index) {
                      final store = shopsState.shops[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ShopDetailedListPage(
                                  shop: shopsState.shops[index],
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.0)),
                                child: Image.network(
                                  store['image_url']!,
                                  height: 170,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  store['name']!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
