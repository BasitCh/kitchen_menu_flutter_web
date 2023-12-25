import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:widgets_book/src/widgets/camera/app_camera_delegate.dart';
final ImagePicker _picker = ImagePicker();
class FileState {
  FileState({this.imageFiles});
  final List<XFile>? imageFiles;
}

class MultiCameraCubit extends Cubit<FileState> {
  MultiCameraCubit() : super(FileState());

  void changeState(List<XFile>? imageFiles) {
    emit(FileState(imageFiles: imageFiles));
  }

  Future<void> onImagePressed(
      BuildContext context,
      ValueChanged<List<XFile>?> onFileSelected,
      ) async {
    await _displayPickImageDialog(context,
            (double? maxWidth, double? maxHeight, int? quality) async {
          try {
            final pickedFile = await _picker.pickMultiImage(
              maxWidth: 512,
              maxHeight: 512,
              imageQuality: 1,
            );
            await _onFileSelected(pickedFile,context,
                onFileSelected,);
          } catch (e) {
            return;
          }
        });
  }
  Future<void> _onFileSelected(
      List<XFile>? xFile,
      BuildContext context,
      ValueChanged<List<XFile>?> onFileSelected,
      ) async {
    context.read<MultiCameraCubit>().changeState(xFile);
    onFileSelected(xFile);
  }
  Future<void> _displayPickImageDialog(
      BuildContext context,
      OnPickImageCallback onPick,
      ) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add optional parameters'),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('PICK'),
              onPressed: () {
                onPick(50, 50, 100);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
