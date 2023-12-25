part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

class DoingPayment extends PaymentState {}

class ErrorPayment extends PaymentState {
  final String error;

  ErrorPayment({required this.error});
}

class StripePriceCreated extends PaymentState {}
