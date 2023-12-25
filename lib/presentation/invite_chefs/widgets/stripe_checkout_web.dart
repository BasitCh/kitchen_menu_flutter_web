// ignore_for_file: depend_on_referenced_packages

@JS()
library stripe;

import 'package:js/js.dart';

Future<void> redirectToCheckout({
  required List<LineItem> lineItems,
}) async {
  final stripe = Stripe(
      'pk_test_51NcyDGGQJrB4i0ytAIZzcfASZQM33hr7eSlvvXKjuxh88d3uWFfvAP63jfVzUBAaB0lsf4oJrkGoHqg4DW4IQAEs00Fs6Ys3N1');
  stripe.redirectToCheckout(CheckoutOptions(
    lineItems: lineItems,
    mode: 'subscription',
    successUrl: 'https://manager-menumaster-prod.web.app/#/checkout_success',
    cancelUrl: 'https://manager-menumaster-prod.web.app/#/invite_chefs',
  ));
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
