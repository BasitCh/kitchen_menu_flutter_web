import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/add_child_bloc/add_child_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/get_children_bloc/get_children_bloc.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/child_deleted_dialog.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object> showDeleteChildDialog(
    {required BuildContext context, required Child child}) async {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return BlocConsumer<AddChildBloc, AddChildState>(
        listener: (context, state) {
          if (state is ErrorRemovingChild) {
            Navigator.of(context).pop();
            // err dialog
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: StandardText.headline1(
                    context,
                    state.error,
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                ),
              );
          } else if (state is ChildRemoved) {
            Navigator.of(context).pop();
            showChildDeletedDialog(context: context, child: child);
            context.read<GetChildrenBloc>().add(GetChildren());
          }
        },
        builder: (context, state) {
          return Center(
            child: Container(
              width: 700,
              height: 580,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Scaffold(
                backgroundColor: AppColors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: state is RemovingChild
                                ? null
                                : () {
                                    getIt<NavigationService>()
                                        .navigateBack(context: context);
                                  },
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.black,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            50.verticalGap,
                            Assets.icons.deleteAlert.svg(),
                            30.verticalGap,
                            StandardText.headline6(
                              context,
                              'Remove ${child.childName}?',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                            20.verticalGap,
                            StandardText.subtitle3(
                                context, child.additionalNotes ?? ''),
                            20.verticalGap,
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: UITextStyle.subtitle3
                                    .copyWith(fontSize: 15),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Are you sure you want to remove',
                                  ),
                                  TextSpan(
                                    text: ' ${child.childName} ',
                                    style: UITextStyle.subtitle3.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const TextSpan(
                                    text: 'from the list?',
                                  ),
                                ],
                              ),
                            ),
                            40.verticalGap,
                            SizedBox(
                              width: kIsWeb
                                  ? context.width / 5
                                  : context.width / 3,
                              child: AppButton.outlinedDarkBorder(
                                onPressed: state is RemovingChild
                                    ? null
                                    : () {
                                        Navigator.of(context).pop();
                                      },
                                radius: 8,
                                child: StandardText.buttonLarge(
                                  'GO BACK',
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                            5.verticalGap,
                            SizedBox(
                              width: kIsWeb
                                  ? context.width / 5
                                  : context.width / 3,
                              child: state is RemovingChild
                                  ? const AppButtonLoading()
                                  : AppButton.darkRed(
                                      onPressed: () {
                                        context.read<AddChildBloc>().add(
                                              RemoveChild(child: child),
                                            );
                                      },
                                      radius: 8,
                                      child: StandardText.buttonLarge(
                                        'YES, REMOVE IT',
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        
        },
      );
    },
  );
}
