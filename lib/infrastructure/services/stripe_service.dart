// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:menumaster_manager/domain/invite_chefs/subscription_response.dart';
import 'package:widgets_book/widgets_book.dart';
import 'package:fpdart/fpdart.dart';

Map<String, String> headers = {
  'Authorization':
      'Bearer sk_test_51NcyDGGQJrB4i0ytaDbnDG4ymAP1Q2fDXSPv6g2Y5DxK2JB66guQQKaHY8SQ94us5IS3tcIf0MEmkFXoDSo8mLIu00v2DPcO5e',
  'Content-Type': 'application/x-www-form-urlencoded'
};

class StripeService {
  Future<Map<String, dynamic>> createCustomer(String customerName) async {
    const String url = 'https://api.stripe.com/v1/customers';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: {'description': customerName},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to register as a customer.';
    }
  }

  Future<Map<String, dynamic>> createProduct({
    required String productName,
  }) async {
    const String url = 'https://api.stripe.com/v1/products';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'name': productName,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // print(json.decode(response.body));
      throw 'Failed to create PaymentMethod.';
    }
  }

  Future<Map<String, dynamic>> createPrice({
    required String price,
    required String currency,
    required String productId,
  }) async {
    const String url = 'https://api.stripe.com/v1/prices';
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'unit_amount': price,
        'currency': currency,
        'product': productId,
        'recurring[interval]': 'month'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to create PaymentMethod.';
    }
  }

  Future<Map<String, dynamic>> createSubscriptions(
      {required String customerId, required String priceId}) async {
    const String url = 'https://api.stripe.com/v1/subscriptions';

    Map<String, dynamic> body = {
      'customer': customerId,
      'items[0][price]': priceId,
    };

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to register as a subscriber.';
    }
  }

  Future<Map<String, dynamic>> setPaymentMethodPerSubscription(
      {required String subscriptionId}) async {
    final String url =
        'https://api.stripe.com/v1/subscriptions/$subscriptionId';

    Map<String, dynamic> body = {
      'payment_settings[payment_method_types][]': 'card',
    };

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to register as a subscriber.';
    }
  }

  Future<Either<ApiError, SubscriptionResponse>> getAllSubscriptions() async {
    try {
      const String url = 'https://api.stripe.com/v1/subscriptions';

      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // return json.decode(response.body);
        final subscriptions = SubscriptionResponse.fromJson(
          jsonDecode(response.body),
        );
        print(subscriptions.data?.length ?? -1);
        return right(subscriptions);
      } else {
        return left(ApiError(message: 'Failed to invite'));
      }
    } catch (e) {
      return left(ApiError(message: e.toString()));
    }
  }

  Future<Map<String, dynamic>> cancelSubscription(
      {required String subscriptionId}) async {
    final String url =
        'https://api.stripe.com/v1/subscriptions/$subscriptionId';

    var response = await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to cancel subscription';
    }
  }

  Future<Map<String, dynamic>> deleteProduct(
      {required String productId}) async {
    final String url = 'https://api.stripe.com/v1/products/$productId';

    var response = await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to delete product';
    }
  }

  Future<Map<String, dynamic>> deleteCustomer(
      {required String customerId}) async {
    final String url = 'https://api.stripe.com/v1/customers/$customerId';

    var response = await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to delete customer';
    }
  }
}
