// ignore_for_file: depend_on_referenced_packages
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/payment_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'remove_chef_event.dart';
part 'remove_chef_state.dart';

class RemoveChefBloc extends Bloc<RemoveChefEvent, RemoveChefState> {
  final ICloudFirestoreRepository iCloudFirestoreRepository;
  final PaymentRepository paymentRepository;

  RemoveChefBloc(
      {required this.iCloudFirestoreRepository,
      required this.paymentRepository})
      : super(RemoveChefInitial()) {
    on<RemoveChef>(_onRemoveChef);
  }

  Future<void> _onRemoveChef(
      RemoveChef event, Emitter<RemoveChefState> emit) async {
    emit(RemovingChef());
    try {
      final user = event.user;
      // cancel subscription if it is found on stripe
      if (user.subscriptionId != null && user.subscriptionId!.isNotEmpty) {
        await paymentRepository.cancelSubscription(
            subscriptionId: user.subscriptionId!);

        // delete stripe product
        // await paymentRepository.deleteProduct(
        //     productId: user.stripeProductId ?? '');

        // delete stripe customer
        // await paymentRepository.deleteCustomer(
        //     customerId: user.stripeCustomerId ?? '');
      }

      // it means the user is from invitation collection and we want to remove it
      if (user.invitedBy != null) {
        final CollectionReference reference = firestore
            .collection(FirestoreCollection.companies)
            .doc(user.companyId)
            .collection(FirestoreCollection.invitations);
        final response = await reference
            .where('subscription_id', isEqualTo: user.subscriptionId)
            .get();
        for (var doc in response.docs) {
          await reference.doc(doc.id).delete();
        }
      } else {
        user.companyId = '';
        user.stripePriceId = '';
        user.stripeCustomerId = '';
        user.stripeProductId = '';
        user.subscriptionId = '';
        user.subscriptionStatus = SubscriptionStatusEnum.Inactive.name;
        user.subscriptionType = SubscriptionType.free.name;
        user.isDeleted = true;

        // delete user from db and auth
        await iCloudFirestoreRepository.updateDocument(
          collectionName: FirestoreCollection.users,
          docId: user.id ?? '',
          object: user.toJson(),
        );
      }

      emit(
        ChefRemoved(),
      );
    } catch (e) {
      emit(
        ErrorRemovingChef(
          error: e.toString(),
        ),
      );
    }
  }
}
