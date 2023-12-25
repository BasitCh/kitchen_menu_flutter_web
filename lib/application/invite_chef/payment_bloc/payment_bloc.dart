// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:menumaster_manager/domain/invite_chefs/invite.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/payment_repository.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:menumaster_manager/presentation/invite_chefs/widgets/stripe_checkout_web.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository inviteRepository;

  PaymentBloc({required this.inviteRepository}) : super(PaymentInitial()) {
    on<CreateStripePrice>(_onCreateStripePrice);
  }

  Future<void> _onCreateStripePrice(
    CreateStripePrice event,
    Emitter<PaymentState> emit,
  ) async {
    emit(DoingPayment());
    try {
      final List<LineItem> lineItems = [];
      final List<Invite> chefsWithSubscriptionID = [];
      final appUser = await SharedPreferenceService.getUser();
      final chefs = await SharedPreferenceService.getChefsToBeInvited();

      for (Invite chef in chefs!) {
        // creating stripe customer
        final customer = await inviteRepository.createCustomer(
            customerName: chef.fullName ?? '');
        // creating product against each
        final product = await inviteRepository.createProduct(
            productName: '${chef.fullName ?? ''}\'s Subscription');
        final productPrice = await inviteRepository.createPrice(
          price: event.price,
          currency: appUser?.address?.countryName == 'New Zealand'
              ? 'NZD'
              : appUser?.address?.countryName == 'Australia'
                  ? 'AUD'
                  : 'NZD',
          productId: product['id'],
        );
        lineItems.add(
          LineItem(price: productPrice['id'], quantity: 1),
        );

        chef.stripeProductId = product['id'];
        chef.stripeCustomerId = customer['id'];
        chef.stripePriceId = productPrice['id'];
        chefsWithSubscriptionID.add(chef);
      }

      await SharedPreferenceService.saveInvitedChefs(chefsWithSubscriptionID);
      await redirectToCheckout(lineItems: lineItems); //:TOsDO
    } catch (e) {
      emit(
        ErrorPayment(error: 'Error making payment'),
      );
    }
  }
}
