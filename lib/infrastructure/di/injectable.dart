// ignore_for_file: depend_on_referenced_packages
import 'package:menumaster_manager/domain/auth/i_auth_repository.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/domain/services/storage/i_storage_repository.dart';
import 'package:menumaster_manager/infrastructure/auth/firebase_auth_repository.dart';
import 'package:menumaster_manager/infrastructure/services/firebase_storage_service.dart';
import 'package:menumaster_manager/infrastructure/services/firestore_service.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

final GetIt getIt = GetIt.instance;
final firebaseAuth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

void registerServices() {
  getIt.registerSingleton<NavigationService>(GoRouterNavigationService());
  getIt.registerSingleton<IAuthRepository>(FirebaseAuthRepository(
    firebaseAuth,
  ));
  getIt.registerSingleton<ICloudFirestoreRepository>(
    FirestoreService(firestore),
  );
  getIt.registerSingleton<IStorageRepository>(
    FirebaseStorageRepository(firebaseStorage),
  );
  getIt.registerSingleton<Toasts>(Toasts());
}
