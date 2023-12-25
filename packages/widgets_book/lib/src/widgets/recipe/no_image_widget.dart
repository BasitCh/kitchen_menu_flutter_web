import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/recipe/cubit/multi_camera_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class MultipleAppCamera extends StatelessWidget {
  const MultipleAppCamera({
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
  final ValueChanged<List<XFile>?> onFileSelected;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MultiCameraCubit(),
      child: NoImage(
        onFileSelected: onFileSelected,
      ),
    );
  }
}
class NoImage extends StatefulWidget {
  const NoImage({required this.onFileSelected, super.key});
  final ValueChanged<List<XFile>?> onFileSelected;
  @override
  State<NoImage> createState() => _NoImageState();
}

class _NoImageState extends State<NoImage> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiCameraCubit, FileState>(
      builder: (context, state) {
        return state.imageFiles == null
            ? DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          dashPattern: const [10, 10],
          color: Colors.grey,
          strokeWidth: 2,
          child: SizedBox(
            width: context.width/2,
            height: 194,
            child: InkWell(
                onTap: (){
                  context.read<MultiCameraCubit>().onImagePressed(context,
                      widget.onFileSelected,);
                },
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    12.horizontalGap,
                    Assets.icons.icCamera.svg(),
                    StandardText.headline1(
                      context,
                      'Upload Photos',
                      color: AppColors.textBlack80,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    StandardText.headline1(
                      context,
                      '(tap to upload the photos)',
                      color: AppColors.textBlack80,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),),
          ),
        ) :MultiImageUpload(imageFiles: state.imageFiles,
          multiCameraCubit: context.read<MultiCameraCubit>(),);
      },
    );


  }


}
