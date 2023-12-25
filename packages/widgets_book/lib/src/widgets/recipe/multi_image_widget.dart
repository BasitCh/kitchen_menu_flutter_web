import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/recipe/cubit/multi_camera_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

// ignore: camel_case_types
class MultiImageUpload extends StatefulWidget {
  const MultiImageUpload({
    required this.imageFiles,
    required this.multiCameraCubit,
    super.key,
  });
  final MultiCameraCubit multiCameraCubit;
  final List<XFile>? imageFiles;

  @override
  State<MultiImageUpload> createState() => _MultiImageUploadState();
}

// ignore: camel_case_types
class _MultiImageUploadState extends State<MultiImageUpload> {
  ValueNotifier<int> index = ValueNotifier(0);
  late List<XFile>? imageFilesFinal;
  @override
  void initState() {
    imageFilesFinal = widget.imageFiles;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 8,
          child: ValueListenableBuilder<int>(
            valueListenable: index,
            builder: (context, value, child) {
              return Container(
                width: 582,
                height: 437,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.transparent),
                  image: DecorationImage(
                    image: NetworkImage(
                      imageFilesFinal?[value].path ?? '',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ),
        //const Spacer(),
        Flexible(
          flex: 2,
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(40),
                splashColor: AppColors.transparent,
                onTap: () {
                  // if(imageFilesFinal!.length<3){
                  widget.multiCameraCubit.onImagePressed(context, (value) {
                    value?.forEach(
                      (element) {
                        imageFilesFinal?.add(element);
                      },
                    );
                  });
                  // }
                },
                child: Assets.icons.icAdd.svg(),
              ),
              12.verticalGap,
              ListView.separated(
                itemCount: imageFilesFinal?.length ?? 0,
                shrinkWrap: true,
                separatorBuilder: (context, index) => 12.verticalGap,
                itemBuilder: (context, indexList) {
                  return GestureDetector(
                    onTap: () {
                      index.value = indexList;
                    },
                    child: Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            imageFilesFinal?[indexList].path ?? '',
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
