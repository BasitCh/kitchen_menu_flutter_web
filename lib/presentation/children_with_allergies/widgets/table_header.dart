import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.only(top: 20.h, bottom: 10.h, left: 20.h, right: 20.h),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: StandardText.body2(context, 'Name',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack),
      
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: StandardText.body2(context, 'Room Name',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack),
      
          ),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: StandardText.body2(context, 'Allergies',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack),
      
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: StandardText.body2(context, '',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack),
      
          ),
        ],
      ),
    );
  }
}
