// ignore_for_file: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';

abstract class IStorageRepository{
  Future<Either<FirebaseException, String>> uploadImage({
    required String path,
    required Uint8List file,
});
}