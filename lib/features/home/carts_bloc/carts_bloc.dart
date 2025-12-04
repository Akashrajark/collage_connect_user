import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'carts_event.dart';
part 'carts_state.dart';

class CartsBloc extends Bloc<CartsEvent, CartsState> {
  CartsBloc() : super(CartsInitialState()) {
    on<CartsEvent>((event, emit) async {
      try {
        emit(CartsLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder table = supabaseClient.from('cart');

        if (event is GetAllCartsEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*,canteen_products!inner(*)').eq('customer_user_id', supabaseClient.auth.currentUser!.id);

          if (event.params['query'] != null) {
            query = query.ilike(
              'name',
              '%${event.params['query']}%',
            );
          }

          List<Map<String, dynamic>> carts = await query.order(
            'id',
            ascending: true,
          );

          emit(CartsGetSuccessState(
            carts: carts,
          ));
        } else if (event is AddCartEvent) {
          event.cartDetails['p_customer_user_id'] = supabaseClient.auth.currentUser!.id;
          await supabaseClient.rpc('insert_or_update_cart', params: event.cartDetails);

          emit(CartsSuccessState());
          // } else if (event is EditCartEvent) {
          //   await supabaseClient.rpc('insert_or_update_cart',
          //       params: event.cartDetails);

          //   emit(CartsSuccessState());
          // } else if (event is DeleteCartEvent) {
          //   await table.delete().eq('id', event.cartId);
          //   emit(CartsSuccessState());
          //
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(CartsFailureState());
      }
    });
  }
}
