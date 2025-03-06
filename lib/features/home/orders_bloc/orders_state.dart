part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitialState extends OrdersState {}

final class OrdersLoadingState extends OrdersState {}

final class OrdersSuccessState extends OrdersState {}

final class OrdersGetSuccessState extends OrdersState {
  final List<Map<String, dynamic>> orders;

  OrdersGetSuccessState({required this.orders});
}

final class OrdersFailureState extends OrdersState {
  final String message;

  OrdersFailureState({this.message = apiErrorMessage});
}
