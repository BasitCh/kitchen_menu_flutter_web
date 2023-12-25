// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:menumaster_manager/domain/invite_chefs/i_payment_repository.dart';
import 'package:menumaster_manager/domain/invite_chefs/subscription_response.dart';
import 'package:menumaster_manager/infrastructure/services/stripe_service.dart';
import 'package:widgets_book/src/helper/network/domain/api_error.dart';

class PaymentRepository extends IPaymentRepository {
  final StripeService stripeService;

  PaymentRepository({required this.stripeService});

  @override
  Future<Map<String, dynamic>> createProduct({required String productName}) =>
      stripeService.createProduct(productName: productName);

  @override
  Future<Map<String, dynamic>> createPrice({
    required String price,
    required String currency,
    required String productId,
  }) =>
      stripeService.createPrice(
        price: price,
        currency: currency,
        productId: productId,
      );

  @override
  Future<Map<String, dynamic>> createCustomer({required String customerName}) =>
      stripeService.createCustomer(customerName);

  @override
  Future<Map<String, dynamic>> createSubscription(
          {required String priceId, required String customerId}) =>
      stripeService.createSubscriptions(
        customerId: customerId,
        priceId: priceId,
      );

  @override
  Future<Map<String, dynamic>> setPaymentMethodPerSubscription(
          {required String subscriptionId}) =>
      stripeService.setPaymentMethodPerSubscription(
          subscriptionId: subscriptionId);

  @override
  Future<Either<ApiError, SubscriptionResponse>> getAllSupscriptions() =>
      stripeService.getAllSubscriptions();

  @override
  Future<void> cancelSubscription({required String subscriptionId}) =>
      stripeService.cancelSubscription(subscriptionId: subscriptionId);

  @override
  Future<void> deleteProduct({required String productId}) =>
      stripeService.deleteProduct(productId: productId);

  @override
  Future<void> deleteCustomer({required String customerId}) =>
      stripeService.deleteCustomer(customerId: customerId);
}
