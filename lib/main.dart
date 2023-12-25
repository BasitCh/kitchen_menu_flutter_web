// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/menumaster_manager_app.dart';

Future<void> main() async {
  // firebase init for manager
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDDnK7UOFNsLBCp-EoqRkVJDVNBWqRtIbU",
      authDomain: "menu-master---prod.firebaseapp.com",
      projectId: "menu-master---prod",
      storageBucket: "menu-master---prod.appspot.com",
      messagingSenderId: "589816840162",
      appId: "1:589816840162:web:0f3cbbc44fd756bcc203bb",
      measurementId: "G-9870RX9BR3",
    ),
  );
  registerServices();
  runApp(
    const MenuMasterManagerApp(),
  );
}
