import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitialState()) {
    on<OrdersEvent>((event, emit) async {
      try {
        emit(OrdersLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder table = supabaseClient.from('orders');

        if (event is GetAllOrdersEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query = table
              .select('*,order_items(*,canteen_products(*,canteens(*)))')
              .eq('customer_user_id', supabaseClient.auth.currentUser!.id);

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          if (event.params['status'] == 'Completed') {
            query = query.eq('status', event.params['status']);
          }

          List<Map<String, dynamic>> orders = await query.order('id', ascending: true);

          emit(OrdersGetSuccessState(orders: orders));
        } else if (event is AddOrderEvent) {
          event.orderDetails['p_user_id'] = supabaseClient.auth.currentUser!.id;
          await supabaseClient.rpc('order_now_v2');
          // await supabaseClient.rpc('create_new_order_from_cart',
          //     params: event.orderDetails);
          emit(OrdersSuccessState());
        } else if (event is EditOrderEvent) {
          await table.update(event.orderDetails).eq('id', event.orderId);

          emit(OrdersSuccessState());
        } else if (event is DeleteOrderEvent) {
          await table.delete().eq('id', event.orderId);
          emit(OrdersSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(OrdersFailureState());
      }
    });
  }
}
