import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: const BaseScaffold(
        body: NoInternetConnection(
          isWeb: true,
        ),
      ),
    );
  }
}
