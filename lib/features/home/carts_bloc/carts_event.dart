part of 'carts_bloc.dart';

@immutable
sealed class CartsEvent {}

class GetAllCartsEvent extends CartsEvent {
  final Map<String, dynamic> params;

  GetAllCartsEvent({required this.params});
}

class AddCartEvent extends CartsEvent {
  final Map<String, dynamic> cartDetails;

  AddCartEvent({required this.cartDetails});
}

class EditCartEvent extends CartsEvent {
  final Map<String, dynamic> cartDetails;
  final int cartId;

  EditCartEvent({
    required this.cartDetails,
    required this.cartId,
  });
}

class DeleteCartEvent extends CartsEvent {
  final int cartId;

  DeleteCartEvent({required this.cartId});
}
