part of 'shops_bloc.dart';

@immutable
sealed class ShopsState {}

final class ShopsInitialState extends ShopsState {}

final class ShopsLoadingState extends ShopsState {}

final class ShopsSuccessState extends ShopsState {}

final class ShopsGetSuccessState extends ShopsState {
  final List<Map<String, dynamic>> shops;

  ShopsGetSuccessState({required this.shops});
}

final class ShopsFailureState extends ShopsState {
  final String message;

  ShopsFailureState({this.message = apiErrorMessage});
}

final class CategoriesGetSuccessState extends ShopsState {
  final List<Map<String, dynamic>> categories;

  CategoriesGetSuccessState({required this.categories});
}
