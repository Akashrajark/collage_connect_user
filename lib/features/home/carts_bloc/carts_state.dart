part of 'carts_bloc.dart';

@immutable
sealed class CartsState {}

final class CartsInitialState extends CartsState {}

final class CartsLoadingState extends CartsState {}

final class CartsSuccessState extends CartsState {}

final class CartsGetSuccessState extends CartsState {
  final List<Map<String, dynamic>> carts;

  CartsGetSuccessState({required this.carts});
}

final class CartsFailureState extends CartsState {
  final String message;

  CartsFailureState({this.message = apiErrorMessage});
}
