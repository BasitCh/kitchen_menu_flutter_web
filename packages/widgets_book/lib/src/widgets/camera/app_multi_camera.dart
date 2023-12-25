import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppMultiCamera extends StatelessWidget {
  const AppMultiCamera({
    required this.selectedImageWidget,
    required this.unSelectedImageWidget,
    required this.cameraMultiImagesCubit,
    super.key,
  });

  final Widget unSelectedImageWidget;
  final Widget? selectedImageWidget;
  final CameraMultiImagesCubit cameraMultiImagesCubit;

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      selectedImageWidget: selectedImageWidget,
      unSelectedImageWidget: unSelectedImageWidget,
      cameraMultiImagesCubit: cameraMultiImagesCubit,
    );
  }
}

class AppWidget extends StatefulWidget {
  const AppWidget({
    required this.selectedImageWidget,
    required this.unSelectedImageWidget,
    required this.cameraMultiImagesCubit,
    super.key,
  });

  final Widget unSelectedImageWidget;
  final Widget? selectedImageWidget;
  final CameraMultiImagesCubit cameraMultiImagesCubit;

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraMultiImagesCubit, CameraMultipleImagesCubitState>(
      bloc: widget.cameraMultiImagesCubit,
        builder: (context, state) {
    return InkWell(
      onTap: (){
        if(state.images.isEmpty) {
          _onImagePressed(ImageSource.gallery, context);
        }
      },
      child: state.images.isEmpty
          ? widget.unSelectedImageWidget
          : widget.selectedImageWidget ?? Container(),
    );
        },
      );
  }

  Future<void> _onImagePressed(
    ImageSource source,
    BuildContext context,
  ) async {
    await context.read<CameraMultiImagesCubit>().getImages(context);
  }
}
