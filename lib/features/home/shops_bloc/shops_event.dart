part of 'shops_bloc.dart';

@immutable
sealed class ShopsEvent {}

class GetAllShopsEvent extends ShopsEvent {
  final Map<String, dynamic> params;

  GetAllShopsEvent({required this.params});
}

class AddShopEvent extends ShopsEvent {
  final Map<String, dynamic> shopDetails;

  AddShopEvent({
    required this.shopDetails,
  });
}

class EditShopEvent extends ShopsEvent {
  final Map<String, dynamic> shopDetails;
  final int shopId;

  EditShopEvent({
    required this.shopDetails,
    required this.shopId,
  });
}

class DeleteShopEvent extends ShopsEvent {
  final int shopId;

  DeleteShopEvent({required this.shopId});
}

class GetCategoriesEvent extends ShopsEvent {}
