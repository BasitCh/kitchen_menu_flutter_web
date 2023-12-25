// ignore_for_file: avoid_web_libraries_in_flutter, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:widgets_book/widgets_book.dart';

class ProfileFileCubit extends Cubit<Uint8List?> {
  ProfileFileCubit() : super(null);

  final _toast = Toasts();
  Uint8List? bytesFromPicker;

  Future<void> getImage(BuildContext context) async {
    try {
      bytesFromPicker = await ImagePickerWeb.getImageAsBytes();

      if (bytesFromPicker != null) {
        emit(bytesFromPicker);
      }
    } on PlatformException catch (e) {
  
      _toast.showWebToast(context,
       width: context.width / 4,
          type: AlertType.Info, title: 'Info', description: '${e.message}');
      if (e.code == 'camera_access_denied') {
        debugPrint("I am not allowed to take photos");
      }
      // print('ImageException is: ${e.toString()}');
    }
  }

  dispose() {
    emit(null);
  }
}
