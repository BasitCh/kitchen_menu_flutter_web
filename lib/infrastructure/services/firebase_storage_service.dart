// ignore_for_file: implementation_imports, depend_on_referenced_packages
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:menumaster_manager/domain/services/storage/i_storage_repository.dart';

@LazySingleton(as: IStorageRepository)
class FirebaseStorageRepository implements IStorageRepository {
  FirebaseStorageRepository(this._firebaseStorage);
  final FirebaseStorage _firebaseStorage;

  @override
  Future<Either<FirebaseException, String>> uploadImage({
    required String path,
    required Uint8List file,
  }) async {
    try {
      late String imageUrl;
    

      await _firebaseStorage
          .refFromURL('gs://menu-master-e3ac1.appspot.com')
          .child(path)
          // How to write path is as below:
          // .child('point-of-interest/$uid/$imageName')
          .putData(file)
          .then((TaskSnapshot val) async {
        imageUrl = await val.ref.getDownloadURL();
      });
      return right(imageUrl);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }
}
