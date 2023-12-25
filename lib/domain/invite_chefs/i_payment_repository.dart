// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/invite_chefs/subscription_response.dart';
import 'package:widgets_book/widgets_book.dart';
import 'package:fpdart/fpdart.dart';

abstract class IPaymentRepository {
  Future<Map<String, dynamic>> createCustomer({required String customerName});
  Future<Map<String, dynamic>> createProduct({required String productName});

  Future<Map<String, dynamic>> createPrice({
    required String price,
    required String currency,
    required String productId,
  });

  Future<Map<String, dynamic>> createSubscription({
    required String priceId,
    required String customerId,
  });

  Future<Map<String, dynamic>> setPaymentMethodPerSubscription(
      {required String subscriptionId});

  Future<Either<ApiError, SubscriptionResponse>> getAllSupscriptions();

  Future<void> cancelSubscription({required String subscriptionId});

  Future<void> deleteProduct({required String productId});

  Future<void> deleteCustomer({required String customerId});
}
