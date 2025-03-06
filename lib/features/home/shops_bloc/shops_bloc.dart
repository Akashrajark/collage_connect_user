import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'shops_event.dart';
part 'shops_state.dart';

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  ShopsBloc() : super(ShopsInitialState()) {
    on<ShopsEvent>((event, emit) async {
      try {
        emit(ShopsLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder table = supabaseClient.from('shops');

        if (event is GetAllShopsEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*,shop_products(*)');

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          if (event.params['status'] == 'Completed') {
            query = query.eq('status', event.params['status']);
          }

          List<Map<String, dynamic>> shops =
              await query.order('id', ascending: true);

          emit(ShopsGetSuccessState(shops: shops));
        } else if (event is AddShopEvent) {
          await supabaseClient.rpc('create_new_shop_from_cart', params: {
            'p_user_id': supabaseClient.auth.currentUser!.id,
            'p_status': 'Pending',
            'p_price': 10000,
          });
          emit(ShopsSuccessState());
        } else if (event is EditShopEvent) {
          await table.update(event.shopDetails).eq('id', event.shopId);

          emit(ShopsSuccessState());
        } else if (event is DeleteShopEvent) {
          await table.delete().eq('id', event.shopId);
          emit(ShopsSuccessState());
        } else if (event is GetCategoriesEvent) {
          List<Map<String, dynamic>> categories = await supabaseClient
              .from('categories')
              .select('*')
              .order('id', ascending: true);
          emit(CategoriesGetSuccessState(categories: categories));
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ShopsFailureState());
      }
    });
  }
}
