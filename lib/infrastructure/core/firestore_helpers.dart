// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreX on FirebaseFirestore {
  // Future<DocumentReference> userDocument() async {
  //   final userOption = await getIt<IAuthRepository>().getSignedInUser();
  //   final user = userOption.getOrElse(() => throw NotAuthenticatedError());
  //   return FirebaseFirestore.instance.collection('users').doc(
  //         user.id.getOrCrash(),
  //       );
  // }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
