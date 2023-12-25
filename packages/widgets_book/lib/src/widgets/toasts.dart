import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class Toasts {
  late FToast fToast = FToast();

  void showToast(
    BuildContext context, {
    required AlertType type,
    required String title,
    required String description,
    VoidCallback? onCloseAlert,
    Widget? prefixWidget,
    double? width,
        ToastGravity ? gravity,
  }) {
    fToast.init(context);
    final Widget toast = Stack(
      children: [
        Container(
          width: width ?? context.width-50,
          padding: EdgeInsets.only(
            left: 16.w,
            right: 9.w,
            top: 16.w,
            bottom: 16.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: type == AlertType.Error ? AppColors.rose : AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (prefixWidget != null)
                Expanded(
                  flex: 2,
                  child: prefixWidget,
                ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StandardText.subtitle2(
                      context,
                      title,
                      color: type == AlertType.Error
                          ? AppColors.primary
                          : AppColors.black,
                      letterSpacing: -0.40,
                      fontSize: 14.sp,
                    ),
                    StandardText.subtitle2(
                      context,
                      description,
                      fontWeight: AppFontWeight.regular,
                      color: type == AlertType.Error
                          ? AppColors.primary
                          : const Color(0xFF525252),
                      letterSpacing: -0.40,
                      fontSize: 13.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: fToast.removeCustomToast,
            icon: Icon(
              Icons.close,
              size: 16,
              color: type == AlertType.Error
                  ? AppColors.primary
                  : const Color(0xFF535353),
            ),
          ),
        ),
      ],
    );
    fToast
      ..removeQueuedCustomToasts()
      ..showToast(
        child: toast,
        gravity: ToastGravity.TOP_RIGHT,
        toastDuration: const Duration(
          seconds: 6,
        ),
      );
  }

  void showWebToast(
    BuildContext context, {
    required AlertType type,
    required String title,
    required String description,
    VoidCallback? onCloseAlert,
    Widget? prefixWidget,
    double? width,
        ToastGravity? gravity,
  }) {
    fToast.init(context);
    final Widget toast = Stack(
      children: [
        Container(
          width: width ?? double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: type == AlertType.Error ? AppColors.rose : AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              if (prefixWidget != null)
                Expanded(
                  flex: 2,
                  child: prefixWidget,
                ),
              Expanded(
                flex: 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StandardText.subtitle2(
                      context,
                      title,
                      color: type == AlertType.Error
                          ? AppColors.primary
                          : AppColors.black,
                      letterSpacing: -0.40,
                      fontSize: 14.sp,
                    ),
                    StandardText.subtitle2(
                      context,
                      description,
                      fontWeight: AppFontWeight.regular,
                      color: type == AlertType.Error
                          ? AppColors.primary
                          : const Color(0xFF525252),
                      letterSpacing: -0.40,
                      fontSize: 13.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: fToast.removeCustomToast,
            icon: Icon(
              Icons.close,
              size: 16,
              color: type == AlertType.Error
                  ? AppColors.primary
                  : const Color(0xFF535353),
            ),
          ),
        ),
      ],
    );
    fToast
      ..removeQueuedCustomToasts()
      ..showToast(
        child: toast,
        gravity: gravity??ToastGravity.TOP_RIGHT,
        toastDuration: const Duration(
          seconds: 6,
        ),
      );
  }
}
