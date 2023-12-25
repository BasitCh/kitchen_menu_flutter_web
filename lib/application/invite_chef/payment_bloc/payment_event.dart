part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class CreateStripePrice extends PaymentEvent {
  final String price;

  CreateStripePrice({required this.price});
}
