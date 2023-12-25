// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/camera/app_camera_delegate.dart';
import 'package:widgets_book/src/widgets/camera/cubit/camera_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class AppCamera extends StatelessWidget {
  const AppCamera({
    required this.onFileSelected,
    super.key,
    this.width = 100,
    this.height = 100,
    this.color = AppColors.greyBg,
    this.imageUrl,
  });

  final double width;
  final double height;
  final Color? color;
  final ValueChanged<String?> onFileSelected;
  final String? imageUrl;

  //TODO: Handle Network image.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraCubit(),
      child: AppAvatar(
        width: width,
        height: height,
        color: color,
        imageUrl: imageUrl,
        onFileSelected: onFileSelected,
      ),
    );
  }
}

class AppAvatar extends StatefulWidget {
  const AppAvatar({
    required this.onFileSelected,
    super.key,
    this.width = 100,
    this.height = 100,
    this.color = AppColors.greyBg,
    this.imageUrl,
  });

  final double width;
  final double height;
  final Color? color;
  final String? imageUrl;
  final ValueChanged<String?> onFileSelected;

  @override
  State<AppAvatar> createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onImagePressed(ImageSource.gallery, context);
      },
      child: BlocBuilder<CameraCubit, FileState>(
        builder: (context, state) {
          return state.file == null
              ? Container(
                  alignment: Alignment.center,
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                  child: Assets.icons.addRecipe.svg(),
                )
              : Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(state.file!.path),
                      fit: BoxFit.cover,
                      width: widget.width,
                      height: widget.height,
                      errorBuilder: (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) =>
                          Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: widget.width,
                          height: widget.height,
                          decoration: BoxDecoration(
                            color: widget.color,
                            shape: BoxShape.circle,
                          ),
                          child: Assets.icons.addRecipe.svg(),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Future<void> _onImagePressed(
    ImageSource source,
    BuildContext context,
  ) async {
    await _displayPickImageDialog(context,
        (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 60,
        );
        await _onFileSelected(pickedFile, context);
      } catch (e) {
        return;
      }
    });
  }

  Future<void> _onFileSelected(
    XFile? xFile,
    BuildContext context,
  ) async {
    context.read<CameraCubit>().changeState(xFile);
    widget.onFileSelected(xFile?.path);
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
