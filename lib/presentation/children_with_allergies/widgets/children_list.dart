import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/child_details_dialog.dart';
import 'package:widgets_book/widgets_book.dart';

class ChildrenList extends StatelessWidget {
  const ChildrenList({super.key, required this.children});

  final List<Child> children;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      itemCount: children.length,
      itemBuilder: (shoppingContext, index) {
        Child child = children[index];
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 20.h,
          ),
          decoration: index.isOdd
              ? const BoxDecoration(
                  color: AppColors.lightGrey,
                )
              : null,
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: StandardText.subtitle3(
                    shoppingContext,
                    (child.childName ?? 'N/A').toTitleCase(),
                    // 'Butter',
                    fontSize: 16,
                    letterSpacing: .80,
                    color: AppColors.textBlack80,
                    // ingredient.name ?? '',
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: StandardText.body2(context, '${child.roomName}',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack),
              ),
              Flexible(
                flex: 6,
                fit: FlexFit.tight,
                child: StandardText.body2(
                    context, '${child.allergies?.join(', ')}',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    maxLines: 1,
                    color: AppColors.textBlack),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: AppColors.textBlack,
                    ),
                    onPressed: () {
                      showChildDetailsDialog(context: context, child: child);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
