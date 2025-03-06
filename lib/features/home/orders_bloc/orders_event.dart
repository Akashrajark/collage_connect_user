part of 'orders_bloc.dart';

@immutable
sealed class OrdersEvent {}

class GetAllOrdersEvent extends OrdersEvent {
  final Map<String, dynamic> params;

  GetAllOrdersEvent({required this.params});
}

class AddOrderEvent extends OrdersEvent {
  final Map<String, dynamic> orderDetails;

  AddOrderEvent({
    required this.orderDetails,
  });
}

class EditOrderEvent extends OrdersEvent {
  final Map<String, dynamic> orderDetails;
  final int orderId;

  EditOrderEvent({
    required this.orderDetails,
    required this.orderId,
  });
}

class DeleteOrderEvent extends OrdersEvent {
  final int orderId;

  DeleteOrderEvent({required this.orderId});
}
